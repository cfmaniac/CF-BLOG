/**
* I am a Comment Entity
*/
component persistent="true" table="blog_Comment"
{
	/* ----------------------------------------- PROPERTIES -----------------------------------------  */
	
	/**
	* I am the unique identifier, which is numeric and generated for you
	*/
	property name="IDComment" fieldtype="id" generator="native" type="numeric" setter="false"
		ormtype="integer" notnull="true";
	/**
	* I am the name of the person who posted the comment which maps to the comment_Name column in the database
	*/
	property name="Name" type="string" default=""
		ormtype="string" column="comment_Name" length="200" notnull="true";
	/**
	* I am the comment content which maps to the comment_Value column in the database
	*/
	property name="Value" type="string" default=""
		ormtype="string" column="comment_Value" length="500" notnull="true";
	/**
	* I am the date and time of the comment which maps to the comment_DateTime column in the database
	*/
	property name="DateTime" type="date" default="{ts '1900-01-01 00:00:00'}"
		ormtype="date" column="comment_DateTime" notnull="true";
	
	/**
	* I am the Post entity relationship. Many Comment entities can have one Post, so use a many-to-one relationship
	*/ 
	property name="Post" cfc="Post" fieldtype="many-to-one" 
		fkcolumn="IDPost";
		
	/* ----------------------------------------- PUBLIC -----------------------------------------  */
	
	/*
	* I return a formatted date/time
	* @output false
	*/
	public string function getFormattedDateTime()
	{
		return DateFormat( getDateTime(), "dddd, dd mmm yy" );
	}
}