<!--- Document Information -----------------------------------------------------

Title:      listUser.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    list the users

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
		users = ListToArray( form.IDUser );
		
		transaction 
		{
			//get each user, and delete them
			for( userid in users )
			{
				User = EntityLoadByPK( "User", userid );
				EntityDelete( User );
			}
		}
	}
	
	//get an array of all User entities ordered by name
	users = EntityLoad( "User", {}, "Name" );
</cfscript>

<cfoutput>
<h1>tBlog - List Users</h1>

<form method="post">
<table>
	<thead>
		<tr>
			<th colspan="2">Name</th>
			<th>Email</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#users#" index="User">
			<tr>
				<td>
					<input type="checkbox" name="IDUser" value="#User.getIDUser()#" />
				</td>
				<td>
					<a href="editUser.cfm?ID=#User.getIDUser()#">#User.getName()#</a>
				</td>
				<td>
					#User.getEmail()#
				</td>
			</tr>
		</cfloop>
	</tbody>
</table>

<input type="submit" value="Delete Users" />
</form>
</cfoutput>

</tags:wireframe>
