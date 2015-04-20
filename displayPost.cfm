<!--- Document Information -----------------------------------------------------

Title:      displayPost.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    display a single post

Usage:      

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		07/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
John Whish		20/07/2010		updated for CF9.01
------------------------------------------------------------------------------->
<cfimport prefix="tags" taglib="tags"><tags:wireframe>
<cfparam name="url.id" type="numeric" />

<cfscript>
	//grab the post to display
	Post = EntityLoadByPK( "Post", url.id );
	
	//self submitting - add comment
	if( !StructIsEmpty( form ) )
	{
		// get a new comment entity
		Comment = EntityNew( "Comment" );
		
		// set properties
		Comment.setName( form.name );
		Comment.setValue( form.comment );
		Comment.setPost( Post );
		
		// transactions are fixed in 9.01
		transaction 
		{
			// save the comment
			EntitySave( Comment );
		}
	}
</cfscript>


<h1>tBlog - Transfer Blog Example Application</h1>
<cfoutput>
<div class="post">
<h2><a href="displayPost.cfm?ID=#Post.getIDPost()#">#Post.getTitle()#</a></h2>
<div class="postDate">
	Posted on 
		#Post.getFormattedDateTime()#
	 by #Post.getAuthorName()#
</div>
<div class="postBody">
	#ReReplace( Post.getBody(), "\n", "<br />", "all" )#
</div>
<ul>
	<cfloop array="#Post.getCategories()#" index="Category">
		<li><a href="showPostByCategory.cfm?ID=#Category.getIDCategory()#">#Category.getName()#</a></li>
	</cfloop>
</ul>
<div class="comments">
	Comments (#Post.getNumberOfComments()#)
	<ul>
	<!--- display all current comments --->
	<cfloop array="#Post.getComments()#" index="Comment">
		<li>
			#Comment.getName()# wrote on 
				#DateFormat( Comment.getDateTime(), "dd mmm yy" )#
				#TimeFormat( Comment.getDateTime(), "hh:mm:ss tt" )#
			:<br />
			#ReReplace( Comment.getValue(), "\n", "<br />", "all" )#
		</li>
	</cfloop>
	</ul>
</div>
<div class="addComment">
	<p>
	Add Comment
	</p>
	<form action="displayPost.cfm?id=#Post.getIDPost()#" method="post">
		<label>Name</label>
		<input type="text" name="name" />
		<label>Comment</label>
		<textarea name="comment"></textarea>
		<input type="submit" value="Add Comment" />
	</form>
</div>
</div>
</cfoutput>

</tags:wireframe>