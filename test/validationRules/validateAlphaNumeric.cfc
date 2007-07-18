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
	displayname="Validation Rules Test Suite - AlphaNumeric Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - AlphaNumeric Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateAlphaNumeric = createObject( "component", "validat.validationRules.validateAlphaNumeric" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		testValidate_Valid_AlphaOnly

		description:	I will test the validate function, passing in a valid data string.
	--->
	<cffunction name="testValidate_Valid_AlphaOnly" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateAlphaNumeric.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateAlphaNumeric.validate( 'ThisIsAnAlphabeticStringWithNoOtherCharacters' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_AlphaOnly() --->

	<!--- 
		function: 		testValidate_Valid_AlphaNumeric

		description:	I will test the validate function, passing in a valid, alpha numeric data string.
	--->
	<cffunction name="testValidate_Valid_AlphaNumeric" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid, alpha numeric data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateAlphaNumeric.init() />
		
		<!--- call the validate method, passing in an invalid data string --->
		<cfset result = variables.validateAlphaNumeric.validate( 'ThisIsAnInvalidAlphaNumericString12345' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_AlphaNumeric() --->

	<!--- 
		function: 		testValidate_Invalid_SpecialChars

		description:	I will test the validate function, passing in an invalid data string containing special characters.
	--->
	<cffunction name="testValidate_Invalid_SpecialChars" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid data string containing special characters." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateAlphaNumeric.init() />
		
		<!--- call the validate method, passing in an valid data string --->
		<cfset result = variables.validateAlphaNumeric.validate( 'This Is An Invalid Alpha Numeric String ,./;[]\' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_SpecialChars() --->

	<!--- 
		function: 		testValidate_ComplexData

		description:	I will test the validate function, passing in a complex data structure which should result in an error.
	--->
	<cffunction name="testValidate_ComplexData" access="public" returntype="void"
		hint="I will test the validate function, passing in a complex data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateAlphaNumeric.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateAlphaNumeric.validate( structNew() ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_ComplexData() --->

</cfcomponent>