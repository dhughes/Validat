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
	displayname="Validation Rules Test Suite - Value In List Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Value In List Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateValueInList = createObject( "component", "validat.validationRules.validateValueInList" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		testValidate_Valid

		description:	I will test the validate function, passing in a valid prefix data string.
	--->
	<cffunction name="testValidate_Valid" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid prefix data string." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateValueInList.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.list = "red,green,blue" />
		<cfset args.caseSensitive = true />
		
		<!--- call the validate method, passing in a valid data string and the arguments collection --->
		<cfset result = variables.validateValueInList.validate( 'red', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid() --->

	<!--- 
		function: 		testValidate_Valid_NoCaseSensitive

		description:	I will test the validate function, passing in a valid prefix data string but no caseSensitive argument.
	--->
	<cffunction name="testValidate_Valid_NoCaseSensitive" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid prefix data string but no caseSensitive argument." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateValueInList.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.list = "red,green,blue" />
		
		<!--- call the validate method, passing in a valid data string and the arguments collection --->
		<cfset result = variables.validateValueInList.validate( 'Red', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_NoCaseSensitive() --->

	<!--- 
		function: 		testValidate_Valid_Predefined

		description:	I will test the validate function, passing in a valid prefix data string and the key for a predefined list.
	--->
	<cffunction name="testValidate_Valid_Predefined" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid prefix data string and the key for a predefined list" >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateValueInList.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.list = "namePrefix" />
		
		<!--- call the validate method, passing in a valid data string and the arguments collection --->
		<cfset result = variables.validateValueInList.validate( 'Mr.', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Predefined() --->

	<!--- 
		function: 		testValidate_Invalid

		description:	I will test the validate function, passing in an invalid prefix data string.
	--->
	<cffunction name="testValidate_Invalid" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid prefix data string." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateValueInList.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.list = "red,green,blue" />
		
		<!--- call the validate method, passing in a valid data string and the arguments collection --->
		<cfset result = variables.validateValueInList.validate( 'black', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid() --->

	<!--- 
		function: 		testValidate_MissingArg

		description:	I will test the validate function, passing in a valid data string, but no arguments collection.
	--->
	<cffunction name="testValidate_MissingArg" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data string, but no arguments collection." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateValueInList.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a valid data string, but no arguments collection --->
			<cfset result = variables.validateValueInList.validate( 'test' ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.missingArgs was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.missingArgs" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_MissingArg() --->

	<!--- 
		function: 		testValidate_ComplexData

		description:	I will test the validate function, passing in a complex data structure which should result in an error.
	--->
	<cffunction name="testValidate_ComplexData" access="public" returntype="void"
		hint="I will test the validate function, passing in a complex data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateValueInList.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateValueInList.validate( structNew() ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_ComplexData() --->

</cfcomponent>