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
	displayname="validateLengthGT"
	output="false"
	hint="String length validation rule"
	extends="validator">
	
	<!--- ------------------------------------------------------------ --->
	<!--- constructor --->

	<cffunction name="init" access="public" returntype="validateLengthGT"
		hint="The default constructor for the validator rule, returning the initialized validator rule instance">

		<!--- call the base constructor --->
		<cfset super.init() />
			
		<!--- return the initialized validatoin rule --->
		<cfreturn this />	
	</cffunction> <!--- end: init() --->
	
	<!--- ------------------------------------------------------------ --->
	<!--- public methods --->

	<!--- 
		function: 		validate
	
		description:	Check to see if the length of the data value is greater than the min argument.
		
		arguments:		min ( the minimum value to check if the data value is greater than )
	--->
	<cffunction name="validate" access="public" output="false" returntype="string"
		hint="Check to see if the length of the data value is greater than the min argument.">

		<cfargument name="data" type="any" required="true" hint="The data to be validated" />
		<cfargument name="args" type="struct" required="false" default="#structNew()#" hint="The addtional arguments necessary to validate the data" />
		
		<!--- check to see if the data value represents a simple string value --->
		<cfif NOT isSimpleValue( arguments.data ) >
			<cfthrow type="validat.invalidData" message="validat: The validation rule 'validateLengthGT' only accepts simple data types." />
		</cfif>
		
		<!--- check to see if min was provided in the arguments collection --->
		<cfif NOT structKeyExists( arguments.args, 'min' ) >
			<cfthrow type="validat.missingArgs" message="validat: The validation rule 'validateLengthGT' requires an argument named 'min' that specifies the minimum value that will be accepted as valid." />
		</cfif>

		<!--- check to see if the length of the data value is greater than the min values. --->
		<cfif len( trim( arguments.data ) ) GTE arguments.args.min >
			<cfreturn true />
		</cfif>

		<cfreturn "invalid" />
	</cffunction> <!--- end: validate() --->

</cfcomponent>