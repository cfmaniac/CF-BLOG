<!--- Document Information -----------------------------------------------------

Title:      showPostByCategory.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    show posts by category

Usage:

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		08/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
John Whish		20/07/2010		updated for CF9.01
------------------------------------------------------------------------------->
<cfimport prefix="tags" taglib="tags"><tags:wireframe>
<cfparam name="url.id" type="numeric" />

<cfscript>
	//lets get the category to display
	Category = EntityLoadByPK( "Category", url.id );
	
	//lets get the posts in this category
	posts = Category.getPosts();
	
	// lets get all categories
	categories = EntityLoad( "Category", {}, "OrderIndex" );
</cfscript>

<cfoutput>
<h1>tBlog - #Category.getName()#</h1>
<!--- display categories --->
<div id="categories">
	Categories
	<ul>
	<cfloop array="#categories#" index="BlogCategory">
		<li><a href="showPostByCategory.cfm?ID=#BlogCategory.getIDCategory()#">#BlogCategory.getName()#</a></li>
	</cfloop>
	</ul>
</div>


<cfif !Category.hasPosts()>
<div class="postBody">Sorry, no posts in this category!</div>
<cfelse>
<!--- loop around posts, then inner loop by category --->
<cfloop array="#posts#" index="Post">
	<div class="post">
	<h2><a href="displayPost.cfm?ID=#Post.getIDPost()#">#Post.getTitle()#</a></h2>
	<div class="postDate">
		Posted on
			#Post.getFormattedDateTime()#
		by #Post.getAuthorName()#
	</div>
	<div class="postBody">
	#ReReplace( Post.getBody(), "\n", "<br/>", "all" )#
	</div>
	<ul>
		<cfloop array="#Post.getCategories()#" index="PostCategory">
			<li><a href="showPostByCategory.cfm?ID=#PostCategory.getIDCategory()#">#PostCategory.getName()#</a></li>
		</cfloop>
	</ul>
	</div>
</cfloop>
</cfif>


</cfoutput>

</tags:wireframe>

