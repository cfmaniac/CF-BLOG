<!--- Document Information -----------------------------------------------------

Title:      editPost.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    list and edit posts

Usage:

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		07/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
John Whish		20/07/2010		updated for CF9.01
------------------------------------------------------------------------------->
<cfimport prefix="tags" taglib="tags"><tags:wireframe>
<cfparam name="url.id" type="numeric">

<cfscript>
	// get the post
	Post = EntityLoadByPK( "Post", url.id );

	// self submitting - update the post
	if( !StructIsEmpty( form ) )
	{
		Post.setTitle( form.title );
		Post.setBody( form.body );

		// set the user
		User = EntityLoadByPK( "User", form.user );
		
		// assign user to this post
		Post.setUser( User );

		// clear out the currently assigned categories
		Post.removeAllCategories();

		// loop through the categories and add them back in
		categories = ListToArray( form.category );
		
		for( catid in categories )
		{
			Category = EntityLoadByPK( "Category", catid );
			Post.addCategories( Category );
		}

		//delete the comments that are selected
		if( StructKeyExists( form, "IDComment" ) )
		{
			comments = ListToArray( form.IDComment );
			
			transaction 
			{
				for( commentid in comments )
				{
					Comment = EntityLoad( "Comment", commentid );
					//comment is removed implicitly from Post on delete
					EntityDelete( Comment );
				}

			}
		}

		// transactions are fixed in 9.01
		transaction 
		{
			EntitySave( Post );
		}
		
		location( url="listPost.cfm" , addtoken="false" );
	}

	//use the inbuilt listing capabilities to provide the array of objects
	users = EntityLoad( "User", {}, "Name" );
	categories = EntityLoad( "Category", {}, "orderIndex" );

	//let's make a list of category ID's so we have something
	//to check against for checkboxes
	lIDCategories = "";
	postcategories = Post.getCategories();
	
	for( counter = 1; counter <= ArrayLen(postcategories); counter++ )
	{
		Category = categories[ counter ];
		lIDCategories = ListAppend( lIDCategories, Category.getIDCategory() );
	}

</cfscript>

<h1>tBlog - Edit Post</h1>

<cfoutput>
<form method="post">
	<label>Title</label>
	<input type="text" name="title" value="#Post.getTitle()#" />
	<label>Body</label>
	<textarea name="body">#Post.getBody()#</textarea>
	<label>Category</label>
	<ul>
	<cfloop array="#categories#" index="Category">
		<li>

		<input type="checkbox" name="category"
				<cfif ListFind( lIDCategories, Category.getIDCategory() )>
					checked = "true"
				</cfif>
				value="#Category.getIDCategory()#">#Category.getName()#
		</li>
	</cfloop>
	</ul>
	
	<label>Author</label>
	<select name="user">
		<cfloop array="#users#" index="User">
			<option value="#User.getIDUser()#"
					<cfif User.getIDUser() eq Post.getUser().getIDUser()>selected="selected" </cfif>
					>#User.getName()#</option>
		</cfloop>
	</select>

	<label>Comments #numberformat(arrayLen(Post.getComments()))#</label>
	<ul>
	<!--- show all the comments in the post --->
	<cfloop array="#Post.getComments()#" index="Comment">
		<li>
			<input type="checkbox" name="IDComment" value="#Comment.getIDComment()#"/>
			#Comment.getName()# wrote on #Comment.getFormattedDateTime()#
			:<br/>
			#ReReplace( Comment.getValue(), "\n", "<br />", "all" )#
		</li>
	</cfloop>
	</ul>


	<input type="submit" value="Submit">

</form>
</cfoutput>

</tags:wireframe>

