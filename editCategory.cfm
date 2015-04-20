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
<cfparam name="url.id" type="numeric" />

<!--- self submitting form --->
<cfscript>
	// get the category entity for the object
	Category = EntityLoadByPK( "Category", url.id );
	ParentCats = EntityLoad('Category', {parentID='0'} , {});
	
	
	
	
	//update the category
	if( !StructIsEmpty( form ) )
	{
		Category.setName( form.name );
		Category.setParentID( form.parentID );
		Category.setOrderIndex( form.orderIndex );
		
		// transactions are fixed in 9.01
		transaction 
		{
			// update entity
			EntitySave( Category );
		}
		
		location( url="listCategory.cfm" , addtoken="false" );
	}
</cfscript>

<cfimport prefix="tags" taglib="tags"><tags:wireframe>

<h1>tBlog - Edit Category</h1>

<form method="post">
	<label>Name</label>
	<cfoutput>
	<input type="text" name="name" value="#Category.getName()#" />
	<label>Parent Category</label>
	<select name="parentID">
	<option value="0">None - Root Category</option>
	<cfoutput>
		<cfloop array="#ParentCats#" index="Parents">
			<option <cfif Category.getParentID() EQ Parents.getIDCategory() >
					selected = "selected"
				</cfif> value="#Parents.getIDCategory()#">#Parents.getName()#</option>
		</cfloop>
	</cfoutput>
	</select>
	
	<label>OrderIndex</label>
	<select name="orderIndex">
	<cfoutput>
		<cfloop from="1" to="100" index="counter">
			<option <cfif #counter# EQ Category.getOrderIndex()>selected="selected"</cfif> value="#counter#">#counter#</option>
		</cfloop>
	</cfoutput>
	</select>
	
	</cfoutput>
	<input type="submit" value="Submit" />
	
</form>

</tags:wireframe>

