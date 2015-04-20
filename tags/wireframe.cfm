<cfsilent>
<!--- Document Information -----------------------------------------------------

Title:      wireframe.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    wireframe for the site

Usage:      

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		07/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
------------------------------------------------------------------------------->
</cfsilent><cfif thisTag.ExecutionMode eq "start"><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<cfoutput>
		<title>tBlog - Transfer Blog Example Application</title>
		</cfoutput>
		<link rel="stylesheet" type="text/css" href="resources/css/index.css" />
	</head>
	<body>
	<div class="header">
		<ul>
			<li>
				<a href="index.cfm">Home</a>
			</li>
			<li>
				<a href="addPost.cfm">Add Post</a>
			</li>			
			<li>
				<a href="listPost.cfm">Edit Posts</a>
			</li>
			<li>
				<a href="addCategory.cfm">Add Category</a>
			</li>
			<li>
				<a href="listCategory.cfm">Edit Categories</a>
			</li>
			<li>
				<a href="addUser.cfm">Add User</a>
			</li>
			<li>
				<a href="listUser.cfm">Edit Users</a>
			</li>			
		</ul>
	</div>
<cfelse>			
	</body>
</html>
</cfif>	
