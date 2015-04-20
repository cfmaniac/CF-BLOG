/**
* I am a User Entity
*/
component persistent="true" table="tbl_User" 
{
	/*
	Set up the persisted properties
	The first line refers to metadata for ColdFusion
	The second line refers to metadata required to create the database columns 
	*/
	
	/**
	* I am the unique identifier, which is numeric and generated for you
	*/
	property name="IDUser" fieldtype="id" generator="native" type="numeric" setter="false"
		ormtype="integer" notnull="true";
	/**
	* I am the Name of the User which maps to the user_Name column in the database
	*/
	property name="Name" type="string" default=""
		ormtype="string" column="user_Name" length="200" notnull="true";
	/**
	* I am the Email Address of the User which maps to the user_Email column in the database
	*/
	property name="Email" type="string" default=""
		ormtype="string" column="user_Email" length="200" notnull="true";
}