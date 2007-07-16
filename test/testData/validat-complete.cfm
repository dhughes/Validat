
<!--- setup the data sets collection --->
<cfset base.dataSets = structNew() />

<cfset base.dataSets.user = structNew() />

<cfset base.dataSets.user.assertionList = "" />
<cfset base.dataSets.user.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements = structNew() />
<cfset base.dataSets.user.name = "user" />
<cfset base.dataSets.user.transformer = "customTransformer" />

<cfset base.dataSets.user.dataElements.prefix = structNew() />
<cfset base.dataSets.user.dataElements.prefix.assertionList = "prefix" />
<cfset base.dataSets.user.dataElements.prefix.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements.prefix.connectTo = "" />
<cfset base.dataSets.user.dataElements.prefix.message = "" />
<cfset base.dataSets.user.dataElements.prefix.name = "prefix" />
<cfset base.dataSets.user.dataElements.prefix.required = "false" />

<cfset base.dataSets.user.dataElements.prefix.assertions[1] = structNew() />
<cfset base.dataSets.user.dataElements.prefix.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.user.dataElements.prefix.assertions[1].messages = structNew() />
<cfset base.dataSets.user.dataElements.prefix.assertions[1].rule = "prefix" />

<cfset base.dataSets.user.dataElements.prefix.assertions[1].messages.invalid = "errors.validation.user.prefix.invalid" />

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

<cfset base.dataSets.user.dataElements.suffix = structNew() />
<cfset base.dataSets.user.dataElements.suffix.assertionList = "suffix" />
<cfset base.dataSets.user.dataElements.suffix.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements.suffix.connectTo = "" />
<cfset base.dataSets.user.dataElements.suffix.message = "" />
<cfset base.dataSets.user.dataElements.suffix.name = "suffix" />
<cfset base.dataSets.user.dataElements.suffix.required = "false" />

<cfset base.dataSets.user.dataElements.suffix.assertions[1] = structNew() />
<cfset base.dataSets.user.dataElements.suffix.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.user.dataElements.suffix.assertions[1].messages = structNew() />
<cfset base.dataSets.user.dataElements.suffix.assertions[1].rule = "suffix" />

<cfset base.dataSets.user.dataElements.suffix.assertions[1].messages.invalid = "errors.validation.user.suffix.invalid" />

<cfset base.dataSets.user.dataElements.birthdate = structNew() />
<cfset base.dataSets.user.dataElements.birthdate.assertionList = "birthdate" />
<cfset base.dataSets.user.dataElements.birthdate.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements.birthdate.connectTo = "" />
<cfset base.dataSets.user.dataElements.birthdate.message = "errors.validation.user.birthdate.required" />
<cfset base.dataSets.user.dataElements.birthdate.name = "birthdate" />
<cfset base.dataSets.user.dataElements.birthdate.required = "true" />

<cfset base.dataSets.user.dataElements.birthdate.assertions[1] = structNew() />
<cfset base.dataSets.user.dataElements.birthdate.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.user.dataElements.birthdate.assertions[1].messages = structNew() />
<cfset base.dataSets.user.dataElements.birthdate.assertions[1].rule = "birthdate" />

<cfset base.dataSets.user.dataElements.birthdate.assertions[1].messages.invalid = "errors.validation.user.birthdate.invalid" />

<cfset base.dataSets.user.dataElements.ssn = structNew() />
<cfset base.dataSets.user.dataElements.ssn.assertionList = "ssn" />
<cfset base.dataSets.user.dataElements.ssn.assertions = arrayNew(1) />
<cfset base.dataSets.user.dataElements.ssn.connectTo = "" />
<cfset base.dataSets.user.dataElements.ssn.message = "errors.validation.user.ssn.required" />
<cfset base.dataSets.user.dataElements.ssn.name = "ssn" />
<cfset base.dataSets.user.dataElements.ssn.required = "true" />

<cfset base.dataSets.user.dataElements.ssn.assertions[1] = structNew() />
<cfset base.dataSets.user.dataElements.ssn.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.user.dataElements.ssn.assertions[1].messages = structNew() />
<cfset base.dataSets.user.dataElements.ssn.assertions[1].rule = "ssn" />

<cfset base.dataSets.user.dataElements.ssn.assertions[1].messages.invalid = "errors.validation.user.ssn.invalid" />

