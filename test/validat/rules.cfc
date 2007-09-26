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
		function: 		test_addRule_NewRule

		description:	I will test the addRule function, starting with an no configuration and attempting to
						programmatically add a validation rule.
	--->
	<cffunction name="test_addRule_NewRule" access="public" returntype="void"
		hint="I will test the addRule function, starting with an no configuration and attempting to programmatically add a validation rule." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var base = structNew() />
		<cfset var result = structNew() />
		
		<!--- verify the addRule method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "addRule"), "addRule method is not defined" ) />
		
		<!--- get the metadata for the addRule method --->
		<cfset metaData = getMetaData( variables.validat.addRule ) />
		
		<!--- verify the addRule method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "validat", "Return type is not defined or is not 'validat'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.dataSets = structNew() />
		<cfset base.factory = variables.factory />
		<Cfset base.validationRules = structNew() />

		<cfset base.validationRules.alpha = structNew() />
		<cfset base.validationRules.alpha.args = structNew() />
		<cfset base.validationRules.alpha.messages = structNew() />
		<cfset base.validationRules.alpha.name = "alpha" />
		<cfset base.validationRules.alpha.validator = "validateAlpha" />

		<!--- call the init method, only passing the factory reference --->
		<cfset variables.validat.init( variables.factory ) />
		
		<!--- attempt to add a validation rule --->
		<cfset variables.validat.addRule( 'alpha', 'validateAlpha' ) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base.dataSets, result.dataSets, "The operation affected the data set collection when it should not have" ) />
		<cfset assertEqualsStruct( base.validationRules, result.validationRules, "The rule was not properly added to the validation rules structure" ) />
	</cffunction> <!--- end: test_addRule_NewRule() --->

	<!--- 
		function: 		test_addRule_ExistingRule

		description:	I will test the addRule function, starting with an existing configuration and attempting to 
						programmatically add a validation rule that matches an existing rule.
	--->
	<cffunction name="test_addRule_ExistingRule" access="public" returntype="void"
		hint="I will test the addRule function, starting with an existing configuration and attempting to programmatically add a validation rule that matches an existing rule." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var base = structNew() />
		<cfset var dataStr = structNew() />
		<cfset var result = structNew() />
		
		<!--- verify the addRule method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "addRule"), "addRule method is not defined" ) />
		
		<!--- get the metadata for the addRule method --->
		<cfset metaData = getMetaData( variables.validat.addRule ) />
		
		<!--- verify the addRule method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "validat", "Return type is not defined or is not 'validat'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

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

		<!--- attempt to retrieve dynamic assertionID values and insert into base data structure for later comparison --->
		<cfif isDefined( "result.dataSets.user.assertionIDList" )>
			<cfloop list="#result.dataSets.user.assertionIDList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.assertionIDList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.assertionIDList = result.dataSets.user.assertionIDList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.assertionIDList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.firstName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.firstName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.firstName.assertionIdList = result.dataSets.user.dataElements.firstName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.firstName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.firstName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.firstName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.firstName.assertions[1].assertId ), "'result.dataSets.user.dataElements.firstName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.firstName.assertions[1].assertId = result.dataSets.user.dataElements.firstName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.middleName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.middleName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.middleName.assertionIdList = result.dataSets.user.dataElements.middleName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.middleName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.middleName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.middleName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.middleName.assertions[1].assertId ), "'result.dataSets.user.dataElements.middleName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.middleName.assertions[1].assertId = result.dataSets.user.dataElements.middleName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.lastName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.lastName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.lastName.assertionIdList = result.dataSets.user.dataElements.lastName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.lastName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.lastName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.lastName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.lastName.assertions[1].assertId ), "'result.dataSets.user.dataElements.lastName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.lastName.assertions[1].assertId = result.dataSets.user.dataElements.lastName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName' assertion definition is missing or not properly formated" ) />
		</cfif>
				
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base.dataSets, result.dataSets, "The operation affected the data set collection when it should not have" ) />
		<cfset assertEqualsStruct( base.validationRules, result.validationRules, "The rule was not properly added to the validation rules structure" ) />
	</cffunction> <!--- end: test_addRule_ExistingRule() --->

	<!--- 
		function: 		test_addRuleXML_NewRule

		description:	I will test the addRule function, starting with an no configuration and attempting to
						programmatically add a validation rule.
	--->
	<cffunction name="test_addRuleXML_NewRule" access="public" returntype="void"
		hint="I will test the addRule function, starting with an no configuration and attempting to programmatically add a validation rule." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var base = structNew() />
		<cfset var data = "" />
		<cfset var result = structNew() />
		
		<!--- verify the addRuleXML method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "addRuleXML"), "addRuleXML method is not defined" ) />
		
		<!--- get the metadata for the addRuleXML method --->
		<cfset metaData = getMetaData( variables.validat.addRuleXML ) />
		
		<!--- verify the addRule method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "validat", "Return type is not defined or is not 'validat'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.dataSets = structNew() />
		<cfset base.factory = variables.factory />
		<Cfset base.validationRules = structNew() />

		<cfset base.validationRules.alpha = structNew() />
		<cfset base.validationRules.alpha.args = structNew() />
		<cfset base.validationRules.alpha.messages = structNew() />
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
		<cfset assertEqualsStruct( base.dataSets, result.dataSets, "The operation affected the data set collection when it should not have" ) />
		<cfset assertEqualsStruct( base.validationRules, result.validationRules, "The rule was not properly added to the validation rules structure" ) />
	</cffunction> <!--- end: test_addRuleXML_NewRule() --->

	<!--- 
		function: 		test_addRuleXML_ExistingRule

		description:	I will test the addRule function, starting with an existing configuration and attempting to 
						programmatically add a validation rule that matches an existing rule.
	--->
	<cffunction name="test_addRuleXML_ExistingRule" access="public" returntype="void"
		hint="I will test the addRule function, starting with an existing configuration and attempting to programmatically add a validation rule that matches an existing rule." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var base = structNew() />
		<cfset var data = "" />
		<cfset var result = structNew() />
		
		<!--- verify the addRuleXML method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "addRuleXML"), "addRuleXML method is not defined" ) />
		
		<!--- get the metadata for the addRuleXML method --->
		<cfset metaData = getMetaData( variables.validat.addRuleXML ) />
		
		<!--- verify the addRuleXML method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "validat", "Return type is not defined or is not 'validat'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

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

		<!--- attempt to retrieve dynamic assertionID values and insert into base data structure for later comparison --->
		<cfif isDefined( "result.dataSets.user.assertionIDList" )>
			<cfloop list="#result.dataSets.user.assertionIDList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.assertionIDList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.assertionIDList = result.dataSets.user.assertionIDList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.assertionIDList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.firstName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.firstName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.firstName.assertionIdList = result.dataSets.user.dataElements.firstName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.firstName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.firstName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.firstName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.firstName.assertions[1].assertId ), "'result.dataSets.user.dataElements.firstName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.firstName.assertions[1].assertId = result.dataSets.user.dataElements.firstName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.middleName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.middleName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.middleName.assertionIdList = result.dataSets.user.dataElements.middleName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.middleName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.middleName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.middleName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.middleName.assertions[1].assertId ), "'result.dataSets.user.dataElements.middleName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.middleName.assertions[1].assertId = result.dataSets.user.dataElements.middleName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.lastName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.lastName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.lastName.assertionIdList = result.dataSets.user.dataElements.lastName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.lastName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.lastName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.lastName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.lastName.assertions[1].assertId ), "'result.dataSets.user.dataElements.lastName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.lastName.assertions[1].assertId = result.dataSets.user.dataElements.lastName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName' assertion definition is missing or not properly formated" ) />
		</cfif>
				
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base.dataSets, result.dataSets, "The operation affected the data set collection when it should not have" ) />
		<cfset assertEqualsStruct( base.validationRules, result.validationRules, "The rule was not properly added to the validation rules structure" ) />
	</cffunction> <!--- end: test_addRuleXML_ExistingRule() --->

	<!--- 
		function: 		test_getAllRules

		description:	I will test the getAllRules function, utilizing an existing configuration.
	--->
	<cffunction name="test_getAllRules" access="public" returntype="void"
		hint="I will test the getAllRules function, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var base = structNew() />
		<cfset var result = structNew() />
		
		<!--- verify the getAllRules method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "getAllRules"), "getAllRules method is not defined" ) />
		
		<!--- get the metadata for the getAllRules method --->
		<cfset metaData = getMetaData( variables.validat.getAllRules ) />
		
		<!--- verify the getAllRules method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "struct", "Return type is not defined or is not 'struct'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.alpha = structNew() />
		<cfset base.alpha.args = structNew() />
		<cfset base.alpha.messages = structNew() />
		<cfset base.alpha.name = "alpha" />
		<cfset base.alpha.validator = "validateAlpha" />
		
		<cfset base.alphaNumeric = structNew() />
		<cfset base.alphaNumeric.args = structNew() />
		<cfset base.alphaNumeric.messages = structNew() />
		<cfset base.alphaNumeric.name = "alphaNumeric" />
		<cfset base.alphaNumeric.validator = "validateAlphaNumeric" />
		
		<cfset base.length = structNew() />
		<cfset base.length.args = structNew() />
		<cfset base.length.messages = structNew() />
		<cfset base.length.name = "length" />
		<cfset base.length.validator = "validateLength" />
		
		<cfset base.length.args.max = 100 />
		<cfset base.length.args.min = 0 />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the getAllRules method --->
		<cfset result = variables.validat.getAllRules() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result, "The rules structure returned was not as expected" ) />
	</cffunction> <!--- end: test_getAllRules() --->

	<!--- 
		function: 		test_getRule

		description:	I will test the getRule function, utilizing an existing configuration.
	--->
	<cffunction name="test_getRule" access="public" returntype="void"
		hint="I will test the getRule function, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var base = structNew() />
		<cfset var result = structNew() />
		
		<!--- verify the getRule method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "getRule"), "getRule method is not defined" ) />
		
		<!--- get the metadata for the getRule method --->
		<cfset metaData = getMetaData( variables.validat.getRule ) />
		
		<!--- verify the getRule method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "struct", "Return type is not defined or is not 'struct'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.args = structNew() />
		<cfset base.messages = structNew() />
		<cfset base.name = "length" />
		<cfset base.validator = "validateLength" />
		
		<cfset base.args.max = 100 />
		<cfset base.args.min = 0 />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the getRule method --->
		<cfset result = variables.validat.getRule( 'length' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct( base, result, "The rules structure returned was not as expected" ) />
	</cffunction> <!--- end: test_getRule() --->

	<!--- 
		function: 		test_getRule_InvalidRule

		description:	I will test the getRule function, requesting an invalid rule, utilizing an existing configuration.
	--->
	<cffunction name="test_getRule_InvalidRule" access="public" returntype="void"
		hint="I will test the getRule function, requesting an invalid rule, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var result = structNew() />
		
		<!--- verify the getRule method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "getRule"), "getRule method is not defined" ) />
		
		<!--- get the metadata for the getRule method --->
		<cfset metaData = getMetaData( variables.validat.getRule ) />
		
		<!--- verify the getRule method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "struct", "Return type is not defined or is not 'struct'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

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
		
	</cffunction> <!--- end: test_getRule_InvalidRule() --->

	<!--- 
		function: 		test_remRule

		description:	I will test the remRule function, utilizing an existing configuration.
	--->
	<cffunction name="test_remRule" access="public" returntype="void"
		hint="I will test the remRule function, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var base = structNew() />
		<cfset var result = structNew() />
		
		<!--- verify the remRule method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "remRule"), "remRule method is not defined" ) />
		
		<!--- get the metadata for the remRule method --->
		<cfset metaData = getMetaData( variables.validat.remRule ) />
		
		<!--- verify the remRule method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "validat", "Return type is not defined or is not 'validat'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

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

		<!--- attempt to retrieve dynamic assertionID values and insert into base data structure for later comparison --->
		<cfif isDefined( "result.dataSets.user.assertionIDList" )>
			<cfloop list="#result.dataSets.user.assertionIDList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.assertionIDList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.assertionIDList = result.dataSets.user.assertionIDList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.assertionIDList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.firstName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.firstName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.firstName.assertionIdList = result.dataSets.user.dataElements.firstName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.firstName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.firstName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.firstName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.firstName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.firstName.assertions[1].assertId ), "'result.dataSets.user.dataElements.firstName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.firstName.assertions[1].assertId = result.dataSets.user.dataElements.firstName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.firstName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.middleName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.middleName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.middleName.assertionIdList = result.dataSets.user.dataElements.middleName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.middleName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.middleName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.middleName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.middleName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.middleName.assertions[1].assertId ), "'result.dataSets.user.dataElements.middleName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.middleName.assertions[1].assertId = result.dataSets.user.dataElements.middleName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.middleName' assertion definition is missing or not properly formated" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertionIdList" )>
			<cfloop list="#result.dataSets.user.dataElements.lastName.assertionIdList#" index="assertId">
				<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", assertId ), "'result.dataSets.user.dataElements.lastName.assertionIdList' contains an invalid value" ) />
			</cfloop>
			<cfset base.dataSets.user.dataElements.lastName.assertionIdList = result.dataSets.user.dataElements.lastName.assertionIdList />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName.assertionIdList' is missing from the result data structure" ) />
		</cfif>

		<cfif isDefined( "result.dataSets.user.dataElements.lastName.assertions" ) AND 
			  isArray( result.dataSets.user.dataElements.lastName.assertions ) AND
			  arrayLen( result.dataSets.user.dataElements.lastName.assertions ) EQ 1 AND
			  structKeyExists ( result.dataSets.user.dataElements.lastName.assertions[1], 'assertId' ) >
			<cfset assertTrue( reFindNoCase( "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{16}$", result.dataSets.user.dataElements.lastName.assertions[1].assertId ), "'result.dataSets.user.dataElements.lastName.assertions[1].assertId' is not a valid UUID" ) />
			<cfset base.dataSets.user.dataElements.lastName.assertions[1].assertId = result.dataSets.user.dataElements.lastName.assertions[1].assertId />
		<cfelse>
			<cfset assertTrue( 0, "'result.dataSets.user.dataElements.lastName' assertion definition is missing or not properly formated" ) />
		</cfif>
		
		<!--- run the assertions --->
		<cfset assertEqualsStruct( base.dataSets, result.dataSets, "The operation affected the data set collection when it should not have" ) />
		<cfset assertEqualsStruct( base.validationRules, result.validationRules, "The rule was not properly removed from the validation rules structure" ) />
	</cffunction> <!--- end: test_remRule() --->

	<!--- 
		function: 		test_remRule_InvalidRule

		description:	I will test the remRule function, providing an invalid rule name, utilizing an existing configuration.
	--->
	<cffunction name="test_remRule_InvalidRule" access="public" returntype="void"
		hint="I will test the remRule function, providing an invalid rule name, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var result = structNew() />
		
		<!--- verify the remRule method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "remRule"), "remRule method is not defined" ) />
		
		<!--- get the metadata for the remRule method --->
		<cfset metaData = getMetaData( variables.validat.remRule ) />
		
		<!--- verify the remRule method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "validat", "Return type is not defined or is not 'validat'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

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

	</cffunction> <!--- end: test_remRule_InvalidRule() --->

	<!--- 
		function: 		test_ruleExists

		description:	I will test the ruleExists function, utilizing an existing configuration.
	--->
	<cffunction name="test_ruleExists" access="public" returntype="void"
		hint="I will test the ruleExists function, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var result = structNew() />
		
		<!--- verify the ruleExists method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "ruleExists"), "ruleExists method is not defined" ) />
		
		<!--- get the metadata for the ruleExists method --->
		<cfset metaData = getMetaData( variables.validat.ruleExists ) />
		
		<!--- verify the ruleExists method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "boolean", "Return type is not defined or is not 'boolean'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the remRule method --->
		<cfset result = variables.validat.ruleExists( 'length' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsBoolean( true, result, "A matching rule was not found when one should have been" ) />
	</cffunction> <!--- end: test_ruleExists() --->

	<!--- 
		function: 		test_ruleExists_InvalidRule

		description:	I will test the ruleExists function, providing an invalid rule name, utilizing an existing configuration.
	--->
	<cffunction name="test_ruleExists_InvalidRule" access="public" returntype="void"
		hint="I will test the ruleExists function, providing an invalid rule name, utilizing an existing configuration." >
	
		<!--- setup temporary variables --->
		<cfset var metaData = "" />
		<cfset var result = structNew() />
		
		<!--- verify the ruleExists method exists --->
		<cfset assertTrue( structKeyExists( variables.validat, "ruleExists"), "ruleExists method is not defined" ) />
		
		<!--- get the metadata for the ruleExists method --->
		<cfset metaData = getMetaData( variables.validat.ruleExists ) />
		
		<!--- verify the ruleExists method signature --->
		<cfset assertTrue( structKeyExists( metaData, "returnType" ) AND metaData.returnType EQ "boolean", "Return type is not defined or is not 'boolean'" ) />
		<cfset assertTrue( structKeyExists( metaData, "access" ) AND metaData.access EQ "public", "Access is not defined or is not public" ) />

		<!--- call the init method, passing the factory reference and path to the simple configuration xml file --->
		<cfset variables.validat.init( variables.factory, '/test/testData/validat-simple.xml' ) />
		
		<!--- call the remRule method --->
		<cfset result = variables.validat.ruleExists( 'someNonExistentRuleName' ) />
		
		<!--- run the assertion --->
		<cfset assertEqualsBoolean( false, result, "A matching rule was found when one should not have been" ) />
	</cffunction> <!--- end: test_ruleExists_InvalidRule() --->

</cfcomponent>