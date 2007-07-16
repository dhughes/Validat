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
	displayname="ValidatTest"
	output="false"
	extends="org.cfcunit.framework.TestCase"
	hint="Unit test for the Validat object.">

	<!--- ------------------------------------------------------------ --->
	<!--- unit test setup --->

	<cffunction name="setup" access="private" returntype="void"
		hint="I will setup the unit test before each test function is run" >

		<cfset variables.factory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
		<cfset variables.factory.loadBeansFromXmlFile(expandPath("/test/support/coldspring.xml"), true) />
		<cfset variables.validat = createObject("component", "test.support.validatWrap") /> <!--- instantiating the wrapper to get access to private data --->

		<cfreturn />
	</cffunction> <!--- end: setup() --->

	<!--- ------------------------------------------------------------ --->
	<!--- test methods --->

	<cffunction name="testInitNoXML" access="public" returntype="void"
		hint="I will test the init function, without passing in the path to a configuration xml file" >
	
		<!--- setup temporary variables --->
		<cfset base = structNew() />
		<cfset result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.dataSets = structNew() />
		<cfset base.factory = variables.factory />
		<Cfset base.validationRules = structNew() />

		<!--- call the init method, only passing the factory reference --->
		<cfset variables.validat.init(variables.factory) />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct(base, result) />
	</cffunction> <!--- end: testInitNoXML() --->

	<cffunction name="testInitWithSimpleXML" access="public" returntype="void"
		hint="I will test the init function, passing in the path to a simple configuration xml file" >
	
		<!--- setup temporary variables --->
		<cfset base = structNew() />
		<cfset result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.factory = variables.factory />
		<cfinclude template="testData/validat-simple.cfm" />

		<!--- call the init method, only passing the factory reference --->
		<cfset variables.validat.init(variables.factory, '/test/testData/validat-simple.xml') />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct(base, result) />
	</cffunction> <!--- end: testInitWithSimpleXML() --->

	<cffunction name="testInitWithCompleteXML" access="public" returntype="void"
		hint="I will test the init function, passing in the path to a complete configuration xml file" >
	
		<!--- setup temporary variables --->
		<cfset base = structNew() />
		<cfset result = structNew() />

		<!--- setup the base / expeted test result to compare against --->
		<cfset base.factory = variables.factory />
		<cfinclude template="testData/validat-complete.cfm" />

		<!--- call the init method, only passing the factory reference --->
		<cfset variables.validat.init(variables.factory, '/test/testData/validat-complete.xml') />
		
		<!--- get the instance structure to verify initialization --->
		<cfset result = variables.validat.getInstance() />
		
		<!--- run the assertion --->
		<cfset assertEqualsStruct(base, result) />
	</cffunction> <!--- end: testInitWithCompleteXML() --->

</cfcomponent>