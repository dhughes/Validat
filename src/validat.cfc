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
	displayname="validat"
	output="false"
	hint="Provides a configurable validation engine that is based upon a series of reusable, pluggable, validation methods which are executed against the data.">
	
	<!--- ------------------------------------------------------------ --->
	<!--- constructor --->

	<cffunction name="init" access="public" returntype="validat"
		hint="The default constructor for the validation engine, returning the initialized validator object instance">
		
		<cfargument name="factory" displayname="factory" type="any" required="true"
			hint="I am an instance of an object factory, from which the necessary validator and transformer objects will be requested." />
		<cfargument name="pathToConfigXML" displayname="pathToConfigXML" type="string" required="false"
			hint="I am the path to the configuration xml file to load." />

		<!--- create container for protected instance data --->
		<cfset variables.instance = structNew() />
		
		<!--- insert the validation rule, data set, and dependency collections into the instance data structure --->
		<cfset variables.instance.validationRules = structNew() />
		<cfset variables.instance.dataSets = structNew() />
		
		<!--- insert a pointer to the object factory into the instance data structure --->
		<cfset variables.instance.factory = arguments.factory />

		<!--- if a configuration file was provided, parse it --->
		<cfif isDefined('arguments.pathToConfigXML') AND len(trim(arguments.pathToConfigXML)) >
			<cfset parseConfigXML(arguments.pathToConfigXML) />
		</cfif>
		
		<cfdump var="#variables.instance#" /><cfabort>

		<!--- return the initialized validator --->
		<cfreturn this />	
	</cffunction> <!--- end: init() --->
	
	<!--- ------------------------------------------------------------ --->
	<!--- public methods --->

	<!--- 
		function: 		validate
	
		description:	Validates the provided data collection according to the specified data set and its associated data elements
						and assertions before returning a collection of errors.
	--->
	<cffunction name="validate" access="public" output="true" returntype="validat.common.errorCollection"
		hint="Validate the provided data collection according to the specified data set and its associated data elements and assertions">

		<cfargument name="dataSetName" type="string" required="true" hint="The name of the data set by which to validate the data collection" />
		<cfargument name="dataCollection" type="any" required="true" hint="The data collection to be validated" />

		<!--- setup temporary variables --->
		<cfset var errorCollection = variables.instance.factory.getObject('errorCollection') />

		<!--- return the error collection --->
		<cfreturn errorCollection />
	</cffunction> <!--- end: validate() --->

	<!--- ------------------------------------------------------------ --->
	<!--- programmatic rule manipulation methods --->

	<!--- 
		function: 		addRule
	
		description:	Programmatically adds a validation rule to the rules collection.  If a rule already exists with the same name,
						that rule will be overwritten.
	--->
	<cffunction name="addRule" access="public" output="false" returntype="validat"
		hint="Programmatically adds a validation rule to the rules collection, overwritting any existing rules with the same name">

		<cfargument name="ruleName" type="string" required="true" hint="The name of the validation rule" />
		<cfargument name="validator" type="string" required="true" hint="The bean name of the validator object" />
		<cfargument name="ruleArgs" type="struct" required="false" hint="A collection of default arguments to be passed to the validator object along with the data value" />
		
		<!--- setup temporary variables --->
		<cfset ruleStr = structNew() />
		
		<!--- setup the rule based upon the received arguments --->
		<cfset ruleStr.name = arguments.ruleName/>
		<cfset ruleStr.validator = arguments.validator />
		<cfif NOT structIsEmpty( arguments.ruleArgs ) >
			<cfset ruleStr.args = arguments.ruleArgs />
		</cfif>

		<!--- insert the new validation rule definiton into the validation rules collection --->
		<cfset structInsert( variables.instance.validationRules, lcase( arguments.ruleName ), structCopy( ruleStr ), true ) />
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addRule() --->

	<!--- 
		function: 		addRuleXML
	
		description:	Programmatically adds a new validation rule, along with any related arguments to the rules collection based 
						upon an xml snippet.  If a rule already exists with the specified name, that rule will be overwritten.
	--->
	<cffunction name="addRuleXML" access="public" output="false" returntype="validat"
		hint="Programmatically adds a new validation rule, along with any related arguments to the rules collection based upon an xml snippet, overwritting any existing rules with the same name">

		<cfargument name="ruleXML" type="string" required="true" hint="The validation rule definition xml string" />
		
		<!--- setup temporary variables --->
		<cfset var oXML = xmlParse(arguments.ruleXML) />
		<cfset var argPtr = 0 />
		<cfset var argCollection = structNew() />
		
		<!--- check if the ruleXML is in fact a valid validation rule xml snippet --->
		<cfif NOT ( lcase(oXML.xmlRoot.xmlName) EQ 'validation-rule' AND structKeyExists( oXML.xmlRoot.xmlAttributes, "name") AND structKeyExists( oXML.xmlRoot.xmlAttributes, "validator") ) >
			<cfthrow type="validat.invalidRule" message="validat: The xml snippet passed to the addRuleXML() method does not represent a valid validation rule." />
		</cfif>
		
		<!--- check for any arguments to this validation rule --->
		<cfif arrayLen( oXML.xmlRoot.xmlChildren )>
			<!--- for every child node of the validation rule --->
			<cfloop from="1" to="#arrayLen( oXML.xmlRoot.xmlChildren )#" index="argPtr">
				<!--- if the child node is a valid argument --->
				<cfif NOT ( lcase( oXML.xmlRoot.xmlChildren[argPtr].xmlName ) EQ 'arg' AND structKeyExists( oXML.xmlRoot.xmlChildren[argPtr].xmlAttributes, "name") AND structKeyExists( oXML.xmlRoot.xmlChildren[argPtr].xmlAttributes, "default") ) >
					<cfthrow type="validat.invalidRule" message="validat: The xml snippet passed to the addRuleXML() method contains an invalid argument." detail="Invalid Argument: #toString(oXML.xmlRoot.xmlChildren[argPtr])#" />
				</cfif>
				<!--- insert the argument into the argument collection --->
				<cfset structInsert( argCollection, lcase( oXML.xmlRoot.xmlChildren[argPtr].xmlAttributes.name ), oXML.xmlRoot.xmlChildren[argPtr].xmlAttributes.default ) />
			</cfloop>
		</cfif>
		
		<!--- pass the validation rule parameters to the addRule function for addition to the validation rule collection --->
		<cfset addRule( oXML.xmlRoot.xmlAttributes.name, oXML.xmlRoot.xmlAttributes.validator, argCollection ) />
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addRuleXML() --->

	<!--- 
		function: 		getAllRules
	
		description:	Retrieves all validation rules currently in the rules collection.
	--->
	<cffunction name="getAllRules" access="public" output="false" returntype="struct"
		hint="Retrieves the all validation rules currently in the rules collection">
		
		<!--- return a copy of the rules collection --->
		<cfreturn structCopy(variables.instance.validationRules) />
	</cffunction> <!--- end: getAllRules() --->

	<!--- 
		function: 		getRule
	
		description:	Retrieves the validation rule definition for the validation rule with the specified name.
	--->
	<cffunction name="getRule" access="public" output="false" returntype="struct"
		hint="Retrieves the validation rule definition for the validation rule with the specified name">

		<cfargument name="ruleName" type="string" required="true" hint="The name of the validation rule to retrieve" />

		<!--- check if the specified validation rule exists --->
		<cfif NOT structKeyExists( variables.instance.validationRules, lcase( arguments.ruleName ) ) >
			<cfthrow type="validat.invalidRule" message="validat: The validation rule name specified ('#arguments.ruleName#') does not exist." />
		</cfif>
		
		<!--- return a copy of the validation rule definition --->
		<cfreturn structCopy(variables.instance.validationRules[arguments.ruleName]) />
	</cffunction> <!--- end: getRule() --->

	<!--- 
		function: 		remRule
	
		description:	Removes the validation rule definition for the validation rule with the specified name.
	--->
	<cffunction name="remRule" access="public" output="false" returntype="validat"
		hint="Removes the validation rule definition for the validation rule with the specified name">

		<cfargument name="ruleName" type="string" required="true" hint="The name of the validation rule to retrieve" />

		<!--- check if the specified validation rule exists --->
		<cfif NOT structKeyExists( variables.instance.validationRules, lcase( arguments.ruleName ) ) >
			<cfthrow type="validat.invalidRule" message="validat: The validation rule name specified ('#arguments.ruleName#') does not exist." />
		</cfif>
		
		<!--- remove the validation rule definition for the validation rule with the specified name --->
		<cfset structDelete( variables.instance.validationRules, lcase( arguments.ruleName ) ) />
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: remRule() --->

	<!--- ------------------------------------------------------------ --->
	<!--- programmatic data set manipulation methods --->

	<!--- 
		function: 		addDataSet
	
		description:	Programmatically adds a new data set definiton to the data set collection.  If the overwrite argument
						is true, any existing data sets with the specified name will be overwritten.  Otherwise, if a data set 
						already exists with the specified name, nothing will happen, preserving the existing data set definition.  
	--->
	<cffunction name="addDataSet" access="public" output="false" returntype="validat"
		hint="Programmatically adds a data set to the data set collection, overwritting any existing data sets with the same name">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set" />
		<cfargument name="transformer" type="string" required="false" default="" hint="The bean name of the transformer object" />
		<cfargument name="overwrite" type="boolean"  required="false" default="false" hint="Overwrite an existing data set?" />
		
		<!--- setup temporary variables --->
		<cfset dataSetStr = structNew() />
		
		<!--- setup the data set based upon the received arguments --->
		<cfset dataSetStr.name = arguments.dsName />
		<cfset dataSetStr.transformer = arguments.transformer />
		<cfset dataSetStr.dataElements = structNew() />

		<!--- if a data set does not exist with the given data set name OR overwrite is true --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) OR arguments.overwrite >
	
			<!--- insert the new data set definiton into the data set collection  --->
			<cfset structInsert( variables.instance.dataSets, lcase( arguments.dsName ), structCopy( dataSetStr ), true ) />
			
		</cfif> <!--- end: if a data set exists or overwrite --->
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addDataSet() --->

	<!--- 
		function: 		addDataSetXML
	
		description:	Programmatically adds a new data set definiton, along with any related data elements and assertions to the data set 
						collection based upon an xml snippet. If the overwrite argument is true, any existing data sets with the specified 
						name will be overwritten.  Otherwise, if a data set already exists with the specified name, nothing will happen, 
						preserving the existing data set definition.  
	--->
	<cffunction name="addDataSetXML" access="public" output="false" returntype="validat"
		hint="Programmatically adds a new data set definiton, along with any related data elements and assertions to the assections collection based upon an xml snippet, overwritting any existing data sets with the same name">

		<cfargument name="dsXML" type="string" required="true" hint="The data set definition xml string" />
		<cfargument name="overwrite" type="boolean"  required="false" default="false" hint="Overwrite an existing data set?" />
		
		<!--- setup temporary variables --->
		<cfset var oXML = xmlParse(arguments.dsXML) />
		
		<!--- check if the dsXML is in fact a valid data set xml snippet --->
		<cfif NOT ( lcase(oXML.xmlRoot.xmlName) EQ 'data-set' AND structKeyExists( oXML.xmlRoot.xmlAttributes, "name") AND structKeyExists( oXML.xmlRoot.xmlAttributes, "transformer") ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The xml snippet passed to the addDataSetXML() method does not represent a valid data set." />
		</cfif>
		
		<!--- pass the data set attributes to the addDataSet function for addition to the data set collection --->
		<cfset addDataSet( oXML.xmlRoot.xmlAttributes.name, oXML.xmlRoot.xmlAttributes.transformer ) />
		
		<!--- check for any child data elements to this data set --->
		<cfif arrayLen( oXML.xmlRoot.xmlChildren )>
			<!--- for every child node of the data set --->
			<cfloop from="1" to="#arrayLen( oXML.xmlRoot.xmlChildren )#" index="argPtr">
				<!--- pass the xml snippet to the addDataElementXML method --->
				<cfset addDataElementXML( oXML.xmlRoot.xmlAttributes.name, toString( oXML.xmlRoot.xmlChildren[argPtr] ), arguments.overwrite ) />
			</cfloop>
		</cfif>
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addDataSetXML() --->

	<!--- 
		function: 		getAllDataSets
	
		description:	Retrieves the all data set definitions currently in the assertions collection.
	--->
	<cffunction name="getAllDataSets" access="public" output="false" returntype="struct"
		hint="Retrieves the all data set definitions currently in the assertions collection">
		
		<!--- return a copy of the data sets collection --->
		<cfreturn structCopy(variables.instance.dataSets) />
	</cffunction> <!--- end: getAllDataSets() --->

	<!--- 
		function: 		getDataSet
	
		description:	Retrieves the data set definition for the data set with the specified name.
	--->
	<cffunction name="getDataSet" access="public" output="false" returntype="struct"
		hint="Retrieves the data set definition for the data set with the specified name">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to retrieve" />

		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>
		
		<!--- return a copy of the data set definition --->
		<cfreturn structCopy(variables.instance.dataSets[arguments.dsName]) />
	</cffunction> <!--- end: getDataSet() --->

	<!--- 
		function: 		remDataSet
	
		description:	Removes the data set definition for the data set with the specified name.
	--->
	<cffunction name="remDataSet" access="public" output="false" returntype="validat"
		hint="Removes the data set definition for the data set with the specified name">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to remove" />
		
		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>
		
		<!--- remove the data set definition for the data set with the specified name --->
		<cfset structDelete( variables.instance.dataSets, lcase( arguments.dsName ) ) />
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: remDataSet() --->

	<!--- ------------------------------------------------------------ --->
	<!--- programmatic data element manipulation methods --->

	<!--- 
		function: 		addDataElement
	
		description:	Programmatically adds a new data element definiton to the data set specified.  If the specified data
						set does not exist, an error will be thrown.  If the overwrite argument is true, any existing data 
						elements with the specified name will be overwritten.  Otherwise, if a data element already exists
						with the specified name, nothing will happen, preserving the existing data element definition.  
	--->
	<cffunction name="addDataElement" access="public" output="false" returntype="validat"
		hint="Programmatically adds a data element to the specified data set, overwritting any existing data elements with the same name">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to associate the data element with" />
		<cfargument name="deName" type="string" required="true" hint="The name of the data element" />
		<cfargument name="overwrite" type="boolean"  required="false" default="false" hint="Overwrite an existing data element?" />
		
		<!--- setup temporary variables --->
		<cfset dataElementStr = structNew() />
		
		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase(arguments.dsName) ) >
			<cfthrow type="validat.invalidDataElement" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>
		
		<!--- if a data element does not exist with the given data element name OR overwrite is true --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements, lcase( arguments.deName ) ) OR arguments.overwrite >
			
			<!--- setup the data element based upon the received arguments --->
			<cfset dataElementStr.name = arguments.deName />
			<cfset dataElementStr.assertionList = "" />
			<cfset dataElementStr.assertions = arrayNew(1) />
	
			<!--- insert the new data set definiton into the data set collection  --->
			<cfset structInsert( variables.instance.dataSets[arguments.dsName].dataElements, lcase( arguments.deName ), structCopy( dataElementStr ), true ) />
		
		</cfif> <!--- end: if data element does not exist or overwrite --->
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addDataElement() --->

	<!--- 
		function: 		addDataElementXML
	
		description:	Programmatically adds a new data element definiton, along with any related assertions to the data set 
						specified based upon an xml snippet.  If the specified data set does not exist, an error will be thrown.
						If the overwrite argument is true, any existing data elements with the specified name will be overwritten.
						Otherwise, if a data element already exists with the specified name, nothing will happen, preserving the
						existing data element definition.  
	--->
	<cffunction name="addDataElementXML" access="public" output="false" returntype="validat"
		hint="Programmatically adds a new data element definiton, along with any related assertions to the specified data set based upon an xml snippet, overwritting any existing data elements with the same name">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to associate the data element with" />
		<cfargument name="deXML" type="string" required="true" hint="The data element definition xml string" />
		<cfargument name="overwrite" type="boolean"  required="false" default="false" hint="Overwrite an existing data element?" />
		
		<!--- setup temporary variables --->
		<cfset var oXML = xmlParse(arguments.deXML) />
		
		<!--- check if the deXML is in fact a valid data element xml snippet --->
		<cfif NOT ( lcase(oXML.xmlRoot.xmlName) EQ 'data-element' AND structKeyExists( oXML.xmlRoot.xmlAttributes, "name") ) >
			<cfthrow type="validat.invalidDataElement" message="validat: The xml snippet passed to the addDataElementXML() method does not represent a valid data element." />
		</cfif>
		
		<!--- pass the data element attributes to the addDataElement function for addition to the data set collection --->
		<cfset addDataElement( arguments.dsName, oXML.xmlRoot.xmlAttributes.name ) />
		
		<!--- check for any child assertions to this data element --->
		<cfif arrayLen( oXML.xmlRoot.xmlChildren )>
			<!--- for every child node of the data set --->
			<cfloop from="1" to="#arrayLen( oXML.xmlRoot.xmlChildren )#" index="argPtr">
				<!--- pass the xml snippet to the addAssertXML method --->
				<cfset addAssertXML( arguments.dsName, oXML.xmlRoot.xmlAttributes.name, toString( oXML.xmlRoot.xmlChildren[argPtr] ), arguments.overwrite ) />
			</cfloop>
		</cfif>
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addDataElementXML() --->

	<!--- 
		function: 		getAllDataElements
	
		description:	Retrieves all data element definitions associated with the data set with the specified name.  If the specified data
						set does not exist, an error will be thrown.
	--->
	<cffunction name="getAllDataElements" access="public" output="false" returntype="struct"
		hint="Retrieves all data element definitions associated with the data set with the specified name">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to retrieve the data element definitions for" />

		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>
		
		<!--- return a copy of the data element collection for the specified data set --->
		<cfreturn structCopy(variables.instance.dataSets[arguments.dsName].dataElements) />
	</cffunction> <!--- end: getAllDataElements() --->

	<!--- 
		function: 		getDataElement
	
		description:	Retrieves the data element definition for the data set, data element combination specified.  If the specified data set and
						data element combination does not exist, an error will be thrown.
	--->
	<cffunction name="getDataElement" access="public" output="false" returntype="struct"
		hint="Retrieves the data element definition for the data set, data element combination specified">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to retrieve the data element definitions for" />
		<cfargument name="deName" type="string" required="true" hint="The name of the data set to retrieve" />

		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>

		<!--- check if the specified data element exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements, lcase( arguments.deName ) ) >
			<cfthrow type="validat.invalidDataElement" message="validat: The data element name specified ('#arguments.deName#') does not exist." />
		</cfif>
		
		<!--- return a copy of the data element definition for the specified data element, data set combination --->
		<cfreturn structCopy(variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName]) />
	</cffunction> <!--- end: getDataElement() --->

	<!--- 
		function: 		remDataElement
	
		description:	Removes the data element definition for the data set, data element combination specified.  If the specified data set and
						data element combination does not exist, an error will be thrown.
	--->
	<cffunction name="remDataElement" access="public" output="false" returntype="validat"
		hint="Removes the data element definition for the data set, data element combination specified">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to retrieve the data element definitions for" />
		<cfargument name="deName" type="string" required="true" hint="The name of the data set to retrieve" />

		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>

		<!--- check if the specified data element exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements, lcase( arguments.deName ) ) >
			<cfthrow type="validat.invalidDataElement" message="validat: The data element name specified ('#arguments.deName#') does not exist." />
		</cfif>
		
		<!--- remove the data set definition for the data set with the specified name --->
		<cfset structDelete( variables.instance.dataSets[arguments.dsName].dataElements, lcase( arguments.deName ) ) />
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: remDataElement() --->

	<!--- ------------------------------------------------------------ --->
	<!--- programmatic assertion manipulation methods --->

	<!--- 
		function: 		addAssert
	
		description:	Programmatically adds a new data element assertion to the data set, data element combination specified.  If an 
						assertion already exists with the specified rule, that assertion will be overwritten.  If the specified data set
						and data element combination does not exist, an error will be thrown.
	--->
	<cffunction name="addAssert" access="public" output="false" returntype="validat"
		hint="Programmatically adds a data element assertion to the specified data set, data element combination, overwritting any existing data element assertions with the same rule">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to associate the assertion with" />
		<cfargument name="deName" type="string" required="true" hint="The name of the data element to associate the assertion with" />
		<cfargument name="ruleName" type="string" required="true" hint="The name of the rule to which this assertion corresponds" />
		<cfargument name="message" type="string" required="true" hint="The error message to return if the assertion fails" />
		<cfargument name="continueOnFail" type="boolean" required="false" default="false" hint="Should validation continue if this assertion fails" />
		<cfargument name="depends" type="string" required="false" default="" hint="The data element name for which this assertion depends upon" />
		<cfargument name="value" type="string" required="false" default="" hint="The value for the data element dependency for which this assertion depends upon" />
		<cfargument name="args" type="struct" required="false" hint="A collection of arguments to be passed to the validator object along with the data value" />
		
		<!--- setup temporary variables --->
		<cfset var assertStr = structNew() />
		<cfset var assertPtr = 0 />
		
		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase(arguments.dsName) ) >
			<cfthrow type="validat.invalidAssertion" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>
		
		<!--- check if the specified data element exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements, lcase(arguments.deName) ) >
			<cfthrow type="validat.invalidAssertion" message="validat: The data element name specified ('#arguments.deName#') does not exist." />
		</cfif>
		
		<!--- setup the assertion based upon the received arguments --->
		<cfset assertStr.rule = arguments.ruleName />
		<cfset assertStr.message = arguments.message />
		<cfset assertStr.depends = arguments.depends />
		<cfset assertStr.value = arguments.value />
		<cfset assertStr.continueOnFail = arguments.continueOnFail />
		<cfif NOT structIsEmpty( arguments.args ) >
			<cfset assertStr.args = arguments.args />
		</cfif>

		<!--- attempt to locate existing assertion with this rule name --->
		<cfset assertPtr = listFindNoCase( variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertionList, lcase( arguments.ruleName ) ) />

		<!--- if an existing assertion was found, overwrite it --->
		<cfif assertPtr GT 0 >
			<cfset variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertions[assertPtr] = structCopy( assertStr ) />
		
		<!--- existing assertion was not found, add assertion to the end of the array / list --->
		<cfelse>
			<cfset arrayAppend( variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertions, structCopy( assertStr ) ) />
			
			<cfif listLen( variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertionList ) EQ 0 >
				<cfset variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertionList = lcase( arguments.ruleName ) />
			<cfelse>
				<cfset variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertionList = listAppend( variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertionList, lcase( arguments.ruleName ) ) />
			</cfif>
		
		</cfif> <!--- end: if existing assertion was found --->
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addAssert() --->

	<!--- 
		function: 		addAssertXML
	
		description:	Programmatically adds a new data element assertion to the data set, data element combination specified, based 
						upon an xml snippet. If an assertion already exists with the specified rule, that assertion will be overwritten.
						If the specified data set and data element combination does not exist, an error will be thrown.
	--->
	<cffunction name="addAssertXML" access="public" output="false" returntype="validat"
		hint="Programmatically adds a new data element definiton, along with any related assertions to the specified data set based upon an xml snippet, overwritting any existing data elements with the same name">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to associate the assertion with" />
		<cfargument name="deName" type="string" required="true" hint="The name of the data element to associate the assertion with" />
		<cfargument name="assertXML" type="string" required="true" hint="The data element assertion xml string" />
		
		<!--- setup temporary variables --->
		<cfset var oXML = xmlParse(arguments.assertXML) />
		<cfset var assertParameters = structNew() />
		
		<!--- check if the assertXML is in fact a valid data element assertion xml snippet --->
		<cfif NOT ( lcase(oXML.xmlRoot.xmlName) EQ 'assert' AND structKeyExists( oXML.xmlRoot.xmlAttributes, "rule") AND structKeyExists( oXML.xmlRoot.xmlAttributes, "message") ) >
			<cfthrow type="validat.invalidAssert" message="validat: The xml snippet passed to the addAssertXML() method does not represent a valid data element assertion." />
		</cfif>
		
		<!--- build a collection of assertion parameters based upon the xml snippet --->
		<cfset assertParameters.dsName = arguments.dsName />
		<cfset assertParameters.deName = arguments.deName />
		<cfset assertParameters.ruleName = oXML.xmlRoot.xmlAttributes.rule />
		<cfset assertParameters.message = oXML.xmlRoot.xmlAttributes.message />
		<cfif structKeyExists( oXML.xmlRoot.xmlAttributes, 'continueOnFail') >
			<cfset assertParameters.continueOnFail = oXML.xmlRoot.xmlAttributes.continueOnFail />
		</cfif>
		<cfif structKeyExists( oXML.xmlRoot.xmlAttributes, 'depends') >
			<cfset assertParameters.depends = oXML.xmlRoot.xmlAttributes.depends />
		</cfif>
		<cfif structKeyExists( oXML.xmlRoot.xmlAttributes, 'value') >
			<cfset assertParameters.value = oXML.xmlRoot.xmlAttributes.value />
		</cfif>
		<cfset assertParameters.args = structNew() />
		
		<!--- check for any arguments to this assertion --->
		<cfif arrayLen( oXML.xmlRoot.xmlChildren )>
			<!--- for every child node of the assertion --->
			<cfloop from="1" to="#arrayLen( oXML.xmlRoot.xmlChildren )#" index="argPtr">
				<!--- if the child node is a valid argument --->
				<cfif NOT ( lcase( oXML.xmlRoot.xmlChildren[argPtr].xmlName ) EQ 'arg' AND structKeyExists( oXML.xmlRoot.xmlChildren[argPtr].xmlAttributes, "name") AND structKeyExists( oXML.xmlRoot.xmlChildren[argPtr].xmlAttributes, "value") ) >
					<cfthrow type="validat.invalidAssert" message="validat: The xml snippet passed to the addAssertXML() method contains an invalid argument." detail="Invalid Argument: #toString(oXML.xmlRoot.xmlChildren[argPtr])#" />
				</cfif>
				<!--- insert the argument into the argument collection --->
				<cfset structInsert( assertParameters.args, lcase( oXML.xmlRoot.xmlChildren[argPtr].xmlAttributes.name ), oXML.xmlRoot.xmlChildren[argPtr].xmlAttributes.value ) />
			</cfloop>
		</cfif>
		
		<!--- pass the assertion parameters to the addAssert function for addition to the data set collection --->
		<cfset addAssert( argumentCollection = assertParameters ) />
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addAssertXML() --->

	<!--- 
		function: 		getAllAsserts
	
		description:	Retrieves all data element assertions associated with the data set, data element combination specified.  If the 
						specified data set and data element combination does not exist, an error will be thrown.
	--->
	<cffunction name="getAllAsserts" access="public" output="false" returntype="struct"
		hint="Retrieves the all data element assertions associated with the data set, data element combination specified">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set from which to retrieve the assertion definitions" />
		<cfargument name="deName" type="string" required="true" hint="The name of the data element from which to retrieve the assertion definitions" />

		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>

		<!--- check if the specified data element exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements, lcase( arguments.deName ) ) >
			<cfthrow type="validat.invalidDataElement" message="validat: The data element name specified ('#arguments.deName#') does not exist." />
		</cfif>
		
		<!--- return a copy of the data element assertion collection for the specified data element, data set combination --->
		<cfreturn structCopy(variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertions) />
	</cffunction> <!--- end: getAllAsserts() --->

	<!--- 
		function: 		getAssert
	
		description:	Retrieves the data element assertion associated with the data set, data element, and rule combination specified.  If 
						the specified data set, data element, and rule name combination does not exist, an error will be thrown.
	--->
	<cffunction name="getAssert" access="public" output="false" returntype="struct"
		hint="Retrieves the data element assertion for the data set, data element, and rule combination specified">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to retrieve the assertions for" />
		<cfargument name="deName" type="string" required="true" hint="The name of the data element to retrieve the assertion for" />
		<cfargument name="rule" type="string" required="true" hint="The rule name of the assertion to retrieve" />

		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>

		<!--- check if the specified data element exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements, lcase( arguments.deName ) ) >
			<cfthrow type="validat.invalidDataElement" message="validat: The data element name specified ('#arguments.deName#') does not exist." />
		</cfif>

		<!--- check if the specified rule / assertion exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertions, lcase( arguments.rule ) ) >
			<cfthrow type="validat.invalidAssertion" message="validat: The assertion with the rule name specified ('#arguments.rule#') does not exist." />
		</cfif>
		
		<!--- return a copy of the assertion definition for the specified assertion, data element, data set combination --->
		<cfreturn structCopy(variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertions[arguments.rule]) />
	</cffunction> <!--- end: getAssert() --->

	<!--- 
		function: 		remAssert
	
		description:	Removes the data element assertion associated with the data set, data element, and rule combination specified.  If 
						the specified data set, data element, and rule name combination does not exist, an error will be thrown.
	--->
	<cffunction name="remAssert" access="public" output="false" returntype="validat"
		hint="Removes the data element assertion associated with the data set, data element, and rule combination specified">

		<cfargument name="dsName" type="string" required="true" hint="The name of the data set to retrieve the assertions for" />
		<cfargument name="deName" type="string" required="true" hint="The name of the data element to retrieve the assertion for" />
		<cfargument name="rule" type="string" required="true" hint="The rule name of the assertion to retrieve" />

		<!--- check if the specified data set exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets, lcase( arguments.dsName ) ) >
			<cfthrow type="validat.invalidDataSet" message="validat: The data set name specified ('#arguments.dsName#') does not exist." />
		</cfif>

		<!--- check if the specified data element exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements, lcase( arguments.deName ) ) >
			<cfthrow type="validat.invalidDataElement" message="validat: The data element name specified ('#arguments.deName#') does not exist." />
		</cfif>

		<!--- check if the specified rule / assertion exists --->
		<cfif NOT structKeyExists( variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertions, lcase( arguments.rule ) ) >
			<cfthrow type="validat.invalidAssertion" message="validat: The assertion with the rule name specified ('#arguments.rule#') does not exist." />
		</cfif>
		
		<!--- remove the assertion definition for the specified assertion, data element, data set combination --->
		<cfset structDelete(variables.instance.dataSets[arguments.dsName].dataElements[arguments.deName].assertions, lcase( arguments.rule ) ) />

		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: remAssert() --->

	<!--- ------------------------------------------------------------ --->
	<!--- private methods --->

	<!--- 
		function: 		parseConfigXML
	
		description:	Accepts the path to a configuration xml file and parses the contents of that configuration file.
						If the configuration xml file contains an include tag, the rules and assertions in the configuration
						file will be processed, then the function will be recursivly called with the include path provided.
						Any rules or assertions in an included file may overwrite any rules or assertions that have already
						been loaded.
	--->
	<cffunction name="parseConfigXML" access="private" output="false" returntype="void"
		hint="Parses a configuration xml file">
		
		<cfargument name="configXML" displayname="configXML" type="string" required="true"
			hint="I am the path to the configuration xml file to parse" /> 

		<!--- setup containers --->
		<cfset var xContents = "" />
		<cfset var xConfig = "" />
		
		<cfset var rulePtr = 0 />
		<cfset var dataPtr = 0 />
		<cfset var includePtr = 0 />
		
		<!--- read the configuration file content --->
		<cfif fileExists(expandPAth(arguments.configXML)) >
			<cffile action="read" file="#expandPAth(arguments.configXML)#" variable="xContents" />
		<cfelse>
			<cfthrow message="Validator Error:  Configuration file '#expandPAth(arguments.configXML)#' cannot be found." />
		</cfif>
			
		<!--- parse the configuration file to XML and get root element --->
		<cfset xConfig = xmlParse(xContents) />

		<!--- load the validation rules (optional) --->
		<cfif structKeyExists( xConfig.xmlRoot, "validation-rules") >
			<!--- for each validation rule specified ... --->
			<cfloop from="1" to="#arrayLen( xConfig.xmlRoot["validation-rules"].xmlChildren )#" index="rulePtr">
				<!--- add the validation rule to the rules collection --->
				<cfset addRuleXML( toString(xConfig.xmlRoot["validation-rules"].xmlChildren[rulePtr]) ) />
			</cfloop>
		</cfif> <!--- end: load the validation rules --->

		<!--- load the validation assertions (optional) --->
		<cfif structKeyExists( xConfig.xmlRoot, "data-sets") >
			<!--- for each validation assertion specified ... --->
			<cfloop from="1" to="#arrayLen( xConfig.xmlRoot["data-sets"].xmlChildren )#" index="dataPtr">
				<!--- add the validation assertion to the assertion collection --->
				<cfset addDataSetXML( toString(xConfig.xmlRoot["data-sets"].xmlChildren[dataPtr]) ) />
			</cfloop>
		</cfif> <!--- end: load the validation assertions --->

		<!--- parse any included configuration files --->
		<cfif structKeyExists( xConfig.xmlRoot, "include") >
			<!--- for each include specified ... --->
			<cfloop from="1" to="#arrayLen( xConfig.xmlRoot.include )#" index="includePtr">
				<!--- recursively parse the included configuration file --->
				<cfset parseConfigXML( xConfig.xmlRoot.include[includePtr].xmlAttributes.template ) />
			</cfloop>
		</cfif> <!--- end: load the validation assertions --->
		
		<cfreturn />
	</cffunction> <!--- end: parseConfigXML() --->

</cfcomponent>