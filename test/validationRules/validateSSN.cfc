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
	displayname="Validation Rules Test Suite - US Social Security Number Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - US Social Security Number Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateSSN = createObject( "component", "validat.validationRules.validateSSN" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		test_validate_Valid_NumbersOnly

		description:	I will test the validate function, passing in a valid US social security number data string including only numbers.
	--->
	<cffunction name="test_validate_Valid_NumbersOnly" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid US social security number data string including only numbers." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSSN.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateSSN.validate( '078051120' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_NumbersOnly() --->

	<!--- 
		function: 		test_validate_Valid_WithSpaces

		description:	I will test the validate function, passing in a valid US social security number data string with space seperators.
	--->
	<cffunction name="test_validate_Valid_WithSpaces" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid US social security number data string with space seperators." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSSN.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateSSN.validate( '078 05 1120' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_WithSpaces() --->

	<!--- 
		function: 		test_validate_Valid_WithDashes

		description:	I will test the validate function, passing in a valid US social security number data string with dash seperators.
	--->
	<cffunction name="test_validate_Valid_WithDashes" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid US social security number data string with dash seperators." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSSN.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateSSN.validate( '078-05-1120' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_WithDashes() --->

	<!--- 
		function: 		test_validate_Invalid

		description:	I will test the validate function, passing in an invalid US social security number data string.
	--->
	<cffunction name="test_validate_Invalid_NonNumeric" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid US social security number data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSSN.init() />
		
		<!--- call the validate method, passing in an invalid data string --->
		<cfset result = variables.validateSSN.validate( '987-65-4320' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Invalid() --->

	<!--- 
		function: 		test_validate_ComplexData

		description:	I will test the validate function, passing in a complex data structure which should result in an error.
	--->
	<cffunction name="test_validate_ComplexData" access="public" returntype="void"
		hint="I will test the validate function, passing in a complex data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSSN.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateSSN.validate( structNew() ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: test_validate_ComplexData() --->

</cfcomponent>