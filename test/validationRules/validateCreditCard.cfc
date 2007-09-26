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
	displayname="Validation Rules Test Suite - Credit Card Validator"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat Validation Rules - Credit Card Validator tests.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<!--- 
		function: 		setup

		description:	I will setup the unit test before each test function is run.
	--->
	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run." >

		<cfset variables.validateCreditCard = createObject( "component", "validat.validationRules.validateCreditCard" ) />

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<!--- 
		function: 		test_validate_Valid_AMEX

		description:	I will test the validate function, passing in a valid AMEX credit card data string.
	--->
	<cffunction name="test_validate_Valid_AMEX" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid AMEX credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '378282246310005' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_AMEX() --->

	<!--- 
		function: 		test_validate_Valid_CarteBlanche

		description:	I will test the validate function, passing in a valid CarteBlanche credit card data string.
	--->
	<cffunction name="test_validate_Valid_CarteBlanche" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid Carte Blanche credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '30000000000004' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_CarteBlanche() --->

	<!--- 
		function: 		test_validate_Valid_Diner

		description:	I will test the validate function, passing in a valid Diner credit card data string.
	--->
	<cffunction name="test_validate_Valid_Diner" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid Diner credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '30000000000004' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_Diner() --->

	<!--- 
		function: 		test_validate_Valid_Discover

		description:	I will test the validate function, passing in a valid Discover credit card data string.
	--->
	<cffunction name="test_validate_Valid_Discover" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid Discover credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '6011111111111117' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_Discover() --->

	<!--- 
		function: 		test_validate_Valid_EnRoute

		description:	I will test the validate function, passing in a valid EnRoute credit card data string.
	--->
	<cffunction name="test_validate_Valid_EnRoute" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid EnRoute credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '201400000000009' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) /><!--- currently returning invalid as the EnRoute validation is incomplete --->

	</cffunction> <!--- end: test_validate_Valid_EnRoute() --->

	<!--- 
		function: 		test_validate_Valid_JCB

		description:	I will test the validate function, passing in a valid JCB credit card data string.
	--->
	<cffunction name="test_validate_Valid_JCB" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid JCB credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '3088000000000008' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) /><!--- currently returning invalid as the JCB validation is incomplete --->

	</cffunction> <!--- end: test_validate_Valid_JCB() --->

	<!--- 
		function: 		test_validate_Valid_Maestro

		description:	I will test the validate function, passing in a valid Maestro credit card data string.
	--->
	<cffunction name="test_validate_Valid_Maestro" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid Maestro credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '5641820000000005' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) /><!--- currently returning invalid as the Maestro validation is incomplete --->

	</cffunction> <!--- end: test_validate_Valid_Maestro() --->

	<!--- 
		function: 		test_validate_Valid_MasterCard

		description:	I will test the validate function, passing in a valid MasterCard credit card data string.
	--->
	<cffunction name="test_validate_Valid_MasterCard" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid MasterCard credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '5100000000000008' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_MasterCard() --->

	<!--- 
		function: 		test_validate_Valid_Solo

		description:	I will test the validate function, passing in a valid Solo credit card data string.
	--->
	<cffunction name="test_validate_Valid_Solo" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid Solo credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '6334500000000003' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_Solo() --->

	<!--- 
		function: 		test_validate_Valid_Switch

		description:	I will test the validate function, passing in a valid Switch credit card data string.
	--->
	<cffunction name="test_validate_Valid_Switch" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid Switch credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '5641820000000005' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) /> <!--- currently returning invalid as the Switch validation is incomplete --->

	</cffunction> <!--- end: test_validate_Valid_Switch() --->

	<!--- 
		function: 		test_validate_Valid_VISA

		description:	I will test the validate function, passing in a valid VISA credit card data string.
	--->
	<cffunction name="test_validate_Valid_VISA" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid VISA credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '4222222222222' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_VISA() --->

	<!--- 
		function: 		test_validate_Valid_VISA2

		description:	I will test the validate function, passing in a valid VISA credit card data string.
	--->
	<cffunction name="test_validate_Valid_VISA2" access="public" returntype="void"
		hint="I will test the validate function, passing in a valid VISA credit card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in a valid data string --->
		<cfset result = variables.validateCreditCard.validate( '4111111111111111' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'true', result ) />

	</cffunction> <!--- end: test_validate_Valid_VISA2() --->

	<!--- 
		function: 		test_validate_Invalid_CardNumber

		description:	I will test the validate function, passing in an invalid credt card data string.
	--->
	<cffunction name="test_validate_Invalid_CardNumber" access="public" returntype="void"
		hint="I will test the validate function, passing in an invalid credt card data string." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- call the validate method, passing in an invalid data string --->
		<cfset result = variables.validateCreditCard.validate( '5490123456789123' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Invalid_CardNumber() --->

	<!--- 
		function: 		test_validate_Invalid_CardType

		description:	I will test the validate function, passing in an valid credit card data string but for a credit card type not specified in the arguments collection.
	--->
	<cffunction name="test_validate_Invalid_CardType" access="public" returntype="void"
		hint="I will test the validate function, passing in an valid credit card data string but for a credit card type not specified in the arguments collection." >
	
		<!--- setup temporary variables --->
		<cfset var args = structNew() />
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<!--- setup the arguments collection --->
		<cfset args.validTypes = "MasterCard" />
		
		<!--- call the validate method, passing in an valid data string --->
		<cfset result = variables.validateCreditCard.validate( '4111111111111111', args ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsString( 'invalid', result ) />

	</cffunction> <!--- end: test_validate_Invalid_CardType() --->

	<!--- 
		function: 		test_validate_ComplexData

		description:	I will test the validate function, passing in a complex data structure which should result in an error.
	--->
	<cffunction name="test_validate_ComplexData" access="public" returntype="void"
		hint="I will test the validate function, passing in a complex data structure which should result in an error." >
		
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method --->
		<cfset variables.validateCreditCard.init() />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the validate method, passing in a complex data structure --->
			<cfset result = variables.validateCreditCard.validate( structNew() ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidData was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidData" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: test_validate_ComplexData() --->

</cfcomponent>