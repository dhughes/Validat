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
	displayname="Validation Rules Test Suite - Same Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Same Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateSame = createObject( "component", "validat.validationRules.validateSame" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		testValidate_Valid_WithArguments

		description:	I will test the validate function, passing in two identicial data strings and the argument collection.
	--->
	<cffunction name="testValidate_Valid_WithArguments" access="public" returntype="void"
		hint="I will test the validate function, passing in two identicial data strings and the argument collection." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSame.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.dataValue1 = "password" />
		<cfset args.dataValue2 = "passwordConfirm" />
		
		<!--- setup the data collection --->
		<cfset data.password = "test" />
		<cfset data.passwordConfirm = "test" />
		
		<!--- call the validate method, passing in the data and args structures --->
		<cfset result = variables.validateSame.validate( data, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_WithArguments() --->

	<!--- 
		function: 		testValidate_Valid_NoArguments

		description:	I will test the validate function, passing in two identicial data strings and no argument collection.
	--->
	<cffunction name="testValidate_Valid_NoArguments" access="public" returntype="void"
		hint="I will test the validate function, passing in two identicial data strings and no argument collection." >
	
		<!--- setup temporary variables --->
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSame.init() />
		
		<!--- setup the data collection --->
		<cfset data.password = "test" />
		<cfset data.passwordConfirm = "test" />
		
		<!--- call the validate method, passing in the data structure --->
		<cfset result = variables.validateSame.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_NoArguments() --->

	<!--- 
		function: 		testValidate_Invalid_SameData

		description:	I will test the validate function, passing in two different data strings and no argument collection.
	--->
	<cffunction name="testValidate_Invalid_DifferentData" access="public" returntype="void"
		hint="I will test the validate function, passing in two different data strings and no argument collection." >
	
		<!--- setup temporary variables --->
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSame.init() />
		
		<!--- setup the data collection --->
		<cfset data.password = "test" />
		<cfset data.passwordConfirm = "test123" />
		
		<!--- call the validate method, passing in the data structure --->
		<cfset result = variables.validateSame.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_DifferentData() --->

	<!--- 
		function: 		testValidate_BadData

		description:	I will test the validate function, passing in a simple string data structure which should result in an error.
	--->
	<cffunction name="testValidate_BadData" access="public" returntype="void"
		hint="I will test the validate function, passing in a simple string data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateSame.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateSame.validate( "test" ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_BadData() --->

</cfcomponent>