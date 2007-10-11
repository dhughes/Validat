<cfsilent>
<!--- initialize the ColdSpring bean factory --->
<cfset csFactory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
<cfset csFactory.loadBeansFromXmlFile(expandPath("../_common/coldspring.xml"), true) />

<!--- get an instance of the Validat validation engine --->
<cfset formValidator = csFactory.getBean('validat') />

<!--- validate the form and collect any errors --->
<cfset errorCollection = formValidator.validate('user', form).getErrors() />

<!--- re-display the form --->
</cfsilent>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Simple User Form Validation Test</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link href="../_common/css/examples.css" type="text/css" rel="stylesheet" />
</head>

<body>
	<h1>Simple Form Validation #1</h1>
	<p>This is a simple example form demonstrating how to setup the Validat form validation for a form.</p>
	
	<cfif errorCollection._errorCount GT 0 >
		<p class="error">Errors were found in the form submission.</p>
	<cfelse>
		<p>No errors were found in the form submission.</p>
	</cfif>
	
	<form action="submit.cfm" method="post" name="simpleForm1">
	
		<fieldset>
		
			<cfif structKeyExists( errorCollection, "firstName" ) >
				<cfset fieldErrors = "" />
				<cfloop from="1" to="#arrayLen( errorCollection.firstName.errors )#" index="errorPtr">
					<cfset fieldErrors = listAppend( fieldErrors, errorCollection.firstName.errors[errorPtr].message, "<br/>" ) />
				</cfloop>
			<cfelse>
				<cfset fieldErrors = "" />
			</cfif>
		
			<div class="formField">
				<label for="firstName">First Name:</label>
				<input type="text" name="firstName" id="firstName" value="<cfoutput>#form.firstName#</cfoutput>" class="inputText" />
				<div class="fieldMsg">required, less than 100 characters</div>
				<cfif len(fieldErrors) >
					<div class="fieldValdationMsg"><cfoutput>#fieldErrors#</cfoutput></div>
				</cfif>				
			</div>
		
			<cfif structKeyExists( errorCollection, "middleName" ) >
				<cfset fieldErrors = "" />
				<cfloop from="1" to="#arrayLen( errorCollection.middleName.errors )#" index="errorPtr">
					<cfset fieldErrors = listAppend( fieldErrors, errorCollection.middleName.errors[errorPtr].message, '<br/>' ) />
				</cfloop>
			<cfelse>
				<cfset fieldErrors = "" />
			</cfif>
		
			<div class="formField">
				<label for="middleName">Middle Name:</label>
				<input type="text" name="middleName" id="middleName" value="<cfoutput>#form.firstName#</cfoutput>" class="inputText" />
				<div class="fieldMsg">optional, less than 100 characters</div>
				<cfif len(fieldErrors) >
					<div class="fieldValdationMsg"><cfoutput>#fieldErrors#</cfoutput></div>
				</cfif>				
			</div>
		
			<cfif structKeyExists( errorCollection, "lastName" ) >
				<cfset fieldErrors = "" />
				<cfloop from="1" to="#arrayLen( errorCollection.lastName.errors )#" index="errorPtr">
					<cfset fieldErrors = listAppend( fieldErrors, errorCollection.lastName.errors[errorPtr].message, '<br/>' ) />
				</cfloop>
			<cfelse>
				<cfset fieldErrors = "" />
			</cfif>
		
			<div class="formField">
				<label for="lastName">Last Name:</label>
				<input type="text" name="lastName" id="lastName" value="<cfoutput>#form.lastName#</cfoutput>" class="inputText" />
				<div class="fieldMsg">required, less than 100 characters</div>
				<cfif len(fieldErrors) >
					<div class="fieldValdationMsg"><cfoutput>#fieldErrors#</cfoutput></div>
				</cfif>				
			</div>
		
			<div class="formField formButtons">
				<input type="submit" name="action" value="Submit" class="inputButton" />
				<input type="reset" value="Reset" class="inputButton" />
			</div>
		</fieldset>	
	</form>
</body>
</html>
