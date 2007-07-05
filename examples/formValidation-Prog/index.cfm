
<cfset csFactory = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init() />
<cfset csFactory.loadBeansFromXmlFile(expandPath("coldSpring.xml"), true) />

<cfset myValidator = csFactory.getBean('validat') />

<!--- insert validation rules --->

<cfset myValidator.addRule('alpha', 'validateAlpha') />
<cfset myValidator.addRule('alphaNumeric', 'validateAlphaNumeric') />

<cfset ruleArgs = structNew() />
<cfset ruleArgs.min = 0 />
<cfset ruleArgs.max = 120 />
<cfset myValidator.addRule('birthdate', 'validateBirthDate', ruleArgs) />

<cfset myValidator.addRule('creditCard', 'validateCreditCard') />

<cfset ruleArgs = structNew() />
<cfset ruleArgs.min = 0 />
<cfset ruleArgs.max = 100 />
<cfset myValidator.addRule('length', 'validateLength', ruleArgs) />

<cfset myValidator.addRule('required', 'validateRequired') />
<cfset myValidator.addRule('ssn', 'validateSSN') />
<cfset myValidator.addRule('prefix', 'validatePrefix') />
<cfset myValidator.addRule('suffix', 'validateSuffix') />

<!--- insert data sets --->
<cfset myValidator.addDataSet('user', 'BeanTransformer') />

<!--- add prefix data element --->
<cfset myValidator.addDataElement('user', 'prefix') />
<cfset myValidator.addAssert('user', 'prefix', 'prefix', 'errors.validation.user.prefix.invalid') />

<!--- add first name data element --->
<cfset myValidator.addDataElement('user', 'firstName') />
<cfset myValidator.addAssert('user', 'firstName', 'required', 'errors.validation.user.firstName.required') />

<cfset assertArgs = structNew() />
<cfset assertArgs.min = 0 />
<cfset assertArgs.max = 100 />
<cfset myValidator.addAssert('user', 'firstName', 'length', 'errors.validation.user.firstName.invalidLength', assertArgs) />

<!--- add middle name data element --->
<cfset myValidator.addDataElement('user', 'middleName') />

<cfset assertArgs = structNew() />
<cfset assertArgs.min = 0 />
<cfset assertArgs.max = 100 />
<cfset myValidator.addAssert('user', 'middleName', 'length', 'errors.validation.user.middleName.invalidLength', assertArgs) />

<!--- add last name data element --->
<cfset myValidator.addDataElement('user', 'lastName') />
<cfset myValidator.addAssert('user', 'lastName', 'required', 'errors.validation.user.lastName.required') />

<cfset assertArgs = structNew() />
<cfset assertArgs.min = 0 />
<cfset assertArgs.max = 100 />
<cfset myValidator.addAssert('user', 'lastName', 'length', 'errors.validation.user.lastName.invalidLength', assertArgs) />

<!--- add suffix data element --->
<cfset myValidator.addDataElement('user', 'suffix') />
<cfset myValidator.addAssert('user', 'suffix', 'suffix', 'errors.validation.user.suffix.invalid') />

<!--- add birthdate data element --->
<cfset myValidator.addDataElement('user', 'birthdate') />
<cfset myValidator.addAssert('user', 'birthdate', 'required', 'errors.validation.user.birthdate.required') />
<cfset myValidator.addAssert('user', 'birthdate', 'birthdate', 'errors.validation.user.birthdate.invalid') />

<!--- add birthdate data element --->
<cfset myValidator.addDataElement('user', 'ssn') />
<cfset myValidator.addAssert('user', 'ssn', 'required', 'errors.validation.user.ssn.required') />
<cfset myValidator.addAssert('user', 'ssn', 'ssn', 'errors.validation.user.ssn.invalid') />
