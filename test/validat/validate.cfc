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
	displayname="Validat Test Suite - Validation"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat object - validation tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.factory = createObject( "component", "coldspring.beans.DefaultXmlBeanFactory" ).init() />
		<cfset variables.factory.loadBeansFromXmlFile( expandPath( "/test/support/coldspring.xml" ), true ) />
		<cfset variables.validat = createObject( "component", "test.support.validatWrap" ) /> <!--- instantiating the wrapper to get access to private data --->

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		testValidate_SimpleStruct

		description:	I will test the validate function, using the simple configuration file and a basic data 
						structure collection.
	--->
	<cffunction name="testValidate_SimpleStruct" access="public" returntype="void"
		hint="I will test the validate function, using the simple configuration file and a basic data structure collection." >
	
		<!--- setup temporary variables --->
		<cfset var dataStr = structNew() />
		<cfset var base = structNew() />
		<cfset var baseTmp = structNew() />
		<cfset var result = structNew() />

		<!--- setup the test data structure --->
		<cfset dataStr.middleName = "This is a string that is longer that one hundred characters and should cause a validation error to be thrown." />
		<cfset dataStr.lastName = "Doe" />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base = arrayNew(1) />
		
		<cfset baseTemp.dataElement = "firstName" />
		<cfset baseTemp.dataValue = "" />
		<cfset baseTemp.message = "errors.validation.user.firstName.required" />
		<cfset arrayAppend( base, structCopy( baseTemp ) ) />
		
		<cfset baseTemp.dataElement = "middleName" />
		<cfset baseTemp.dataValue = "This is a string that is longer that one hundred characters and should cause a validation error to be thrown." />
		<cfset baseTemp.message = "errors.validation.user.middleName.invalidLength" />
		<cfset arrayAppend( base, structCopy( baseTemp ) ) />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the validate method, passing in the data structure, and get the errors from the resulting error collection --->
		<cfset result = variables.validat.validate( 'user', dataStr ).getErrors() />
		
		<!--- run the assertion --->
		<cfset assertEqualsArray( base, result ) />
	</cffunction> <!--- end: testValidate_SimpleStruct() --->

</cfcomponent>