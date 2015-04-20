<!--- Document Information -----------------------------------------------------

Title:      editUser.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    edit a user

Usage:      

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		07/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
John Whish		20/07/2010		updated for CF9.01
------------------------------------------------------------------------------->
<cfparam name="url.id" type="numeric" />

<cfscript>
// Get a User Entity by primary key
User = EntityLoadByPK( "User", url.id );
	
if ( !StructIsEmpty( form ) )
{
	// set the new values 
	User.setName( form.name );
	User.setEmail( form.email );
	
	// save the new values
	transaction 
	{	
		EntitySave( User );
	}
	
	location( url="listUser.cfm" , addtoken="false" );
}
</cfscript>

<cfimport prefix="tags" taglib="tags">

<tags:wireframe>

<h1>tBlog - Edit User</h1>

<cfoutput>
<form method="post" action="editUser.cfm?ID=#url.id#">
	<label>Name</label>
	<input type="text" name="name" value="#User.getName()#" />
	<label>Email</label>
	<input type="text" name="email" value="#User.getEmail()#" />
	<input type="submit" value="Submit" />
</form>
</cfoutput>

</tags:wireframe>
