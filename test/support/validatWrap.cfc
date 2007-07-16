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
	displayname="validat wrapper"
	output="false"
	extends="validat.validat"
	hint="Provides wrapper around the validat object, exposing private data and methods for testing purposes.">

	<!--- 
		function: 		getInstance

		description:	Returns the private instance structure for validation.
	--->
	<cffunction name="getInstance" access="public" output="false" returntype="struct"
		hint="Returns the private instance structure for validation.">

		<!--- return the private instance structure --->
		<cfreturn variables.instance />
	</cffunction> <!--- end: getInstance() --->

	<!--- 
		function: 		addDEAssert

		description:	Overrides the private access of the addDEAssert method for validation.
	--->
	<cffunction name="addDEAssert" access="public" output="false" returntype="void"
		hint="Overrides the private access of the addDEAssert method for validation.">

		<cfargument name="dataSetName" type="string" required="true" hint="The name of the data set to associate the assertion with" />
		<cfargument name="dataElementName" type="string" required="true" hint="The name of the data element to associate the assertion with" />
		<cfargument name="ruleName" type="string" required="true" hint="The name of the rule to which this assertion corresponds" />
		<cfargument name="continueOnFail" type="boolean" required="false" default="false" hint="Should validation continue if this assertion fails" />
		<cfargument name="args" type="struct" required="false" hint="A collection of arguments to be passed to the validator object along with the data value" />
		<cfargument name="messages" type="struct" required="true" hint="A collection of error messages to be returned if the assertion fails" />
	
		<cfreturn super.addDEAssert( argumentCollection = arguments ) />
	</cffunction> <!--- end: addDEAAssert() --->

	<!--- 
		function: 		addDSAssert

		description:	Overrides the private access of the addDSAssert method for validation.
	--->
	<cffunction name="addDSAssert" access="public" output="false" returntype="void"
		hint="Overrides the private access of the addDSAssert method for validation.">

		<cfargument name="dataSetName" type="string" required="true" hint="The name of the data set to associate the assertion with" />
		<cfargument name="ruleName" type="string" required="true" hint="The name of the rule to which this assertion corresponds" />
		<cfargument name="continueOnFail" type="boolean" required="false" default="false" hint="Should validation continue if this assertion fails" />
		<cfargument name="args" type="struct" required="false" hint="A collection of arguments to be passed to the validator object along with the data value" />
		<cfargument name="messages" type="struct" required="true" hint="A collection of error messages to be returned if the assertion fails" />
	
		<cfreturn super.addDSAssert( argumentCollection = arguments ) />
	</cffunction> <!--- end: addDSAssert() --->

	<!--- 
		function: 		parseConfigXML

		description:	Overrides the private access of the parseConfigXML method for validation.
	--->
	<cffunction name="parseConfigXML" access="public" output="false" returntype="void"
		hint="Overrides the private access of the parseConfigXML method for validation.">
	
		<cfargument name="configXML" displayname="configXML" type="string" required="true"
			hint="I am the path to the configuration xml file to parse" /> 
	
		<cfreturn super.parseConfigXML( argumentCollection = arguments ) />
	</cffunction> <!--- end: parseConfigXML() --->

</cfcomponent>