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
	displayname="Validation Rules Test Suite - Length Less Than Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Length Less Than Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateLengthLT = createObject( "component", "validat.validationRules.validateLengthLT" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		test_validate_Valid_String

		description:	I will test the validate function, passing in a valid data string.
	--->
	<cffunction name="test_validate_Valid_String" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data string." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.max = 100 />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateLengthLT.validate( 'This is a test string that is 49 characters long.', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_String() --->

	<!--- 
		function: 		test_validate_Invalid_String_TooLong

		description:	I will test the validate function, passing in an invalid data string.
	--->
	<cffunction name="test_validate_Invalid_String_TooLong" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid data string." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.max = 20 />
		
		<!--- call the validate method, passing in an invalid data string --->
		<cfset result = variables.validateLengthLT.validate( 'This is a test string that is 49 characters long.', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_String_Invalid_TooLong() --->

	<!--- 
		function: 		test_validate_Valid_Struct

		description:	I will test the validate function, passing in a valid data struct.
	--->
	<cffunction name="test_validate_Valid_Struct" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data struct." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.max = 10 />
		
		<!--- setup the data collection --->
		<cfset data.test = "test" />
		
		<!--- call the validate method, passing in a valid data struct --->
		<cfset result = variables.validateLengthLT.validate( data, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_Struct() --->

	<!--- 
		function: 		test_validate_Invalid_Struct_TooLong

		description:	I will test the validate function, passing in an invalid data struct.
	--->
	<cffunction name="test_validate_Invalid_Struct_TooLong" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid data struct." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.max = 1 />
			
		<!--- setup the data collection --->
		<cfset data.test = "test" />
		<cfset data.test2 = "test2" />
	
		<!--- call the validate method, passing in an invalid data struct --->
		<cfset result = variables.validateLengthLT.validate( data, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Struct_Invalid_TooLong() --->

	<!--- 
		function: 		test_validate_Valid_Array

		description:	I will test the validate function, passing in a valid data array.
	--->
	<cffunction name="test_validate_Valid_Array" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data array." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = arrayNew(1) />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.max = 10 />
		
		<!--- setup the data collection --->
		<cfset data[1] = "test" />
		
		<!--- call the validate method, passing in a valid data array --->
		<cfset result = variables.validateLengthLT.validate( data, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_Array() --->

	<!--- 
		function: 		test_validate_Invalid_Array_TooLong

		description:	I will test the validate function, passing in an invalid data array.
	--->
	<cffunction name="test_validate_Invalid_Array_TooLong" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid data array." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = arrayNew(1) />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.max = 1 />
			
		<!--- setup the data collection --->
		<cfset data[1] = "test" />
		<cfset data[2] = "test2" />
	
		<!--- call the validate method, passing in an invalid data array --->
		<cfset result = variables.validateLengthLT.validate( data, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Array_Invalid_TooLong() --->

	<!--- 
		function: 		test_validate_Valid_Query

		description:	I will test the validate function, passing in a valid data query.
	--->
	<cffunction name="test_validate_Valid_Query" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data query." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = queryNew('test') />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.max = 10 />
		
		<!--- setup the data collection --->
		<cfset queryAddRow( data ) />
		<cfset querySetCell( data, 'test', 'test' ) />
		
		<!--- call the validate method, passing in a valid data query --->
		<cfset result = variables.validateLengthLT.validate( data, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_Query() --->

	<!--- 
		function: 		test_validate_Invalid_Query_TooLong

		description:	I will test the validate function, passing in an invalid data query.
	--->
	<cffunction name="test_validate_Invalid_Query_TooLong" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid data query." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = queryNew('test') />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.max = 1 />
			
		<!--- setup the data collection --->
		<cfset queryAddRow( data, 2 ) />
		<cfset querySetCell( data, 'test', 'test', 1 ) />
		<cfset querySetCell( data, 'test', 'test2', 2 ) />
	
		<!--- call the validate method, passing in an invalid data query --->
		<cfset result = variables.validateLengthLT.validate( data, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Query_Invalid_TooLong() --->

	<!--- 
		function: 		test_validate_MissingArg

		description:	I will test the validate function, passing in a valid data string, but no arguments collection.
	--->
	<cffunction name="test_validate_MissingArg" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data string, but no arguments collection." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a valid data string, but no arguments collection --->
			<cfset result = variables.validateLengthLT.validate( 'This is valid data' ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.missingArgs was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.missingArgs" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: test_validate_MissingArg() --->

	<!--- 
		function: 		test_validate_InvalidType

		description:	I will test the validate function, passing in an invalid data type which should result in an error.
	--->
	<cffunction name="test_validate_InvalidType" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid data type which should result in an error." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = xmlNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateLengthLT.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.min = 75 />
		<cfset args.max = 100 />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in an invalid data type --->
			<cfset result = variables.validateLengthLT.validate( data, args ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: test_validate_InvalidType() --->

</cfcomponent>