<cfset base.dataSets.person = structNew() />

<cfset base.dataSets.person.assertionList = "duplicatePerson" />
<cfset base.dataSets.person.assertions = arrayNew(1) />
<cfset base.dataSets.person.dataElements = structNew() />
<cfset base.dataSets.person.name = "person" />
<cfset base.dataSets.person.transformer = "" />

<cfset base.dataSets.person.assertions[1] = structNew() />
<cfset base.dataSets.person.assertions[1].args = structNew() />
<cfset base.dataSets.person.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.person.assertions[1].messages = structNew() />
<cfset base.dataSets.person.assertions[1].rule = "duplicatePerson" />

<cfset base.dataSets.person.assertions[1].args.firstName = "firstName" />
<cfset base.dataSets.person.assertions[1].args.lastName = "lastName" />
<cfset base.dataSets.person.assertions[1].args.emailAddress = "emailAddress" />

<cfset base.dataSets.person.assertions[1].messages.failByEmail = "errors.validation.person.duplicate.email" />
<cfset base.dataSets.person.assertions[1].messages.failByName = "errors.validation.person.duplicate.name" />

<cfset base.dataSets.person.dataElements.firstName = structNew() />
<cfset base.dataSets.person.dataElements.firstName.assertionList = "length" />
<cfset base.dataSets.person.dataElements.firstName.assertions = arrayNew(1) />
<cfset base.dataSets.person.dataElements.firstName.connectTo = "" />
<cfset base.dataSets.person.dataElements.firstName.message = "errors.validation.person.firstName.required" />
<cfset base.dataSets.person.dataElements.firstName.name = "firstName" />
<cfset base.dataSets.person.dataElements.firstName.required = "true" />

<cfset base.dataSets.person.dataElements.firstName.assertions[1] = structNew() />
<cfset base.dataSets.person.dataElements.firstName.assertions[1].args = structNew() />
<cfset base.dataSets.person.dataElements.firstName.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.person.dataElements.firstName.assertions[1].messages = structNew() />
<cfset base.dataSets.person.dataElements.firstName.assertions[1].rule = "length" />

<cfset base.dataSets.person.dataElements.firstName.assertions[1].args.max = 100 />
<cfset base.dataSets.person.dataElements.firstName.assertions[1].args.min = 1 />

<cfset base.dataSets.person.dataElements.firstName.assertions[1].messages.invalid = "errors.validation.person.firstName.invalidLength" />

<cfset base.dataSets.person.dataElements.middleName = structNew() />
<cfset base.dataSets.person.dataElements.middleName.assertionList = "length" />
<cfset base.dataSets.person.dataElements.middleName.assertions = arrayNew(1) />
<cfset base.dataSets.person.dataElements.middleName.connectTo = "" />
<cfset base.dataSets.person.dataElements.middleName.message = "" />
<cfset base.dataSets.person.dataElements.middleName.name = "middleName" />
<cfset base.dataSets.person.dataElements.middleName.required = "false" />

<cfset base.dataSets.person.dataElements.middleName.assertions[1] = structNew() />
<cfset base.dataSets.person.dataElements.middleName.assertions[1].args = structNew() />
<cfset base.dataSets.person.dataElements.middleName.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.person.dataElements.middleName.assertions[1].messages = structNew() />
<cfset base.dataSets.person.dataElements.middleName.assertions[1].rule = "length" />

<cfset base.dataSets.person.dataElements.middleName.assertions[1].args.max = 100 />
<cfset base.dataSets.person.dataElements.middleName.assertions[1].args.min = 1 />

<cfset base.dataSets.person.dataElements.middleName.assertions[1].messages.invalid = "errors.validation.person.middleName.invalidLength" />

<cfset base.dataSets.person.dataElements.lastName = structNew() />
<cfset base.dataSets.person.dataElements.lastName.assertionList = "length" />
<cfset base.dataSets.person.dataElements.lastName.assertions = arrayNew(1) />
<cfset base.dataSets.person.dataElements.lastName.connectTo = "" />
<cfset base.dataSets.person.dataElements.lastName.message = "errors.validation.person.lastName.required" />
<cfset base.dataSets.person.dataElements.lastName.name = "lastName" />
<cfset base.dataSets.person.dataElements.lastName.required = "true" />

