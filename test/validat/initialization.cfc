<!---
License:
Copyright 2007, Alagad, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Copyright: Alagad, Inc. (http://www.alagad.com)
Author: Jeff Chastain (jeff.chastain@alagad.com)
$Id$

Release: 0.1.0

--->

<cfcomponent 
	displayname="Validat Test Suite - Initialization"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat object - initialization tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.factory = createObject( "component", "coldspring.beans.DefaultXmlBeanFactory" ).init() />
		<cfset variables.factory.loadBeansFromXmlFile( expandPath( "/test/support/coldspring.xml" ), true ) />
		<cfset variables.validat = createObject( "component", "test.support.validatWrap" ) /> <!--- instantiating the wrapper to get access to private data --->

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		test_init

		description:	I will test the init function, verifying its signature.
	--->
	<cffunction name="test_init" access="public" returntype="void"
		hint="I will test the init function, verifying its signature." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		
		<!--- verify the init method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "init"), "init method is not defined" ) />
		
		<!--- get the metadata for the init method --->
		<cfset metaData = getMetaData( variables.validat.init ) />
		
		<!--- verify the init method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "validat", "Return type is not defined or is not 'validat'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

	</cffunction> <!--- end: test_init() --->

	<!--- 
		function: 		test_init_NoXML

		description:	I will test the init function, without passing in the path to a configuration xml file.
	--->
	<cffunction name="test_init_NoXML" access="public" returntype="void"
		hint="I will test the init function, without passing in the path to a configuration xml file." >
	
		<!--- setup temporary variables --->
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.dataSets = structNew() />
		<cfset base.factory = variables.factory />
		<Cfset base.validationRules = structNew() />

		<!--- call the init method, only passing the factory reference --->
		<cfset variables.validat.init( variables.factory ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result, "Result data structure does not match the base data structure" ) />
	</cffunction> <!--- end: test_init_NoXML() --->

	<!--- 
		function: 		test_init_SimpleXML

		description:	I will test the init function, passing in the path to a simple configuration xml file.
	--->
	<cffunction name="test_init_SimpleXML" access="public" returntype="void"
		hint="I will test the init function, passing in the path to a simple configuration xml file." >
	
		<!--- setup temporary variables --->
		<cfset var base = structNew() />
		<cfset var result = structNew() />
		<cfset var assertId = "" />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.factory = variables.factory />
		<cfinclude template="/test/testData/validat-simple.cfm" />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, "/test/testData/validat-simple.xml" ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- attempt to retrieve dynamic assertionID values and insert into base data structure for later comparison --->
		<cfif isDefined( "result.dataSets.user.assertionIDList" )>
			<cfloop list="#result.dataSets.user.assertionIDList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.assertionIDList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.assertionIDList = result.dataSets.user.assertionIDList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.assertionIDList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.firstName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.firstName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.firstName.assertionIdList = result.dataSets.user.dataElements.firstName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.firstName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.firstName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.firstName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.firstName.assertions[1].assertId ), "'result.dataSets.user.dataElements.firstName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.firstName.assertions[1].assertId = result.dataSets.user.dataElements.firstName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.middleName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.middleName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.middleName.assertionIdList = result.dataSets.user.dataElements.middleName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.middleName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.middleName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.middleName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.middleName.assertions[1].assertId ), "'result.dataSets.user.dataElements.middleName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.middleName.assertions[1].assertId = result.dataSets.user.dataElements.middleName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.lastName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.lastName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.lastName.assertionIdList = result.dataSets.user.dataElements.lastName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.lastName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.lastName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.lastName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.lastName.assertions[1].assertId ), "'result.dataSets.user.dataElements.lastName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.lastName.assertions[1].assertId = result.dataSets.user.dataElements.lastName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName' assertion definition is missing or not properly formated" ) />
		</cfif>
		
		<!--- compare the base data structure against the result data structure --->
		<cfset assertEqualsStruct( base, result, "Result data structure does not match the base data structure" ) />
	</cffunction> <!--- end: test_init_SimpleXML() --->

	<!--- 
		function: 		test_init_CompleteXML

		description:	I will test the init function, passing in the path to a complete (full featured) configuration xml file.
	--->
	<cffunction name="test_init_CompleteXML" access="public" returntype="void"
		hint="I will test the init function, passing in the path to a complete (full featured) configuration xml file." >
	
		<!--- setup temporary variables --->
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.factory = variables.factory />
		<cfinclude template="/test/testData/validat-complete.cfm" />

		<!--- call the init method, passing the factory reference and path to the complete configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-complete.xml' ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- attempt to retrieve dynamic assertionID values and insert into base data structure for later comparison --->
		<cfif isDefined( "result.dataSets.user.assertionIDList" )>
			<cfloop list="#result.dataSets.user.assertionIDList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.assertionIDList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.assertionIDList = result.dataSets.user.assertionIDList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.assertionIDList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.prefix.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.prefix.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.prefix.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.prefix.assertionIdList = result.dataSets.user.dataElements.prefix.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.prefix.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.prefix.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.prefix.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.prefix.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.prefix.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.prefix.assertions[1].assertId ), "'result.dataSets.user.dataElements.prefix.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.prefix.assertions[1].assertId = result.dataSets.user.dataElements.prefix.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.prefix' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.firstName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.firstName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.firstName.assertionIdList = result.dataSets.user.dataElements.firstName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.firstName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.firstName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.firstName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.firstName.assertions[1].assertId ), "'result.dataSets.user.dataElements.firstName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.firstName.assertions[1].assertId = result.dataSets.user.dataElements.firstName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.middleName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.middleName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.middleName.assertionIdList = result.dataSets.user.dataElements.middleName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.middleName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.middleName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.middleName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.middleName.assertions[1].assertId ), "'result.dataSets.user.dataElements.middleName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.middleName.assertions[1].assertId = result.dataSets.user.dataElements.middleName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.lastName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.lastName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.lastName.assertionIdList = result.dataSets.user.dataElements.lastName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.lastName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.lastName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.lastName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.lastName.assertions[1].assertId ), "'result.dataSets.user.dataElements.lastName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.lastName.assertions[1].assertId = result.dataSets.user.dataElements.lastName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.suffix.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.suffix.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.suffix.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.suffix.assertionIdList = result.dataSets.user.dataElements.suffix.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.suffix.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.suffix.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.suffix.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.suffix.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.suffix.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.suffix.assertions[1].assertId ), "'result.dataSets.user.dataElements.suffix.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.suffix.assertions[1].assertId = result.dataSets.user.dataElements.suffix.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.suffix' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.birthDate.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.birthDate.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.birthDate.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.birthDate.assertionIdList = result.dataSets.user.dataElements.birthDate.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.birthDate.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.birthDate.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.birthDate.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.birthDate.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.birthDate.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.birthDate.assertions[1].assertId ), "'result.dataSets.user.dataElements.birthDate.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.birthDate.assertions[1].assertId = result.dataSets.user.dataElements.birthDate.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.birthDate' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.ssn.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.ssn.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.ssn.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.ssn.assertionIdList = result.dataSets.user.dataElements.ssn.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.ssn.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.ssn.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.ssn.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.ssn.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.ssn.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.ssn.assertions[1].assertId ), "'result.dataSets.user.dataElements.ssn.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.ssn.assertions[1].assertId = result.dataSets.user.dataElements.ssn.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.ssn' assertion definition is missing or not properly formated" ) />
		</cfif>
		
		<cfif isDefined( "result.dataSets.person.assertionIDList" )>
			<cfloop list="#result.dataSets.person.assertionIDList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.person.assertionIDList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.person.assertionIDList = result.dataSets.person.assertionIDList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.assertionIDList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.firstName.assertionIdList" )>
			<cfloop list="#result.dataSets.person.dataElements.firstName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.person.dataElements.firstName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.person.dataElements.firstName.assertionIdList = result.dataSets.person.dataElements.firstName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.firstName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.firstName.assertions" ) AND 
			  isArray( result.dataSets.person.dataElements.firstName.assertions ) AND
			  arrayLen( result.dataSets.person.dataElements.firstName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.person.dataElements.firstName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.person.dataElements.firstName.assertions[1].assertId ), "'result.dataSets.person.dataElements.firstName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.person.dataElements.firstName.assertions[1].assertId = result.dataSets.person.dataElements.firstName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.firstName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.middleName.assertionIdList" )>
			<cfloop list="#result.dataSets.person.dataElements.middleName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.person.dataElements.middleName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.person.dataElements.middleName.assertionIdList = result.dataSets.person.dataElements.middleName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.middleName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.middleName.assertions" ) AND 
			  isArray( result.dataSets.person.dataElements.middleName.assertions ) AND
			  arrayLen( result.dataSets.person.dataElements.middleName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.person.dataElements.middleName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.person.dataElements.middleName.assertions[1].assertId ), "'result.dataSets.person.dataElements.middleName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.person.dataElements.middleName.assertions[1].assertId = result.dataSets.person.dataElements.middleName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.middleName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.lastName.assertionIdList" )>
			<cfloop list="#result.dataSets.person.dataElements.lastName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.person.dataElements.lastName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.person.dataElements.lastName.assertionIdList = result.dataSets.person.dataElements.lastName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.lastName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.lastName.assertions" ) AND 
			  isArray( result.dataSets.person.dataElements.lastName.assertions ) AND
			  arrayLen( result.dataSets.person.dataElements.lastName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.person.dataElements.lastName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.person.dataElements.lastName.assertions[1].assertId ), "'result.dataSets.person.dataElements.lastName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.person.dataElements.lastName.assertions[1].assertId = result.dataSets.person.dataElements.lastName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.lastName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.billingAddress.assertionIdList" )>
			<cfloop list="#result.dataSets.person.dataElements.billingAddress.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.person.dataElements.billingAddress.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.person.dataElements.billingAddress.assertionIdList = result.dataSets.person.dataElements.billingAddress.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.billingAddress.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.mailingAddress.assertionIdList" )>
			<cfloop list="#result.dataSets.person.dataElements.mailingAddress.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.person.dataElements.mailingAddress.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.person.dataElements.mailingAddress.assertionIdList = result.dataSets.person.dataElements.mailingAddress.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.mailingAddress.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.emailAddress.assertionIdList" )>
			<cfloop list="#result.dataSets.person.dataElements.emailAddress.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.person.dataElements.emailAddress.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.person.dataElements.emailAddress.assertionIdList = result.dataSets.person.dataElements.emailAddress.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.emailAddress.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.emailAddress.assertions" ) AND 
			  isArray( result.dataSets.person.dataElements.emailAddress.assertions ) AND
			  arrayLen( result.dataSets.person.dataElements.emailAddress.assertions ) EQ 2 AND
			  structKeyExists ( result.dataSets.person.dataElements.emailAddress.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.person.dataElements.emailAddress.assertions[1].assertId ), "'result.dataSets.person.dataElements.emailAddress.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.person.dataElements.emailAddress.assertions[1].assertId = result.dataSets.person.dataElements.emailAddress.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.emailAddress' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.person.dataElements.emailAddress.assertions" ) AND 
			  isArray( result.dataSets.person.dataElements.emailAddress.assertions ) AND
			  arrayLen( result.dataSets.person.dataElements.emailAddress.assertions ) EQ 2 AND
			  structKeyExists ( result.dataSets.person.dataElements.emailAddress.assertions[2], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.person.dataElements.emailAddress.assertions[2].assertId ), "'result.dataSets.person.dataElements.emailAddress.assertions[2].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.person.dataElements.emailAddress.assertions[2].assertId = result.dataSets.person.dataElements.emailAddress.assertions[2].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.person.dataElements.emailAddress.assertions[2].assertId' is missing from the result data structure" ) />
		</cfif>
		
		<cfif isDefined( "result.dataSets.address.assertionIDList" )>
			<cfloop list="#result.dataSets.address.assertionIDList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.address.assertionIDList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.address.assertionIDList = result.dataSets.address.assertionIDList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.assertionIDList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.address.dataElements.street1.assertionIdList" )>
			<cfloop list="#result.dataSets.address.dataElements.street1.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.address.dataElements.street1.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.address.dataElements.street1.assertionIdList = result.dataSets.address.dataElements.street1.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.street1.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.address.dataElements.street1.assertions" ) AND 
			  isArray( result.dataSets.address.dataElements.street1.assertions ) AND
			  arrayLen( result.dataSets.address.dataElements.street1.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.address.dataElements.street1.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.address.dataElements.street1.assertions[1].assertId ), "'result.dataSets.address.dataElements.street1.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.address.dataElements.street1.assertions[1].assertId = result.dataSets.address.dataElements.street1.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.street1' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.address.dataElements.street2.assertionIdList" )>
			<cfloop list="#result.dataSets.address.dataElements.street2.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.address.dataElements.street2.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.address.dataElements.street2.assertionIdList = result.dataSets.address.dataElements.street2.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.street2.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.address.dataElements.street2.assertions" ) AND 
			  isArray( result.dataSets.address.dataElements.street2.assertions ) AND
			  arrayLen( result.dataSets.address.dataElements.street2.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.address.dataElements.street2.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.address.dataElements.street2.assertions[1].assertId ), "'result.dataSets.address.dataElements.street2.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.address.dataElements.street2.assertions[1].assertId = result.dataSets.address.dataElements.street2.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.street2' assertion definition is missing or not properly formated" ) />
		</cfif>
		
		<cfif isDefined( "result.dataSets.address.dataElements.city.assertionIdList" )>
			<cfloop list="#result.dataSets.address.dataElements.city.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.address.dataElements.city.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.address.dataElements.city.assertionIdList = result.dataSets.address.dataElements.city.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.city.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.address.dataElements.city.assertions" ) AND 
			  isArray( result.dataSets.address.dataElements.city.assertions ) AND
			  arrayLen( result.dataSets.address.dataElements.city.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.address.dataElements.city.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.address.dataElements.city.assertions[1].assertId ), "'result.dataSets.address.dataElements.city.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.address.dataElements.city.assertions[1].assertId = result.dataSets.address.dataElements.city.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.city' assertion definition is missing or not properly formated" ) />
		</cfif>
		
		<cfif isDefined( "result.dataSets.address.dataElements.state.assertionIdList" )>
			<cfloop list="#result.dataSets.address.dataElements.state.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.address.dataElements.state.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.address.dataElements.state.assertionIdList = result.dataSets.address.dataElements.state.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.state.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.address.dataElements.state.assertions" ) AND 
			  isArray( result.dataSets.address.dataElements.state.assertions ) AND
			  arrayLen( result.dataSets.address.dataElements.state.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.address.dataElements.state.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.address.dataElements.state.assertions[1].assertId ), "'result.dataSets.address.dataElements.state.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.address.dataElements.state.assertions[1].assertId = result.dataSets.address.dataElements.state.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.state' assertion definition is missing or not properly formated" ) />
		</cfif>
		
		<cfif isDefined( "result.dataSets.address.dataElements.postalCode.assertionIdList" )>
			<cfloop list="#result.dataSets.address.dataElements.postalCode.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.address.dataElements.postalCode.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.address.dataElements.postalCode.assertionIdList = result.dataSets.address.dataElements.postalCode.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.postalCode.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.address.dataElements.postalCode.assertions" ) AND 
			  isArray( result.dataSets.address.dataElements.postalCode.assertions ) AND
			  arrayLen( result.dataSets.address.dataElements.postalCode.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.address.dataElements.postalCode.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.address.dataElements.postalCode.assertions[1].assertId ), "'result.dataSets.address.dataElements.postalCode.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.address.dataElements.postalCode.assertions[1].assertId = result.dataSets.address.dataElements.postalCode.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.postalCode' assertion definition is missing or not properly formated" ) />
		</cfif>
		
		<cfif isDefined( "result.dataSets.address.dataElements.country.assertionIdList" )>
			<cfloop list="#result.dataSets.address.dataElements.country.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.address.dataElements.country.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.address.dataElements.country.assertionIdList = result.dataSets.address.dataElements.country.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.address.dataElements.country.assertionIdList' is missing from the result data structure" ) />
		</cfif>
		
		<!--- compare the base data structure against the result data structure --->
		<cfset assertEqualsStruct( base, result, "Result data structure does not match the base data structure" ) />
	</cffunction> <!--- end: test_init_CompleteXML() --->

</cfcomponent>