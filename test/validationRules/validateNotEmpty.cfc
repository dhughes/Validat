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
	displayname="Validation Rules Test Suite - Not Empty Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Not Empty Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateNotEmpty = createObject( "component", "validat.validationRules.validateNotEmpty" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		testValidate_Valid_String

		description:	I will test the validate function, passing in a valid data string.
	--->
	<cffunction name="testValidate_Valid_String" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateNotEmpty.validate( 'This is a test string.' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_String() --->

	<!--- 
		function: 		testValidate_Invalid_String

		description:	I will test the validate function, passing in an empty data string.
	--->
	<cffunction name="testValidate_Invalid_String" access="public" returntype="void"
		hint="I will test the validate function, passing in an empty data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<!--- call the validate method, passing in an empty data string --->
		<cfset result = variables.validateNotEmpty.validate( '' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_String() --->

	<!--- 
		function: 		testValidate_Valid_Struct

		description:	I will test the validate function, passing in a valid data structure.
	--->
	<cffunction name="testValidate_Valid_Struct" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data structure." >
	
		<!--- setup temporary variables --->
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<!--- setup the data collection --->
		<cfset data.test = "test" />
		
		<!--- call the validate method, passing in a valid data structure --->
		<cfset result = variables.validateNotEmpty.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Struct() --->

	<!--- 
		function: 		testValidate_Invalid_Struct

		description:	I will test the validate function, passing in an empty data struct.
	--->
	<cffunction name="testValidate_Invalid_Struct" access="public" returntype="void"
		hint="I will test the validate function, passing in an empty data struct." >
	
		<!--- setup temporary variables --->
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<!--- call the validate method, passing in an empty data struct --->
		<cfset result = variables.validateNotEmpty.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_Struct() --->

	<!--- 
		function: 		testValidate_Valid_Array

		description:	I will test the validate function, passing in a valid data array.
	--->
	<cffunction name="testValidate_Valid_Array" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data array." >
	
		<!--- setup temporary variables --->
		<cfset var data = arrayNew(1) />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<!--- setup the data collection --->
		<cfset data[1] = "test" />
		
		<!--- call the validate method, passing in a valid data array --->
		<cfset result = variables.validateNotEmpty.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Array() --->

	<!--- 
		function: 		testValidate_Invalid_Array

		description:	I will test the validate function, passing in an empty data array.
	--->
	<cffunction name="testValidate_Invalid_Array" access="public" returntype="void"
		hint="I will test the validate function, passing in an empty data array." >
	
		<!--- setup temporary variables --->
		<cfset var data = arrayNew(1) />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<!--- call the validate method, passing in an empty data array --->
		<cfset result = variables.validateNotEmpty.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_Array() --->

	<!--- 
		function: 		testValidate_Valid_Query

		description:	I will test the validate function, passing in a valid data query.
	--->
	<cffunction name="testValidate_Valid_Query" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid data query." >
	
		<!--- setup temporary variables --->
		<cfset var data = queryNew('test') />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<!--- setup the data collection --->
		<cfset queryAddRow( data ) />
		<cfset querySetCell( data, 'test', 'test' ) />
		
		<!--- call the validate method, passing in a valid data query --->
		<cfset result = variables.validateNotEmpty.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Query() --->

	<!--- 
		function: 		testValidate_Invalid_Query

		description:	I will test the validate function, passing in an empty data query.
	--->
	<cffunction name="testValidate_Invalid_Query" access="public" returntype="void"
		hint="I will test the validate function, passing in an empty data query." >
	
		<!--- setup temporary variables --->
		<cfset var data = queryNew('test') />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<!--- call the validate method, passing in an empty data query --->
		<cfset result = variables.validateNotEmpty.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_Query() --->

	<!--- 
		function: 		testValidate_InvalidType

		description:	I will test the validate function, passing in an invalid data type which should result in an error.
	--->
	<cffunction name="testValidate_InvalidType" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid data type which should result in an error." >
	
		<!--- setup temporary variables --->
		<cfset var data = xmlNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateNotEmpty.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateNotEmpty.validate( data ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_InvalidType() --->

</cfcomponent>