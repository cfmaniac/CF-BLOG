/**
* I am a Post Entity
*/
component persistent="true" table="blog_Post" 
{
	/* ----------------------------------------- PROPERTIES -----------------------------------------  */
	/*
	Set up the persisted properties
	The first line refers to metadata for ColdFusion
	The second line refers to metadata required to create the database columns 
	*/
	
	/**
	* I am the unique identifier, which is numeric and generated for you
	*/
	property name="IDPost" fieldtype="id" generator="native" type="numeric" setter="false"
		ormtype="integer" notnull="true";
	/**
	* I am the title of the post which maps to the post_Title column in the database
	*/
	property name="Title" type="string" default=""
		ormtype="string" column="post_Title" length="500" notnull="true";
		
	property name="Slug" type="string" default=""
		ormtype="string" column="post_slug" length="500" notnull="true";	
	/**
	* I am the content of the post which maps to the post_Body column in the database
	* If you are using Oracle you'll need to change the ormtype
	*/
	property name="Body" type="string" default=""
		ormtype="text" column="post_Body" notnull="true";
	/**
	* I am the date and time of the post which maps to the post_DateTime column in the database
	*/
	property name="DateTime" type="date" default="{ts '1900-01-01 00:00:00'}"
		ormtype="date" column="post_DateTime" notnull="true";
	
	/*
	* Define Relationships between entities (Composition & aggregation)
	*/
	
	/**
	* I am the User entity relationship. Many Post entities can have one User, so use a many-to-one relationship
	*/ 
	property name="User" cfc="model.user.User" fieldtype="many-to-one" fkcolumn="IDUser";
	
	/**
	* I am the Comments entity relationship. One Post entity can have many Comments, so use a one-to-many relationship
	*/ 	
	property name="Comments" cfc="model.blog.Comment" fieldtype="one-to-many" type="array"
		fkcolumn="IDPost"; 
	
	/**
	* I am the Category entity relationship. One Post entity can have many Categories and one Category can have many Posts, so use a many-to-many relationship
	*/ 	
	property name="Categories" cfc="model.blog.Category" fieldtype="many-to-many" type="array"
		linktable="lnk_PostCategory" inversejoincolumn="IDPost" fkcolumn="IDCategory";
	
	/* ----------------------------------------- PUBLIC -----------------------------------------  */
	
	/*
	* I return a formatted date/time
	* @output false
	*/
	public string function getFormattedDateTime()
	{
		return DateFormat( getDateTime(), "dddd, dd mmm yy" );
	}
	
	/*
	* I am a helper method that returns the authors name (in accordance with law of demeter)
	* @output false
	*/
	public string function getAuthorName()
	{
		return getUser().getName();
	}
	/*
	* I remove all category associations
	* @output false
	*/
	public void function removeAllCategories()
	{
		if ( hasCategories() )
		{
			variables.Categories = [];
		}
	}
	/*
	* I return the number of comments for this post
	* @output false
	*/
	public numeric function getNumberOfComments()
	{
		return ArrayLen( getComments() );
	}
	
	/*
	* In built event handler method, which is called if you set ormsettings.eventhandler = true in Application.cfc
	*/
	public void function preInsert()
	{
		setDateTime( Now() );
	}

}