<cfsilent>
	<cfset testClasses = arrayNew(1) />
	<cfset arrayAppend(testClasses, "test.validat") />
	<cfset testsuite = createObject("component", "cfunit.framework.TestSuite").init( testClasses )>
</cfsilent>

<cfoutput>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

	<html>
	<head>
		<title>Validat Unit Test Suite</title>
	</head>

	<body
	<h1>Validat Unit Test Suite</h1>
	<cfinvoke component="cfunit.framework.TestRunner" method="run">
		<cfinvokeargument name="test" value="#testsuite#">
		<cfinvokeargument name="name" value="">
	</cfinvoke>
	</body>
	</html>
</cfoutput>