<cfset base.dataSets.person.dataElements.lastName.assertions[1] = structNew() />
<cfset base.dataSets.person.dataElements.lastName.assertions[1].args = structNew() />
<cfset base.dataSets.person.dataElements.lastName.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.person.dataElements.lastName.assertions[1].messages = structNew() />
<cfset base.dataSets.person.dataElements.lastName.assertions[1].rule = "length" />

<cfset base.dataSets.person.dataElements.lastName.assertions[1].args.max = 100 />
<cfset base.dataSets.person.dataElements.lastName.assertions[1].args.min = 1 />

<cfset base.dataSets.person.dataElements.lastName.assertions[1].messages.invalid = "errors.validation.person.lastName.invalidLength" />

<cfset base.dataSets.person.dataElements.billingAddress = structNew() />
<cfset base.dataSets.person.dataElements.billingAddress.assertionList = "" />
<cfset base.dataSets.person.dataElements.billingAddress.assertions = arrayNew(1) />
<cfset base.dataSets.person.dataElements.billingAddress.connectTo = "address" />
<cfset base.dataSets.person.dataElements.billingAddress.message = "errors.validation.person.billingAddress.required" />
<cfset base.dataSets.person.dataElements.billingAddress.name = "billingAddress" />
<cfset base.dataSets.person.dataElements.billingAddress.required = "true" />

<cfset base.dataSets.person.dataElements.mailingAddress = structNew() />
<cfset base.dataSets.person.dataElements.mailingAddress.assertionList = "" />
<cfset base.dataSets.person.dataElements.mailingAddress.assertions = arrayNew(1) />
<cfset base.dataSets.person.dataElements.mailingAddress.connectTo = "address" />
<cfset base.dataSets.person.dataElements.mailingAddress.message = "errors.validation.person.mailingAddress.required" />
<cfset base.dataSets.person.dataElements.mailingAddress.name = "mailingAddress" />
<cfset base.dataSets.person.dataElements.mailingAddress.required = "true" />

<cfset base.dataSets.person.dataElements.emailAddress = structNew() />
<cfset base.dataSets.person.dataElements.emailAddress.assertionList = "emailAddress,length" />
<cfset base.dataSets.person.dataElements.emailAddress.assertions = arrayNew(1) />
<cfset base.dataSets.person.dataElements.emailAddress.connectTo = "" />
<cfset base.dataSets.person.dataElements.emailAddress.message = "errors.validation.person.emailAddress.required" />
<cfset base.dataSets.person.dataElements.emailAddress.name = "emailAddress" />
<cfset base.dataSets.person.dataElements.emailAddress.required = "true" />

<cfset base.dataSets.person.dataElements.emailAddress.assertions[1] = structNew() />
<cfset base.dataSets.person.dataElements.emailAddress.assertions[1].continueOnFail = "true" />
<cfset base.dataSets.person.dataElements.emailAddress.assertions[1].messages = structNew() />
<cfset base.dataSets.person.dataElements.emailAddress.assertions[1].rule = "emailAddress" />

<cfset base.dataSets.person.dataElements.emailAddress.assertions[1].messages.invalid = "errors.validation.person.emailAddress.invalid" />

<cfset base.dataSets.person.dataElements.emailAddress.assertions[2] = structNew() />
<cfset base.dataSets.person.dataElements.emailAddress.assertions[2].args = structNew() />
<cfset base.dataSets.person.dataElements.emailAddress.assertions[2].continueOnFail = "false" />
<cfset base.dataSets.person.dataElements.emailAddress.assertions[2].messages = structNew() />
<cfset base.dataSets.person.dataElements.emailAddress.assertions[2].rule = "length" />

<cfset base.dataSets.person.dataElements.emailAddress.assertions[2].args.max = 100 />
<cfset base.dataSets.person.dataElements.emailAddress.assertions[2].args.min = 1 />

<cfset base.dataSets.person.dataElements.emailAddress.assertions[2].messages.invalid = "errors.validation.person.emailAddress.invalidLength" />


<cfset base.dataSets.address = structNew() />

<cfset base.dataSets.address.assertionList = "state" />
<cfset base.dataSets.address.assertions = arrayNew(1) />
<cfset base.dataSets.address.dataElements = structNew() />
<cfset base.dataSets.address.name = "address" />
<cfset base.dataSets.address.transformer = "" />

