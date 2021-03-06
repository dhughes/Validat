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
	displayname="Validation Rules Test Suite - Different Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Different Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateDifferent = createObject( "component", "validat.validationRules.validateDifferent" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		test_validate_Valid_WithArguments

		description:	I will test the validate function, passing in two different data strings and the argument collection.
	--->
	<cffunction name="test_validate_Valid_WithArguments" access="public" returntype="void"
		hint="I will test the validate function, passing in two different data strings and the argument collection." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDifferent.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.dataValue1 = "phoneHone" />
		<cfset args.dataValue2 = "phoneWork" />
		
		<!--- setup the data collection --->
		<cfset data.phoneHome = "123-123-1234" />
		<cfset data.phoneWork = "234-234-2345" />
		
		<!--- call the validate method, passing in the data and args structures --->
		<cfset result = variables.validateDifferent.validate( data, args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_WithArguments() --->

	<!--- 
		function: 		test_validate_Valid_NoArguments

		description:	I will test the validate function, passing in two different data strings and no argument collection.
	--->
	<cffunction name="test_validate_Valid_NoArguments" access="public" returntype="void"
		hint="I will test the validate function, passing in two different data strings and no argument collection." >
	
		<!--- setup temporary variables --->
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDifferent.init() />
		
		<!--- setup the data collection --->
		<cfset data.phoneHome = "123-123-1234" />
		<cfset data.phoneWork = "234-234-2345" />
		
		<!--- call the validate method, passing in the data structure --->
		<cfset result = variables.validateDifferent.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_NoArguments() --->

	<!--- 
		function: 		test_validate_Invalid_SameData

		description:	I will test the validate function, passing in two matching data strings and no argument collection.
	--->
	<cffunction name="test_validate_Invalid_SameData" access="public" returntype="void"
		hint="I will test the validate function, passing in two matching data strings and no argument collection." >
	
		<!--- setup temporary variables --->
		<cfset var data = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDifferent.init() />
		
		<!--- setup the data collection --->
		<cfset data.phoneHome = "123-123-1234" />
		<cfset data.phoneWork = "123-123-1234" />
		
		<!--- call the validate method, passing in the data structure --->
		<cfset result = variables.validateDifferent.validate( data ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Invalid_SameData() --->

	<!--- 
		function: 		test_validate_BadData

		description:	I will test the validate function, passing in a simple string data structure which should result in an error.
	--->
	<cffunction name="test_validate_BadData" access="public" returntype="void"
		hint="I will test the validate function, passing in a simple string data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateDifferent.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateDifferent.validate( "test" ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: test_validate_BadData() --->

</cfcomponent>