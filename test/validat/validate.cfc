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
		function: 		test_validate

		description:	I will test the validate function, verifying its signature.
	--->
	<cffunction name="test_validate" access="public" returntype="void"
		hint="I will test the validate function, verifying its signature." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		
		<!--- verify the validate method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "validate"), "validate method is not defined" ) />
		
		<!--- get the metadata for the validate method --->
		<cfset metaData = getMetaData( variables.validat.validate ) />
		
		<!--- verify the init method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "any", "Return type is not defined or is not 'any'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

	</cffunction> <!--- end: test_validate() --->

	<!--- 
		function: 		test_validate_SimpleStruct

		description:	I will test the validate function, using the simple configuration file and a basic data 
						structure collection.
	--->
	<cffunction name="test_validate_SimpleStruct" access="public" returntype="void"
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
		<cfset base = structNew() />
		<cfset base["_errorCount"] = 2 />

		<cfset base["firstName"] = structNew() />
		<cfset base["firstName"]["value"] = "" />
		<cfset base["firstName"]["errors"] = arrayNew(1) />
		<cfset baseTmp["message"] = "errors.validation.user.firstName.required" />
		<cfset baseTmp["rule"] = "firstName" />
		<cfset arrayAppend( base["firstName"]["errors"], structCopy(baseTmp) ) />

		<cfset base["middleName"] = structNew() />
		<cfset base["middleName"]["value"] = "This is a string that is longer that one hundred characters and should cause a validation error to be thrown." />
		<cfset base["middleName"]["errors"] = arrayNew(1) />
		<cfset baseTmp["message"] = "errors.validation.user.middleName.invalidLength" />
		<cfset baseTmp["rule"] = "" />
		<cfset arrayAppend( base["middleName"]["errors"], structCopy(baseTmp) ) />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />

		<!--- call the validate method, passing in the data structure, and get the errors from the resulting error collection --->
		<cfset result = variables.validat.validate( 'user', dataStr ).getErrors() />
		
		<!--- attempt to retrieve dynamic ruleId values and insert into base data structure for later comparison --->
		<cfif isDefined( "result.middleName.errors" ) AND 
			  isArray( result.middleName.errors ) AND
			  arrayLen( result.middleName.errors ) EQ 1 AND
			  structKeyExists ( result.middleName.errors[1], 'rule' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.middleName.errors[1].rule), "'result.middleName.errors[1].rule' is not a valid UUID" ) />
			<cfset base.middleName.errors[1].rule = result.middleName.errors[1].rule />
		<cfelse>
			<cfset assertTrue( 0, "'result.middleName.errors' error collection is missing or not properly formated" ) />
		</cfif>
		
		<!--- run the assertions --->
		<cfset assertEqualsNumber( base._errorCount, result._errorCount, "The expected error count was #base._errorCount#, but an error count of #result._errorCount# was received." ) />
		<cfset assertEqualsStruct( base.firstName, result.firstName, "The expected error collection for the firstName field was not received." ) />
		<cfset assertEqualsStruct( base.middleName, result.middleName, "The expected error collection for the middleName field was not received." ) />

	</cffunction> <!--- end: test_validate_SimpleStruct() --->

	<!--- 
		function: 		test_validate_CompleteStruct_valid

		description:	I will test the validate function, using the complete configuration file and a basic data 
						structure collection.
	--->
	<cffunction name="test_validate_CompleteStruct_valid" access="public" returntype="void"
		hint="I will test the validate function, using the complete configuration file and a basic data structure collection." >
	
		<!--- setup temporary variables --->
		<cfset var dataStr = structNew() />
		<cfset var base = structNew() />
		<cfset var baseTmp = structNew() />
		<cfset var result = structNew() />

		<!--- setup the test data structure --->
		<cfset dataStr.firstName = "John" />
		<cfset dataStr.lastName = "Doe" />
		<cfset dataStr.emailAddress = "jdoe@somewhere.com" />
		<cfset dataStr.billingAddress = structNew() />
		<cfset dataStr.billingAddress.street1 = "123 Somewhere" />
		<cfset dataStr.billingAddress.street2 = "Suite 123" />
		<cfset dataStr.billingAddress.city = "Somewhere" />
		<cfset dataStr.billingAddress.state = "CA" />
		<cfset dataStr.billingAddress.postalCode = "45678" />
		<cfset dataStr.billingAddress.country = "US" />
		<cfset dataStr.mailingAddress = structNew() />
		<cfset dataStr.mailingAddress.street1 = "123 Somewhere" />
		<cfset dataStr.mailingAddress.street2 = "Suite 123" />
		<cfset dataStr.mailingAddress.city = "Somewhere" />
		<cfset dataStr.mailingAddress.state = "CA" />
		<cfset dataStr.mailingAddress.postalCode = "45678" />
		<cfset dataStr.mailingAddress.country = "US" />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base = structNew() />
		<cfset base["_errorCount"] = 0 />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-complete.xml' ) />
		
		<!--- call the validate method, passing in the data structure, and get the errors from the resulting error collection --->
		<cfset result = variables.validat.validate( 'person', dataStr ).getErrors() />
		
		<!--- run the assertion --->
		<cfset assertEqualsNumber( base._errorCount, result._errorCount, "Unexpected errors were found in the test data." ) />
		<cfset assertEqualsStruct( base, result, "Unexpected errors were found in the test data." ) /> ) />
	</cffunction> <!--- end: test_validate_CompleteStruct_valid() --->

	<!--- 
		function: 		test_validate_CompleteStruct_withSkip

		description:	I will test the validate function, using the complete configuration file and a basic data 
						structure collection as well as a list of data elements to skip validation processing for.
	--->
	<cffunction name="test_validate_CompleteStruct_withSkip" access="public" returntype="void"
		hint="I will test the validate function, using the complete configuration file and a basic data structure collection." >
	
		<!--- setup temporary variables --->
		<cfset var dataStr = structNew() />
		<cfset var base = structNew() />
		<cfset var skip = "country" />
		<cfset var result = structNew() />

		<!--- setup the test data structure --->
		<cfset dataStr.street1 = "123 Somewhere" />
		<cfset dataStr.street2 = "Suite 123" />
		<cfset dataStr.city = "This is a string that is longer than 100 characters and should fail the length assertion rule for the city data element." />
		<cfset dataStr.state = "CA" />
		<cfset dataStr.postalCode = "45678" />
		<cfset dataStr.country = "" />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base = structNew() />
		<cfset base["_errorCount"] = 0 />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-complete.xml' ) />

		<!--- append the assertion identifier for the city/length rule to skip --->
		<cfset skip = skip & "," & variables.validat.getInstance().dataSets.address.dataElements..city.assertions[1].assertId />
		
		<!--- call the validate method, passing in the data structure, and get the errors from the resulting error collection --->
		<cfset result = variables.validat.validate( "address", dataStr, skip ).getErrors() />
		
		<!--- run the assertion --->
		<cfset assertEqualsNumber( base._errorCount, result._errorCount, "Unexpected errors were found in the test data." ) />
		<cfset assertEqualsStruct( base, result, "Unexpected errors were found in the test data." ) /> ) />
	</cffunction> <!--- end: test_validate_CompleteStruct_withSkip() --->

</cfcomponent>