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
	displayname="Validation Rules Test Suite - Numeric Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Numeric Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateNumeric = createObject( "component", "validat.validationRules.validateNumeric" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		test_validate_Valid

		description:	I will test the validate function, passing in a valid numeric data string.
	--->
	<cffunction name="test_validate_Valid" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid numeric data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNumeric.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateNumeric.validate( '123456' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid() --->

	<!--- 
		function: 		test_validate_Valid_WithCommas

		description:	I will test the validate function, passing in a valid numeric data string with comma seperators.
	--->
	<cffunction name="test_validate_Valid_WithCommas" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid numeric data string with comma seperators." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNumeric.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateNumeric.validate( '123,456.123' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_WithCommas() --->

	<!--- 
		function: 		test_validate_Valid_WithSign

		description:	I will test the validate function, passing in a valid numeric data string with a negative sign and comma seperators.
	--->
	<cffunction name="test_validate_Valid_WithSign" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid numeric data string with a negative sign and comma seperators." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNumeric.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateNumeric.validate( '-123,456.123' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_WithSign() --->

	<!--- 
		function: 		test_validate_Invalid_NonNumeric

		description:	I will test the validate function, passing in an invalid non-numeric data string.
	--->
	<cffunction name="test_validate_Invalid_NonNumeric" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid non-numeric data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNumeric.init() />
		
		<!--- call the validate method, passing in an invalid data string --->
		<cfset result = variables.validateNumeric.validate( 'This is not a number at all' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Invalid_NonNumeric() --->

	<!--- 
		function: 		test_validate_ComplexData

		description:	I will test the validate function, passing in a complex data structure which should result in an error.
	--->
	<cffunction name="test_validate_ComplexData" access="public" returntype="void"
		hint="I will test the validate function, passing in a complex data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNumeric.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateNumeric.validate( structNew() ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: test_validate_ComplexData() --->

</cfcomponent>