<cfset base.dataSets.address.assertions[1] = structNew() />
<cfset base.dataSets.address.assertions[1].args = structNew() />
<cfset base.dataSets.address.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.address.assertions[1].messages = structNew() />
<cfset base.dataSets.address.assertions[1].rule = "state" />

<cfset base.dataSets.address.assertions[1].args.country = "country" />
<cfset base.dataSets.address.assertions[1].args.state = "state" />

<cfset base.dataSets.address.assertions[1].messages.invalid = "errors.validation.address.state.invalid" />
<cfset base.dataSets.address.assertions[1].messages.required = "errors.validation.address.state.required" />

<cfset base.dataSets.address.dataElements.street1 = structNew() />
<cfset base.dataSets.address.dataElements.street1.assertionList = "length" />
<cfset base.dataSets.address.dataElements.street1.assertions = arrayNew(1) />
<cfset base.dataSets.address.dataElements.street1.connectTo = "" />
<cfset base.dataSets.address.dataElements.street1.message = "errors.validation.address.street1.required" />
<cfset base.dataSets.address.dataElements.street1.name = "street1" />
<cfset base.dataSets.address.dataElements.street1.required = "true" />

<cfset base.dataSets.address.dataElements.street1.assertions[1] = structNew() />
<cfset base.dataSets.address.dataElements.street1.assertions[1].args = structNew() />
<cfset base.dataSets.address.dataElements.street1.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.address.dataElements.street1.assertions[1].messages = structNew() />
<cfset base.dataSets.address.dataElements.street1.assertions[1].rule = "length" />

<cfset base.dataSets.address.dataElements.street1.assertions[1].args.max = 100 />
<cfset base.dataSets.address.dataElements.street1.assertions[1].args.min = 1 />

<cfset base.dataSets.address.dataElements.street1.assertions[1].messages.invalid = "errors.validation.address.street1.invalidLength" />

<cfset base.dataSets.address.dataElements.street2 = structNew() />
<cfset base.dataSets.address.dataElements.street2.assertionList = "length" />
<cfset base.dataSets.address.dataElements.street2.assertions = arrayNew(1) />
<cfset base.dataSets.address.dataElements.street2.connectTo = "" />
<cfset base.dataSets.address.dataElements.street2.message = "" />
<cfset base.dataSets.address.dataElements.street2.name = "street2" />
<cfset base.dataSets.address.dataElements.street2.required = "false" />

<cfset base.dataSets.address.dataElements.street2.assertions[1] = structNew() />
<cfset base.dataSets.address.dataElements.street2.assertions[1].args = structNew() />
<cfset base.dataSets.address.dataElements.street2.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.address.dataElements.street2.assertions[1].messages = structNew() />
<cfset base.dataSets.address.dataElements.street2.assertions[1].rule = "length" />

<cfset base.dataSets.address.dataElements.street2.assertions[1].args.max = 100 />
<cfset base.dataSets.address.dataElements.street2.assertions[1].args.min = 1 />

<cfset base.dataSets.address.dataElements.street2.assertions[1].messages.invalid = "errors.validation.address.street2.invalidLength" />

<cfset base.dataSets.address.dataElements.city = structNew() />
<cfset base.dataSets.address.dataElements.city.assertionList = "length" />
<cfset base.dataSets.address.dataElements.city.assertions = arrayNew(1) />
<cfset base.dataSets.address.dataElements.city.connectTo = "" />
<cfset base.dataSets.address.dataElements.city.message = "errors.validation.address.city.required" />
<cfset base.dataSets.address.dataElements.city.name = "city" />
<cfset base.dataSets.address.dataElements.city.required = "true" />

<cfset base.dataSets.address.dataElements.city.assertions[1] = structNew() />
<cfset base.dataSets.address.dataElements.city.assertions[1].args = structNew() />
<cfset base.dataSets.address.dataElements.city.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.address.dataElements.city.assertions[1].messages = structNew() />
<cfset base.dataSets.address.dataElements.city.assertions[1].rule = "length" />

<cfset base.dataSets.address.dataElements.city.assertions[1].args.max = 100 />
<cfset base.dataSets.address.dataElements.city.assertions[1].args.min = 1 />

<cfset base.dataSets.address.dataElements.city.assertions[1].messages.invalid = "errors.validation.address.city.invalidLength" />

