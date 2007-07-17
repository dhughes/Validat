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
	displayname="Validat Test Suite - Validation Rules"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test suite for the Validat object - validation rule tests.">

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
		function: 		testAddRule_NewRule

		description:	I will test the addRule function, starting with an no configuration and attempting to
						programmatically add a validation rule.
	--->
	<cffunction name="testAddRule_NewRule" access="public" returntype="void"
		hint="I will test the addRule function, starting with an no configuration and attempting to programmatically add a validation rule." >
	
		<!--- setup temporary variables --->
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.dataSets = structNew() />
		<cfset base.factory = variables.factory />
		<Cfset base.validationRules = structNew() />

		<cfset base.validationRules.alpha = structNew() />
		<cfset base.validationRules.alpha.name = "alpha" />
		<cfset base.validationRules.alpha.validator = "validateAlpha" />

		<!--- call the init method, only passing the factory reference --->
		<cfset variables.validat.init( variables.factory ) />
		
		<!--- attempt to add a validation rule --->
		<cfset variables.validat.addRule( 'alpha', 'validateAlpha' ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result ) />
	</cffunction> <!--- end: testAddRule_NewRule() --->

	<!--- 
		function: 		testAddRule_ExistingRule

		description:	I will test the addRule function, starting with an existing configuration and attempting to 
						programmatically add a validation rule that matches an existing rule.
	--->
	<cffunction name="testAddRule_ExistingRule" access="public" returntype="void"
		hint="I will test the addRule function, starting with an existing configuration and attempting to programmatically add a validation rule that matches an existing rule." >
	
		<!--- setup temporary variables --->
		<cfset var dataStr = structNew() />
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.factory = variables.factory />
		<cfinclude template="/test/testData/validat-simple.cfm" />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- attempt to add a validation rule --->
		<cfset dataStr.min = 0 />
		<cfset dataStr.max = 100 />
		<cfset variables.validat.addRule( 'length', 'validateLength', dataStr ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result ) />
	</cffunction> <!--- end: testAddRule_ExistingRule() --->

	<!--- 
		function: 		testAddRuleXML_NewRule

		description:	I will test the addRule function, starting with an no configuration and attempting to
						programmatically add a validation rule.
	--->
	<cffunction name="testAddRuleXML_NewRule" access="public" returntype="void"
		hint="I will test the addRule function, starting with an no configuration and attempting to programmatically add a validation rule." >
	
		<!--- setup temporary variables --->
		<cfset var data = "" />
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.dataSets = structNew() />
		<cfset base.factory = variables.factory />
		<Cfset base.validationRules = structNew() />

		<cfset base.validationRules.alpha = structNew() />
		<cfset base.validationRules.alpha.name = "alpha" />
		<cfset base.validationRules.alpha.validator = "validateAlpha" />

		<!--- call the init method, only passing the factory reference --->
		<cfset variables.validat.init( variables.factory ) />
		
		<!--- build the validation rule xml object --->
		<cfset data = xmlNew() />
		<cfset data.xmlRoot = xmlElemNew( data, "rule" ) />
		<cfset data.rule.xmlAttributes.name = "alpha" />
		<cfset data.rule.xmlAttributes.validator = "validateAlpha" />
		
		<!--- attempt to add a validation rule --->
		<cfset variables.validat.addRuleXML( toString( data ) ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result ) />
	</cffunction> <!--- end: testAddRuleXML_NewRule() --->

	<!--- 
		function: 		testAddRuleXML_ExistingRule

		description:	I will test the addRule function, starting with an existing configuration and attempting to 
						programmatically add a validation rule that matches an existing rule.
	--->
	<cffunction name="testAddRuleXML_ExistingRule" access="public" returntype="void"
		hint="I will test the addRule function, starting with an existing configuration and attempting to programmatically add a validation rule that matches an existing rule." >
	
		<!--- setup temporary variables --->
		<cfset var data = "" />
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.factory = variables.factory />
		<cfinclude template="/test/testData/validat-simple.cfm" />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- build the validation rule xml object --->
		<cfset data = xmlNew() />
		<cfset data.xmlRoot = xmlElemNew( data, "rule" ) />
		<cfset data.rule.xmlAttributes.name = "length" />
		<cfset data.rule.xmlAttributes.validator = "validateLength" />
		<cfset data.rule.xmlChildren[1] = xmlElemNew( data, "arg" ) />
		<cfset data.rule.xmlChildren[1].xmlAttributes.name = "min" />
		<cfset data.rule.xmlChildren[1].xmlAttributes.value = "0" />
		<cfset data.rule.xmlChildren[2] = xmlElemNew( data, "arg" ) />
		<cfset data.rule.xmlChildren[2].xmlAttributes.name = "max" />
		<cfset data.rule.xmlChildren[2].xmlAttributes.value = "100" />
		
		<!--- attempt to add a validation rule --->
		<cfset variables.validat.addRuleXML( toString( data ) ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result ) />
	</cffunction> <!--- end: testAddRuleXML_ExistingRule() --->

	<!--- 
		function: 		testGetAllRules

		description:	I will test the getAllRules function, utilizing an existing configuration.
	--->
	<cffunction name="testGetAllRules" access="public" returntype="void"
		hint="I will test the getAllRules function, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.alpha = structNew() />
		<cfset base.alpha.name = "alpha" />
		<cfset base.alpha.validator = "validateAlpha" />
		
		<cfset base.alphaNumeric = structNew() />
		<cfset base.alphaNumeric.name = "alphaNumeric" />
		<cfset base.alphaNumeric.validator = "validateAlphaNumeric" />
		
		<cfset base.length = structNew() />
		<cfset base.length.args = structNew() />
		<cfset base.length.name = "length" />
		<cfset base.length.validator = "validateLength" />
		
		<cfset base.length.args.max = 100 />
		<cfset base.length.args.min = 0 />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the getAllRules method --->
		<cfset result = variables.validat.getAllRules() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result ) />
	</cffunction> <!--- end: testGetAllRules() --->

	<!--- 
		function: 		testGetRule

		description:	I will test the getRule function, utilizing an existing configuration.
	--->
	<cffunction name="testGetRule" access="public" returntype="void"
		hint="I will test the getRule function, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.args = structNew() />
		<cfset base.name = "length" />
		<cfset base.validator = "validateLength" />
		
		<cfset base.args.max = 100 />
		<cfset base.args.min = 0 />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the getRule method --->
		<cfset result = variables.validat.getRule( 'length' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result ) />
	</cffunction> <!--- end: testGetRule() --->

	<!--- 
		function: 		testGetRule_InvalidRule

		description:	I will test the getRule function, requesting an invalid rule, utilizing an existing configuration.
	--->
	<cffunction name="testGetRule_InvalidRule" access="public" returntype="void"
		hint="I will test the getRule function, requesting an invalid rule, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the getRule method, requesting an invalid rule --->
			<cfset result = variables.validat.getRule( 'someNonExistentRuleName' ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidRule was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidRule" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->
		
	</cffunction> <!--- end: testGetRule_InvalidRule() --->

	<!--- 
		function: 		testRemRule

		description:	I will test the remRule function, utilizing an existing configuration.
	--->
	<cffunction name="testRemRule" access="public" returntype="void"
		hint="I will test the remRule function, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var base = structNew() />
		<cfset var result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.factory = variables.factory />
		<cfinclude template="/test/testData/validat-simple.cfm" />
		<cfset structDelete( base.validationRules, 'length' ) />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the remRule method --->
		<cfset variables.validat.remRule( 'length' ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result ) />
	</cffunction> <!--- end: testRemRule() --->

	<!--- 
		function: 		testRemRule_InvalidRule

		description:	I will test the remRule function, providing an invalid rule name, utilizing an existing configuration.
	--->
	<cffunction name="testRemRule_InvalidRule" access="public" returntype="void"
		hint="I will test the remRule function, providing an invalid rule name, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var result = structNew() />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<cftry> <!--- catch the expected error --->
			
			<!--- call the remRule method, requesting an invalid rule --->
			<cfset variables.validat.remRule( 'someNonExistentRuleName' ) />
			
			<!--- if an error is not thrown, show this error in the unit test --->
			<cfset fail( "validat.invalidRule was not thrown" ) />
			
			<!--- catch the expected error --->
			<cfcatch type="validat.invalidRule" ></cfcatch>

		</cftry> <!--- end: catch the expected error --->

	</cffunction> <!--- end: testRemRule_InvalidRule() --->

	<!--- 
		function: 		testRuleExists

		description:	I will test the ruleExists function, utilizing an existing configuration.
	--->
	<cffunction name="testRuleExists" access="public" returntype="void"
		hint="I will test the ruleExists function, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var result = "" />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the remRule method --->
		<cfset result = variables.validat.ruleExists( 'length' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsBoolean( true, result ) />
	</cffunction> <!--- end: testRuleExists() --->

	<!--- 
		function: 		testRuleExists_InvalidRule

		description:	I will test the ruleExists function, providing an invalid rule name, utilizing an existing configuration.
	--->
	<cffunction name="testRuleExists_InvalidRule" access="public" returntype="void"
		hint="I will test the ruleExists function, providing an invalid rule name, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var result = "" />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the remRule method --->
		<cfset result = variables.validat.ruleExists( 'someNonExistentRuleName' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsBoolean( false, result ) />
	</cffunction> <!--- end: testRuleExists_InvalidRule() --->

</cfcomponent>