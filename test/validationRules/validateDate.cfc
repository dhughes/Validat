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
	displayname="Validation Rules Test Suite - Date Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Date Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateDate = createObject( "component", "validat.validationRules.validateDate" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		testValidate_Valid

		description:	I will test the validate function, passing in a valid date string.
	--->
	<cffunction name="testValidate_Valid" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid date string." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDate.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.mask = "dd/mm/yyyy" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateDate.validate( '9/23/2000', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid() --->

	<!--- 
		function: 		testValidate_Valid2

		description:	I will test the validate function, passing in a valid date string.
	--->
	<cffunction name="testValidate_Valid2" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid date string." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDate.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.mask = "yyyy.MM.dd G 'at' HH:mm:ss z" />
		
		<!--- call the validate method, passing in a valid date string and the arguments collection --->
		<cfset result = variables.validateDate.validate( '2001.07.04 AD at 12:08:56 PDT', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid2() --->

	<!--- 
		function: 		testValidate_Invalid_BadDate

		description:	I will test the validate function, passing in an invalid date string.
	--->
	<cffunction name="testValidate_Invalid_BadDate" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid date string." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDate.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.mask = "dd/MM/yyyy" />
		
		<!--- call the validate method, passing in an invalid data string --->
		<cfset result = variables.validateDate.validate( '13/45/2010', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_BadDate() --->

	<!--- 
		function: 		testValidate_MissingArg

		description:	I will test the validate function, passing in a valid data string, but no arguments collection.
	--->
	<cffunction name="testValidate_MissingArg" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data string, but no arguments collection." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDate.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a valid data string, but no arguments collection --->
			<cfset result = variables.validateDate.validate( '2001.07.04 AD at 12:08:56 PDT' ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.missingArgs was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.missingArgs" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_MissingArg() --->

	<!--- 
		function: 		testValidate_InvalidType

		description:	I will test the validate function, passing in an invalid data type which should result in an error.
	--->
	<cffunction name="testValidate_InvalidType" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid data type which should result in an error." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = xmlNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDate.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.mask = "ddmmyyyy" />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in an invalid data type --->
			<cfset result = variables.validateDate.validate( data, args ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_InvalidType() --->

</cfcomponent>