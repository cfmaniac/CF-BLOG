<!--- Document Information -----------------------------------------------------

Title:      listPost.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    list the posts for editing

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
	//self submitting form
	if( !StructIsEmpty( form ) )
	{
		posts = ListToArray( form.IDpost );
		
		transaction 
		{
			//get each post, then delete it
			for( postid in posts )
			{
				Post = EntityLoadByPK( "Post", postid );
				EntityDelete( Post );
			}
		}
	}

	//get all posts
	posts = EntityLoad( "Post", {}, "DateTime" );
</cfscript>

<cfoutput>
<h1>tBlog - List Posts</h1>

<form method="post">
<table>
	<thead>
		<tr>
			<th colspan="2">Title</th>
			<th>Date</th>
			<th>Author</th>
			<th>Comments</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#posts#" index="Post">
			<tr>
				<td>
					<input type="checkbox" name="IDPost" value="#Post.getIDPost()#" />
				</td>
				<td>
					<a href="editPost.cfm?ID=#Post.getIDPost()#">#Post.getTitle()#</a>
				</td>
				<td>
					#Post.getFormattedDateTime()#
				</td>
				<td>
					#Post.getAuthorName()#
				</td>
				<td>
					#numberFormat(arraylen(Post.getComments()))#
				</td>
			</tr>
		</cfloop>
	</tbody>
</table>

<input type="submit" value="Delete Posts" />
</form>

</cfoutput>

</tags:wireframe>