/**
* I am a Category Entity
*/
component persistent="true" table="blog_Category" 
{
	/*
	Set up the persisted properties
	The first line refers to metadata for ColdFusion
	The second line refers to metadata required to create the database columns 
	*/
	
	/**
	* I am the unique identifier, which is numeric and generated for you
	*/
	property name="IDCategory" fieldtype="id" generator="native" type="numeric" setter="false"
		ormtype="integer" notnull="true";
	/**
	* I am the name of the category which maps to the category_Name column in the database
	*/
	property name="Name" type="string" default=""
		column="category_Name" ormtype="string" length="200" notnull="true";
		
	property name="Slug" type="string" default=""
		ormtype="string" column="category_slug" length="500" notnull="true";	
		
	/**
	* I am the specify the sort order which maps to the category_OrderIndex column in the database
	*/
	property name="parentID" type="numeric" default="0" 
		column="category_parent" ormtype="integer" notnull="true";
		
	property name="OrderIndex" type="numeric" default="0" 
		column="category_OrderIndex" ormtype="integer" notnull="true";
		
	/**
	* I am the Post entity relationship. One Category entity can have many Posts and one Post can have many Categories, so use a many-to-many relationship
	*/ 	
	property name="Posts" cfc="model.post.Post" fieldtype="many-to-many" type="array"
		linktable="lnk_PostCategory" inversejoincolumn="IDCategory" fkcolumn="IDPost";
}