<cfset base.dataSets.address.dataElements.postalCode = structNew() />
<cfset base.dataSets.address.dataElements.postalCode.assertionList = "postalCode" />
<cfset base.dataSets.address.dataElements.postalCode.assertions = arrayNew(1) />
<cfset base.dataSets.address.dataElements.postalCode.connectTo = "" />
<cfset base.dataSets.address.dataElements.postalCode.message = "errors.validation.address.postalCode.required" />
<cfset base.dataSets.address.dataElements.postalCode.name = "postalCode" />
<cfset base.dataSets.address.dataElements.postalCode.required = "true" />

<cfset base.dataSets.address.dataElements.postalCode.assertions[1] = structNew() />
<cfset base.dataSets.address.dataElements.postalCode.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.address.dataElements.postalCode.assertions[1].messages = structNew() />
<cfset base.dataSets.address.dataElements.postalCode.assertions[1].rule = "postalCode" />

<cfset base.dataSets.address.dataElements.postalCode.assertions[1].messages.invalid = "errors.validation.address.postalCode.invalid" />

<cfset base.dataSets.address.dataElements.country = structNew() />
<cfset base.dataSets.address.dataElements.country.assertionList = "country" />
<cfset base.dataSets.address.dataElements.country.assertions = arrayNew(1) />
<cfset base.dataSets.address.dataElements.country.connectTo = "" />
<cfset base.dataSets.address.dataElements.country.message = "errors.validation.address.country.required" />
<cfset base.dataSets.address.dataElements.country.name = "country" />
<cfset base.dataSets.address.dataElements.country.required = "true" />

<cfset base.dataSets.address.dataElements.country.assertions[1] = structNew() />
<cfset base.dataSets.address.dataElements.country.assertions[1].continueOnFail = "false" />
<cfset base.dataSets.address.dataElements.country.assertions[1].messages = structNew() />
<cfset base.dataSets.address.dataElements.country.assertions[1].rule = "country" />

<cfset base.dataSets.address.dataElements.country.assertions[1].messages.invalid = "errors.validation.address.country.invalid" />


<!--- setup the validation rules collection --->
<cfset base.validationRules = structNew() />

<cfset base.validationRules.alpha = structNew() />
<cfset base.validationRules.alpha.name = "alpha" />
<cfset base.validationRules.alpha.validator = "validateAlpha" />

<cfset base.validationRules.alphaNumeric = structNew() />
<cfset base.validationRules.alphaNumeric.name = "alphaNumeric" />
<cfset base.validationRules.alphaNumeric.validator = "validateAlphaNumeric" />

<cfset base.validationRules.birthdate = structNew() />
<cfset base.validationRules.birthdate.args = structNew() />
<cfset base.validationRules.birthdate.name = "birthdate" />
<cfset base.validationRules.birthdate.validator = "validateBirthDate" />

<cfset base.validationRules.birthdate.args.max = 120 />
<cfset base.validationRules.birthdate.args.min = 0 />

<cfset base.validationRules.creditCard = structNew() />
<cfset base.validationRules.creditCard.name = "creditCard" />
<cfset base.validationRules.creditCard.validator = "validateCreditCard" />

<cfset base.validationRules.duplicatePerson = structNew() />
<cfset base.validationRules.duplicatePerson.name = "duplicatePerson" />
<cfset base.validationRules.duplicatePerson.validator = "validateDuplicatePerson" />

<cfset base.validationRules.length = structNew() />
<cfset base.validationRules.length.args = structNew() />
<cfset base.validationRules.length.name = "length" />
<cfset base.validationRules.length.validator = "validateLength" />

<cfset base.validationRules.length.args.max = 100 />
<cfset base.validationRules.length.args.min = 0 />

<cfset base.validationRules.prefix = structNew() />
<cfset base.validationRules.prefix.name = "prefix" />
<cfset base.validationRules.prefix.validator = "validatePrefix" />

<cfset base.validationRules.ssn = structNew() />
<cfset base.validationRules.ssn.name = "ssn" />
<cfset base.validationRules.ssn.validator = "validateSSN" />

<cfset base.validationRules.suffix = structNew() />
<cfset base.validationRules.suffix.name = "suffix" />
<cfset base.validationRules.suffix.validator = "validateSuffix" />
