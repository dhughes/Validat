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
	displayname="Validation Rules Test Suite - Range Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Range Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateRange = createObject( "component", "validat.validationRules.validateRange" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		test_validate_Valid_String

		description:	I will test the validate function, passing in a valid string data value.
	--->
	<cffunction name="test_validate_Valid_String" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid string data value." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateRange.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.min = "A" />
		<cfset args.max = "Z" />
		
		<!--- call the validate method, passing in a valid data value --->
		<cfset result = variables.validateRange.validate( "M", args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_String() --->

	<!--- 
		function: 		test_validate_Valid_Numeric

		description:	I will test the validate function, passing in a valid numeric data value.
	--->
	<cffunction name="test_validate_Valid_Numeric" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid numeric data value." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateRange.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.min = 1 />
		<cfset args.max = 10 />
		
		<!--- call the validate method, passing in a valid data value --->
		<cfset result = variables.validateRange.validate( 5, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_Numeric() --->

	<!--- 
		function: 		test_validate_Invalid_Numeric

		description:	I will test the validate function, passing in an invalid numeric data value.
	--->
	<cffunction name="test_validate_Invalid_Numeric" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid numeric data value." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateRange.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.min = 1 />
		<cfset args.max = 10 />
		
		<!--- call the validate method, passing in an invalid data value --->
		<cfset result = variables.validateRange.validate( 20, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Invalid_Numeric() --->

	<!--- 
		function: 		test_validate_MissingArg

		description:	I will test the validate function, passing in a valid data string, but no arguments collection.
	--->
	<cffunction name="test_validate_MissingArg" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data string, but no arguments collection." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateRange.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a valid data string, but no arguments collection --->
			<cfset result = variables.validateRange.validate( 'test' ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.missingArgs was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.missingArgs" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: test_validate_MissingArg() --->

	<!--- 
		function: 		test_validate_ComplexData

		description:	I will test the validate function, passing in a complex data structure which should result in an error.
	--->
	<cffunction name="test_validate_ComplexData" access="public" returntype="void"
		hint="I will test the validate function, passing in a complex data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateRange.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateRange.validate( structNew() ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: test_validate_ComplexData() --->

</cfcomponent>