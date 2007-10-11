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
	
	<form action="submit.cfm" method="post" name="simpleForm1">
	
		<fieldset>
			<div class="formField">
				<label for="firstName">First Name:</label>
				<input type="text" name="firstName" id="firstName" class="inputText" />
				<div class="fieldMsg">required, less than 100 characters</div>
			</div>
			
			<div class="formField">
				<label for="middleName">Middle Name:</label>
				<input type="text" name="middleName" id="middleName" class="inputText" />
				<div class="fieldMsg">optional, less than 100 characters</div>
			</div>
			
			<div class="formField">
				<label for="lastName">Last Name:</label>
				<input type="text" name="lastName" id="lastName" class="inputText" />
				<div class="fieldMsg">required, less than 100 characters</div>
			</div>
		
			<div class="formField formButtons">
				<input type="submit" name="action" value="Submit" class="inputButton" />
				<input type="reset" value="Reset" class="inputButton" />
			</div>
		</fieldset>	
	</form>
</body>
</html>
