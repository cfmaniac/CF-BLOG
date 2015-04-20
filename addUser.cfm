<!--- Document Information -----------------------------------------------------

Title:      addUser.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    Add a User

Usage:      

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		07/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
John Whish		20/07/2010		updated for CF9.01
------------------------------------------------------------------------------->
<!--- self submitting form --->
<cfscript>

	//edit the user
	if( !StructIsEmpty(form) )
	{
		// create a new user
		User = EntityNew( "User" );
		
		// set properties
		User.setName( form.name );
		User.setEmail( form.email );
		
		// transactions are fixed in 9.01
		transaction 
		{
			// save the new user
			EntitySave( User );
		}
		
		location( url="listUser.cfm" , addtoken="false" );
	}
</cfscript>

<cfimport prefix="tags" taglib="tags"><tags:wireframe>

<h1>tBlog - Add User</h1>

<form method="post">
	<label>Name</label>
	<input type="text" name="name" />
	<label>Email</label>
	<input type="text" name="email" />
	<input type="submit" value="Submit" />
</form>

</tags:wireframe>
