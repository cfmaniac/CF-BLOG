<!--- Document Information -----------------------------------------------------

Title:      addCategory.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    add a Category

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
	ParentCats = EntityLoad('Category', {parentID='0'} , {});
	
	if( !StructIsEmpty( form ) )
	{
		//create an empty category
		Category = EntityNew( "Category" );
		
		// set properties
		Category.setName( form.name );
		Category.setParentID( form.parentID );
		Category.setOrderIndex( form.orderIndex );
		

		// transactions are fixed in 9.01
		transaction 
		{
			// save the new category
			EntitySave( Category );
		}
		
		location( url="listCategory.cfm", addtoken="false" );
	}
</cfscript>

<cfimport prefix="tags" taglib="tags"><tags:wireframe>

<h1>tBlog - Add Category</h1>

<form method="post">
	<label>Name</label>
	<input type="text" name="name" />
	<label>Parent Category</label>
	<select name="parentID">
	<option value="0">None - Root Category</option>
	<cfoutput>
		<cfloop array="#ParentCats#" index="Parents">
			<option value="#Parents.getIDCategory()#">#Parents.getName()#</option>
		</cfloop>
	</cfoutput>
	</select>
	<label>OrderIndex</label>
	<select name="orderIndex">
	
	<cfoutput>
		<cfloop from="1" to="100" index="counter">
			<option value="#counter#">#counter#</option>
		</cfloop>
	</cfoutput>
	</select>
	<input type="submit" value="Submit" />
</form>

</tags:wireframe>

