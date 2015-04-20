<!--- Document Information -----------------------------------------------------

Title:      addPost.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    add a post

Usage:      

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		07/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
John Whish		20/07/2010		updated for CF9.01
------------------------------------------------------------------------------->
<cfimport prefix="tags" taglib="tags"><tags:wireframe>

<cfscript>
	//self submitting
	if( !StructIsEmpty( form ) )
	{
		//create an empty post
		Post = EntityNew( "Post" );
		
		Post.setTitle( form.title );
		Post.setBody( form.body );
		
		//get a user entity by the identity
		User = EntityLoadByPK( "User", form.user );
		
		// assign the user to the post
		Post.setUser( User );
		
		//loop through the categories and add them
		categories = listToArray( form.category );

		for( catid in categories )
		{
			// load the category entity
			Category = EntityLoadByPK( "Category", catid );
			// associate the category to the post
			Post.addCategories( Category );
		}
		
		// transactions are fixed in 9.01
		transaction 
		{
			// save the post
			EntitySave( Post );
		}
		
		location( url="listPost.cfm" , addtoken="false" );
	}
	
	// get an array of all user entities sorted by name
	users = EntityLoad( "User", {}, "name" );
	// get an array of all category entities sorted by name
	categories = EntityLoad( "Category", {}, "name" );
</cfscript>

<h1>tBlog - Add Post</h1>

<cfoutput>

<form method="post">
	<label>Title</label>
	<input type="text" name="title" />
	<label>Body</label>
	<textarea name="body"></textarea>
	<label>Category</label>	
	<ul>
	<cfloop array="#Categories#" index="Category">
		<li>
			<input type="checkbox" name="category" value="#Category.getIDCategory()#" />#Category.getName()#
		</li>
	</cfloop>
	</ul>
	<label>Author</label>
	<select name="user">
		<cfloop array="#users#" index="User">
			<option value="#User.getIDUser()#">#User.getName()#</option>
		</cfloop>
	</select>

	<input type="submit" value="Submit" />

</form>
</cfoutput>

</tags:wireframe>
