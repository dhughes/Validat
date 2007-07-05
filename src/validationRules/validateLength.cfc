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
	displayname="validateLength"
	output="false"
	hint="Data element string length validation rule."
	extends="validator">
	
	<!--- ------------------------------------------------------------ --->
	<!--- constructor --->

	<cffunction name="init" access="public" returntype="validateLength"
		hint="The default constructor for the validator rule, returning the initialized validator rule instance">

		<!--- call the base constructor --->
		<cfset super.init() />
			
		<!--- return the initialized validatoin rule --->
		<cfreturn this />	
	</cffunction> <!--- end: init() --->
	
	<!--- ------------------------------------------------------------ --->
	<!--- public methods --->

	<!--- 
		function: validate
	
		description:	Check to see if the length of the data value is between the min and max values.
	--->
	<cffunction name="validate" access="public" output="false" returntype="boolean"
		hint="Check to see if the length of the data value is between the min and max values.">

		<cfargument name="dataValue" type="string" required="true" hint="The data value to be validated" />
		<cfargument name="max" type="numeric" required="true" hint="The maximum length allowed to be considered valid" />
		<cfargument name="min" type="numeric" required="true" hint="The minimum length allowed to be considered valid" />
		
		<!--- check to see if the length of the data value is between the min and max values. --->
		<cfreturn ( len(trim(arguments.dataValue)) GTE arguments.min ) AND ( len(trim(arguments.dataValue)) LTE arguments.max ) />
	</cffunction> <!--- end: validate() --->

	<!--- 
		function: generateClientScript
	
		description:	Returns client side validation script for the given data element based upon the validate parameter.  This method
						can be overridden to provide client side validation script in other forms.
	--->
	<cffunction name="generateClientScript" access="public" output="false" returntype="string"
		hint="Returns client side validation script for the given data element based upon the validate parameter.">

		<cfargument name="deName" type="string" required="true" hint="The name of the data element for which to generate validation script" />
		<cfargument name="validate" type="string" required="true" hint="Indicates what type of validation script to generate [none, onBlur, onSubmit]" />

		<!--- setup a container for the generated script --->
		<cfset var csScript = "" />
		
		<!--- if the validate parameter is not none --->
		<cfif lcase(arguments.validate) NEQ 'none'>
		
		</cfif>
		
		<!--- return the generated client script --->
		<cfreturn csScript />
	</cffunction> <!--- end: generateClientScript() --->

	<!--- ------------------------------------------------------------ --->
	<!--- private methods --->


</cfcomponent>