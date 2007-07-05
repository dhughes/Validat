<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Validator Form Test</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

<h1>Test Form</h1>

<form name="userTest" action="form.cfm" method="post" enctype="application/x-www-form-urlencoded">

	<table border="0">
		<tr>
			<th align="right">Prefix:</th>
			<td><input type="text" name="prefix" value="" size="25" /></td>
		</tr>
		<tr>
			<th align="right">First Name:</th>
			<td><input type="text" name="firstName" value="" size="25" /> *</td>
		</tr>
		<tr>
			<th align="right">Middle Name:</th>
			<td><input type="text" name="middleName" value="" size="25" /></td>
		</tr>
		<tr>
			<th align="right">Last Name:</th>
			<td><input type="text" name="lastName" value="" size="25" /> *</td>
		</tr>
		<tr>
			<th align="right">Suffix:</th>
			<td><input type="text" name="suffix" value="" size="25" /></td>
		</tr>
		<tr>
			<th align="right">Gender:</th>
			<td>
				<select name="gender" size="1">
					<option value=""></option>
					<option value="female">Female</option>
					<option value="male">Male</option>
				</select>
			</td>
		</tr>
		<tr>
			<th align="right">Marital Status:</th>
			<td>
				<select name="status" size="1">
					<option value=""></option>
					<option value="single">Single</option>
					<option value="married">Married</option>
					<option value="divorced">Divorced</option>
					<option value="seperated">Seperated</option>
					<option value="Widowed">Widowed</option>
				</select>
			</td>
		</tr>
		<tr>
			<th align="right">Date of Birth:</th>
			<td><input type="text" name="birthDate" value="" size="25" /> *</td>
		</tr>
		<tr>
			<th align="right">Social Security Number:</th>
			<td><input type="text" name="ssn" value="" size="25" /> *</td>
		</tr>
	</table>
	
	<input type="submit" name="action" value="submit" />

</form>

<cfif isDefined('form.action') >

	<hr/>

	<cfset csFactory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
	<cfset csFactory.loadBeansFromXmlFile(expandPath("coldspring.xml"), true) />
	
	<cfset myValidator = csFactory.getBean('validat') />

	<cfdump var="#myValidator.validate('user', form).getErrors()#" />

</cfif>

</body>
</html>
