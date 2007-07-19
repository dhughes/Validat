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
	displayname="Validation Rules Test Suite - Phone Number Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Phone Number Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validatePhoneNumber = createObject( "component", "validat.validationRules.validatePhoneNumber" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		testValidate_Valid_NumbersOnly

		description:	I will test the validate function, passing in a valid US phone number data string including only numbers.
	--->
	<cffunction name="testValidate_Valid_NumbersOnly" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid US phone number data string including only numbers." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validatePhoneNumber.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validatePhoneNumber.validate( '2225551212' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_NumbersOnly() --->

	<!--- 
		function: 		testValidate_Valid_WithSpaces

		description:	I will test the validate function, passing in a valid US phone number data string with space seperators.
	--->
	<cffunction name="testValidate_Valid_WithSpaces" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid US phone number data string with space seperators." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validatePhoneNumber.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validatePhoneNumber.validate( '222 555 1212' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_WithSpaces() --->

	<!--- 
		function: 		testValidate_Valid_WithDashes

		description:	I will test the validate function, passing in a valid US phone number data string with dash seperators.
	--->
	<cffunction name="testValidate_Valid_WithDashes" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid US phone number data string with dash seperators." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validatePhoneNumber.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validatePhoneNumber.validate( '222-555-1212' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_WithDashes() --->

	<!--- 
		function: 		testValidate_Valid_WithParenAndDashes

		description:	I will test the validate function, passing in a valid US phone number data string with parenthesis and dash seperators.
	--->
	<cffunction name="testValidate_Valid_WithParenAndDashes" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid US phone number data string with parenthesis and dash seperators." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validatePhoneNumber.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validatePhoneNumber.validate( '(222) 555-1212' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_WithParenAndDashes() --->

	<!--- 
		function: 		testValidate_Invalid

		description:	I will test the validate function, passing in an invalid US phone number data string.
	--->
	<cffunction name="testValidate_Invalid_NonNumeric" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid US phone number data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validatePhoneNumber.init() />
		
		<!--- call the validate method, passing in an invalid data string --->
		<cfset result = variables.validatePhoneNumber.validate( '001-001-1212' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid() --->

	<!--- 
		function: 		testValidate_ComplexData

		description:	I will test the validate function, passing in a complex data structure which should result in an error.
	--->
	<cffunction name="testValidate_ComplexData" access="public" returntype="void"
		hint="I will test the validate function, passing in a complex data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validatePhoneNumber.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validatePhoneNumber.validate( structNew() ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_ComplexData() --->

</cfcomponent>