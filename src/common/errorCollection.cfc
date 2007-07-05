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
	displayname="errorCollection"
	output="false"
	hint="Manages a collection of data validation errors.">
	
	<!--- ------------------------------------------------------------ --->
	<!--- constructor --->

	<cffunction name="init" access="public" output="false" returntype="ErrorCollection" 
		hint="The default constructor for the error collection object, returning the initialized error collection object instance">

		<!--- create container for protected instance data --->
		<cfset variables.instance = structNew() />				

		<!--- setup an empty array for storing the errors --->
		<cfset variables.instance.errors = arrayNew(1) />

		<cfreturn this />		
	</cffunction> <!--- end: init() --->

	<!--- ------------------------------------------------------------ --->
	<!--- public functions --->

	<!--- 
		function: addError
	
		description:	Adds a single error to the error collection.
	--->
	<cffunction name="addError" access="public" output="false" returntype="errorCollection"
		hint="Adds a single error to the error collection.">
		
		<cfargument name="dataElement" type="string" required="true" hint="the name of the data element for which the error occurred" />
		<cfargument name="dataValue" type="string" required="true" hint="the value of the data element for which the error occurred" />
		<cfargument name="message" type="string" required="true" hint="the error message for the error to be added to the error collection" />

		<!--- create a new error structure with the provided data --->
		<cfset var errorStruct = structNew() />
		<cfset errorStruct.dataElement = arguments.dataElement />
		<cfset errorStruct.dataValue = arguments.dataValue />
		<cfset errorStruct.message = arguments.message />
		
		<!--- add the error structure to the array --->
		<cfset arrayAppend(variables.instance.errors, errorStruct) />		
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: addError() --->

	<!--- 
		function: clearErrors
	
		description:	Removes any errors stored in the error collection.
	--->
	<cffunction name="clearErrors" access="public" output="false" returntype="errorCollection"
		hint="Removes any errors stored in the error collection.">
		
		<!--- reset the errors array --->
		<cfset variables.instance.errors = arrayNew(1) />
		
		<!--- return a pointer to this object to allow for chaining --->
		<cfreturn this />
	</cffunction> <!--- end: clearErrors() --->

	<!--- 
		function: getErrors
	
		description:	Retrieves an array of error structures for all errors in the error collection.
	--->
	<cffunction name="getErrors" access="public" output="false" returntype="array"
		hint="Retrieves an array of error structures for all errors in the error collection.">
		
		<cfreturn duplicate(variables.instance.errors) />
	</cffunction> <!--- end: getErrors() --->

	<!--- 
		function: getErrorsByDataElement
	
		description:	Retrieves an array of error structures for errors with the specified data elmeent name in the error collection.
	--->
	<cffunction name="getErrorsByDataElement" access="public" output="false" returntype="array"
		hint="Retrieves an array of error structures for errors with the specified data elmeent name in the error collection.">
		
		<cfargument name="dataElement" type="string" required="true" hint="the name of the data element for which errors are to be retrieved" />
		
		<!--- setup a temporary array pointer --->
		<cfset var aryPtr = 0 />
		
		<!--- create a temporary array --->
		<Cfset var tempArray = arrayNew(1) />
		
		<!--- search the errors array for errors with the specified data element name --->
		<cfloop from="1" to="#arrayLen(variables.instance.errors)#" index="aryPtr">
			<cfif variables.instance.errors[aryPtr].dataElement EQ arguments.dataElement >
				<cfset arrayAppend(tempArray, structCopy(variables.instance.errors[aryPtr])) />
			</cfif>
		</cfloop>
		
		<cfreturn duplicate(tempArray) />
	</cffunction> <!--- end: getErrorsByDataElement() --->

</cfcomponent>