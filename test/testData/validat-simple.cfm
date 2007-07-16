
<!--- setup the data sets collection --->
<cfset base.dataSets = structNew() />

<cfset base.dataSets.user = structNew() />

<cfset base.dataSets.user.assertionList = "" />
<cfset base.dataSets.user.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements = structNew() />
<cfset base.dataSets.user.name = "user" />
<cfset base.dataSets.user.transformer = "" />

<cfset base.dataSets.user.dataElements.firstName = structNew() />
<cfset base.dataSets.user.dataElements.firstName.assertionList = "length" />
<cfset base.dataSets.user.dataElements.firstName.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements.firstName.connectTo = "" />
<cfset base.dataSets.user.dataElements.firstName.message = "errors.validation.user.firstName.required" />
<cfset base.dataSets.user.dataElements.firstName.name = "firstName" />
<cfset base.dataSets.user.dataElements.firstName.required = "true" />

<cfset base.dataSets.user.dataElements.firstName.assertions[1] = structNew() />
<cfset base.dataSets.user.dataElements.firstName.assertions[1].args = structNew() />
<cfset base.dataSets.user.dataElements.firstName.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.user.dataElements.firstName.assertions[1].messages = structNew() />
<cfset base.dataSets.user.dataElements.firstName.assertions[1].rule = "length" />

<cfset base.dataSets.user.dataElements.firstName.assertions[1].args.max = 100 />
<cfset base.dataSets.user.dataElements.firstName.assertions[1].args.min = 1 />

<cfset base.dataSets.user.dataElements.firstName.assertions[1].messages.invalid = "errors.validation.user.firstName.invalidLength" />

<cfset base.dataSets.user.dataElements.middleName = structNew() />
<cfset base.dataSets.user.dataElements.middleName.assertionList = "length" />
<cfset base.dataSets.user.dataElements.middleName.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements.middleName.connectTo = "" />
<cfset base.dataSets.user.dataElements.middleName.message = "" />
<cfset base.dataSets.user.dataElements.middleName.name = "middleName" />
<cfset base.dataSets.user.dataElements.middleName.required = "false" />

<cfset base.dataSets.user.dataElements.middleName.assertions[1] = structNew() />
<cfset base.dataSets.user.dataElements.middleName.assertions[1].args = structNew() />
<cfset base.dataSets.user.dataElements.middleName.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.user.dataElements.middleName.assertions[1].messages = structNew() />
<cfset base.dataSets.user.dataElements.middleName.assertions[1].rule = "length" />

<cfset base.dataSets.user.dataElements.middleName.assertions[1].args.max = 100 />
<cfset base.dataSets.user.dataElements.middleName.assertions[1].args.min = 1 />

<cfset base.dataSets.user.dataElements.middleName.assertions[1].messages.invalid = "errors.validation.user.middleName.invalidLength" />

<cfset base.dataSets.user.dataElements.lastName = structNew() />
<cfset base.dataSets.user.dataElements.lastName.assertionList = "length" />
<cfset base.dataSets.user.dataElements.lastName.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements.lastName.connectTo = "" />
<cfset base.dataSets.user.dataElements.lastName.message = "errors.validation.user.lastName.required" />
<cfset base.dataSets.user.dataElements.lastName.name = "lastName" />
<cfset base.dataSets.user.dataElements.lastName.required = "true" />

<cfset base.dataSets.user.dataElements.lastName.assertions[1] = structNew() />
<cfset base.dataSets.user.dataElements.lastName.assertions[1].args = structNew() />
<cfset base.dataSets.user.dataElements.lastName.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.user.dataElements.lastName.assertions[1].messages = structNew() />
<cfset base.dataSets.user.dataElements.lastName.assertions[1].rule = "length" />

<cfset base.dataSets.user.dataElements.lastName.assertions[1].args.max = 100 />
<cfset base.dataSets.user.dataElements.lastName.assertions[1].args.min = 1 />

<cfset base.dataSets.user.dataElements.lastName.assertions[1].messages.invalid = "errors.validation.user.lastName.invalidLength" />

<!--- setup the validation rules collection --->
<cfset base.validationRules = structNew() />

<cfset base.validationRules.alpha = structNew() />
<cfset base.validationRules.alpha.name = "alpha" />
<cfset base.validationRules.alpha.validator = "validateAlpha" />

<cfset base.validationRules.alphaNumeric = structNew() />
<cfset base.validationRules.alphaNumeric.name = "alphaNumeric" />
<cfset base.validationRules.alphaNumeric.validator = "validateAlphaNumeric" />

<cfset base.validationRules.length = structNew() />
<cfset base.validationRules.length.args = structNew() />
<cfset base.validationRules.length.name = "length" />
<cfset base.validationRules.length.validator = "validateLength" />

<cfset base.validationRules.length.args.max = 100 />
<cfset base.validationRules.length.args.min = 0 />