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
	displayname="Validat Library - Validation Rules - All Tests"
	output="false"
	extends="org.cfcunit.Object"
	hint="Unit test suite for the Validat Validation Rules.">

	<!--- ------------------------------------------------------------ --->
	<!--- test suite --->

	<cffunction name="suite" access="public" output="false" returntype="org.cfcunit.framework.Test"
		hint="I will setup a suite of unit tests to all be run at the same time" >
		
		<cfset var testSuite = newObject( "org.cfcunit.framework.TestSuite" ).init( "Validat Tests" )>
		
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateAlpha" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateAlphaNumeric" ) ) />
		<!--- <cfset testSuite.addTestSuite( newObject( "test.validationRules.validateBirthDate" ) ) /> --->
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateCreditCard" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateDate" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateDifferent" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateEmail" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateFormat" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateInteger" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateLength" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateLengthGT" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateLengthLT" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateNotEmpty" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateNumeric" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validatePhoneNumber" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateRange" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateSame" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateSSN" ) ) />
		<cfset testSuite.addTestSuite( newObject( "test.validationRules.validateValueInList" ) ) />
		
		<cfreturn testSuite/>
	</cffunction> <!--- end: suite() --->

</cfcomponent>