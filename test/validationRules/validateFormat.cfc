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
	displayname="Validation Rules Test Suite - Format Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Format Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateFormat = createObject( "component", "validat.validationRules.validateFormat" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		testValidate_Valid_Phone

		description:	I will test the validate function, passing in a valid 10 digit phone number in the format "(xxx) xxx-xxxx".
	--->
	<cffunction name="testValidate_Valid_Phone" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 10 digit phone number in the format '(xxx) xxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "phone" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '(254) 234-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Phone() --->

	<!--- 
		function: 		testValidate_Invalid_Phone

		description:	I will test the validate function, passing in an invalid 10 digit phone number in the format "(xxx) xxx-xxxx".
	--->
	<cffunction name="testValidate_Invalid_Phone" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 10 digit phone number in the format '(xxx) xxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "phone" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '(123) 123-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_Phone() --->

	<!--- 
		function: 		testValidate_Valid_Phone2

		description:	I will test the validate function, passing in an invalid 10 digit phone number in the format "xxx-xxx-xxxx".
	--->
	<cffunction name="testValidate_Valid_Phone2" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 10 digit phone number in the format 'xxx-xxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "phone2" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '254-234-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Phone2() --->

	<!--- 
		function: 		testValidate_Invalid_Phone2

		description:	I will test the validate function, passing in an invalid 10 digit phone number in the format "xxx-xxx-xxxx".
	--->
	<cffunction name="testValidate_Invalid_Phone2" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid 10 digit phone number with format 'xxx-xxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "phone2" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '123 123 1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_Phone2() --->

	<!--- 
		function: 		testValidate_Valid_Phone3

		description:	I will test the validate function, passing in a valid 10 digit phone number in the format "xxx/xxx-xxxx".
	--->
	<cffunction name="testValidate_Valid_Phone3" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 10 digit phone number in the format 'xxx/xxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "phone3" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '254/234-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Phone3() --->

	<!--- 
		function: 		testValidate_Invalid_Phone3

		description:	I will test the validate function, passing in an invalid phone number in the format "xxx/xxx-xxxx".
	--->
	<cffunction name="testValidate_Invalid_Phone3" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid phone number in the format 'xxx/xxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "phone3" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '254/12-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_Phone3() --->

	<!--- 
		function: 		testValidate_Valid_Phone7

		description:	I will test the validate function, passing in a valid 7 digit phone number in the format "xxx-xxxx".
	--->
	<cffunction name="testValidate_Valid_Phone7" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 7 digit phone number in the format 'xxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "phone7" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '254-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Phone7() --->

	<!--- 
		function: 		testValidate_Invalid_Phone7

		description:	I will test the validate function, passing in an invalid 7 digit phone number in the format "xxx-xxxx".
	--->
	<cffunction name="testValidate_Invalid_Phone7" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid 7 digit phone number in the format 'xxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "phone7" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '123-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_Phone7() --->

	<!--- 
		function: 		testValidate_Valid_PostalCode

		description:	I will test the validate function, passing in a valid 5 digit postal(zip) code in the format "xxxxx".
	--->
	<cffunction name="testValidate_Valid_PostalCode" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 5 digit postal(zip) code in the format 'xxxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "postalCode" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '12345', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_PostalCode() --->

	<!--- 
		function: 		testValidate_Invalid_PostalCode

		description:	I will test the validate function, passing in an invalid postal(zip) code.
	--->
	<cffunction name="testValidate_Invalid_PostalCode" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid postal(zip) code." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "postalCode" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '12345?12', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_PostalCode() --->

	<!--- 
		function: 		testValidate_Valid_PostalCode2

		description:	I will test the validate function, passing in a valid 9 digit postal(zip) code in the format "xxxxx-xxxx".
	--->
	<cffunction name="testValidate_Valid_PostalCode2" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 9 digit postal(zip) code in the format 'xxxxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "postalCode" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '12345-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_PostalCode2() --->

	<!--- 
		function: 		testValidate_Valid_PostalCode5

		description:	I will test the validate function, passing in a valid 5 digit postal(zip) code in the format "xxxxx".
	--->
	<cffunction name="testValidate_Valid_PostalCode5" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 5 digit postal(zip) code in the format 'xxxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "postalCode5" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '12345', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_PostalCode5() --->

	<!--- 
		function: 		testValidate_Invalid_PostalCode5

		description:	I will test the validate function, passing in an invalid 5 digit postal(zip) code in the format "xxxxx".
	--->
	<cffunction name="testValidate_Invalid_PostalCode5" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid 5 digit postal(zip) code in the format 'xxxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "postalCode5" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '12A45', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_PostalCode5() --->

	<!--- 
		function: 		testValidate_Valid_PostalCode9

		description:	I will test the validate function, passing in a valid 9 digit postal(zip) code in the format "xxxxx-xxxx".
	--->
	<cffunction name="testValidate_Valid_PostalCode9" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid 9 digit postal(zip) code in the format 'xxxxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "postalCode" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '12345-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_PostalCode9() --->

	<!--- 
		function: 		testValidate_Invalid_PostalCode9

		description:	I will test the validate function, passing in an invalid 9 digit postal(zip) code in the format "xxxxx-xxxx".
	--->
	<cffunction name="testValidate_Invalid_PostalCode9" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid 9 digit postal(zip) code in the format 'xxxxx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "postalCode" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '12A45-124', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_PostalCode9() --->

	<!--- 
		function: 		testValidate_Valid_SSN

		description:	I will test the validate function, passing in a valid social security number in the format "xxx-xx-xxxx".
	--->
	<cffunction name="testValidate_Valid_SSN" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid social security number in the format 'xxx-xx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "ssn" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '123-12-1234', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_SSN() --->

	<!--- 
		function: 		testValidate_Invalid_SSN

		description:	I will test the validate function, passing in an invalid social security number in the format "xxx-xx-xxxx".
	--->
	<cffunction name="testValidate_Invalid_SSN" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid social security number in the format 'xxx-xx-xxxx'." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "ssn" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '1A3-12-124', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_SSN() --->

	<!--- 
		function: 		testValidate_Valid_Custom

		description:	I will test the validate function, passing in a custom regular expression string representing an AMEX credit card number,
						along with a valid credit card data string.
	--->
	<cffunction name="testValidate_Valid_Custom" access="public" returntype="void"
		hint="I will test the validate function, passing in a custom regular expression string representing an AMEX credit card number." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "^3[47]\d{13}$" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '378282246310005', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: testValidate_Valid_Custom() --->

	<!--- 
		function: 		testValidate_Invalid_Custom

		description:	I will test the validate function, passing in a custom regular expression string representing an AMEX credit card number,
						along with an invalid credit card data string.
	--->
	<cffunction name="testValidate_Invalid_Custom" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid, alpha numeric data string." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.format = "^3[47]\d{13}$" />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateFormat.validate( '30000000000004', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: testValidate_Invalid_Custom() --->

	<!--- 
		function: 		testValidate_ComplexData

		description:	I will test the validate function, passing in a complex data structure which should result in an error.
	--->
	<cffunction name="testValidate_ComplexData" access="public" returntype="void"
		hint="I will test the validate function, passing in a complex data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateFormat.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateFormat.validate( structNew() ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testValidate_ComplexData() --->

</cfcomponent>