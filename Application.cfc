<!--- Document Information -----------------------------------------------------

Title:      Application.cfc

Author:     Mark Mandel
Email:      mark@compoundtheory.com

Website:    http://www.compoundtheory.com

Purpose:    The application.cfc for the app

Usage:

Modification Log:

Name			Date			Description
================================================================================
Mark Mandel		07/11/2005		Created
John Whish		31/07/2009		ported to CF9 ORM functionality
John Whish		20/07/2010		updated for CF9.01
------------------------------------------------------------------------------->
<cfcomponent name="Application.cfc" hint="The application.cfc for the app" output="false">

	<cfscript>
		// application settings
		this.name = "ORMBlog";
		this.applicationTimeout = CreateTimeSpan( 0, 4, 0, 0 );
		this.sessionManagement = true;
		this.sessionTimeout = CreateTimeSpan( 0, 1, 0, 0 );

		// define mappings
		this.mappings = {};
		this.mappings["/model"] = GetDirectoryFromPath( GetBaseTemplatePath() ) & "model\";

		// define orm settings
		this.ormenabled = true;
		this.datasource = "ormBlog";
		this.ormsettings = {};
		this.ormsettings.cfclocation = "model";
		// to rebuild the database set this to dropcreate
		this.ormsettings.dbcreate = "update";
		this.ormsettings.eventhandling = true;
		this.ormSettings.flushatrequestend = false;
		// new in CF9.01
		this.ormSettings.automanageSession = false;
	</cfscript>

<!------------------------------------------- PUBLIC ------------------------------------------->
	<cffunction name="onApplicationStart" hint="Application start tag" access="public" returntype="boolean" output="false">
		<cfscript>
			return true;
		</cfscript>
	</cffunction>

	<cffunction name="onRequestStart" returntype="boolean" output="true" hint="I am called on each request">
		<cfargument name="targetPage" type="string" required="true" hint="I am the script being requested" />
		<!--- this is just to ensure that ORM is up-to-date for demo --->
		<cfset ORMReload() />
		
		<cfreturn true />
	</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->

</cfcomponent>