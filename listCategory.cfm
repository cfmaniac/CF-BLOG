<!--- Document Information -----------------------------------------------------

Title:      listCategory.cfm

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    list the categories

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
		categories = ListToArray( form.IDCategory );

		transaction 
		{
			//get each category and delete it
			for( categoryid in categories )
			{
				Category = EntityLoadByPK( "Category", categoryid );
				EntityDelete( Category );
			}
		}
	}
	
	//use the inbuilt listing capabilities to provide the list
	categories = EntityLoad( "Category", {parentID=0}, "orderIndex" );
</cfscript>

<cfoutput>
<h1>tBlog - List Categories</h1>

<form action="listCategory.cfm" method="post">
<table>
	<thead>
		<tr>
			<th colspan="2">Name</th>
			<th>OrderIndex</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#categories#" index="Category">
		<cfscript>
			SubCats = EntityLoad('Category', {parentID='#Category.getIDCategory()#'} , "OrderIndex");
			
		</cfscript>
			<tr>
				<td>
					<input type="checkbox" name="IDCategory" value="#Category.getIDCategory()#" />
				</td>
				<td>
					<a href="editCategory.cfm?ID=#Category.getIDCategory()#">#Category.getName()#</a>
				</td>
				<td>
					#Category.getOrderIndex()#
				</td>
			</tr>
			<cfif arrayLen(SubCats)>
			<cfloop array="#SubCats#" index="SubCats">
				<tr>
				<td>
					<input type="checkbox" name="IDCategory" value="#SubCats.getIDCategory()#" />
				</td>
				<td>
					<a href="editCategory.cfm?ID=#SubCats.getIDCategory()#">#SubCats.getName()#</a>
				</td>
				<td>
					#SubCats.getOrderIndex()#
				</td>
			</tr>
			</cfloop>
			</cfif>
		</cfloop>
	</tbody>
</table>

<input type="submit" value="Delete Category" />
</form>

</cfoutput>


</tags:wireframe>
