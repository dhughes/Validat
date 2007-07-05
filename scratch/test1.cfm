
<cfset csFactory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
<cfset csFactory.loadBeansFromXmlFile(expandPath("coldspring.xml"), true) />

<!---
<cfset myValidator = csFactory.getBean('validat') />
--->

<cfset myValidator = createObject('component', 'validat.validat').init(csFactory.getBean('csFactory'), 'validat.xml') />

<!--- test data structure .... this could be the form struct from a form --->
<cfset user = structNew() />
<cfset user.prefix_name = "" />
<cfset user.first_name = "" />
<cfset user.middle_name = "" />
<cfset user.last_name = "Abdelnaby" />
<cfset user.suffix_name = "" />
<cfset user.nick_name = "Courtney" />
<cfset user.gender = "F" />
<cfset user.divorced = "" />
<cfset user.dob = "07/10/1952" />
<cfset user.ssn = "" />
<cfset user.student_id = "112595470" />
<cfset user.title = "" />
<cfset user.occupation = "" /> 
<cfset user.mobile = "" /> 

<cfdump var="#myValidator.validate('user', user)#" />