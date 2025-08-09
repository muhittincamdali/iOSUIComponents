# Form Components Guide

<!-- TOC START -->
## Table of Contents
- [Form Components Guide](#form-components-guide)
- [Overview](#overview)
- [Getting Started](#getting-started)
  - [Basic Form Creation](#basic-form-creation)
  - [Form Configuration](#form-configuration)
- [Form Field Types](#form-field-types)
  - [Text Fields](#text-fields)
  - [Number Fields](#number-fields)
  - [Selection Fields](#selection-fields)
- [Form Validation](#form-validation)
  - [Required Field Validation](#required-field-validation)
  - [Pattern Validation](#pattern-validation)
  - [Custom Validation](#custom-validation)
- [Form Interactions](#form-interactions)
  - [Field Change Handling](#field-change-handling)
  - [Form Submission](#form-submission)
  - [Auto Save](#auto-save)
- [Advanced Form Features](#advanced-form-features)
  - [Conditional Fields](#conditional-fields)
  - [Multi-Step Forms](#multi-step-forms)
  - [Field Grouping](#field-grouping)
- [Form Styling](#form-styling)
  - [Basic Styling](#basic-styling)
  - [Custom Styling](#custom-styling)
- [Form Accessibility](#form-accessibility)
  - [VoiceOver Support](#voiceover-support)
  - [Dynamic Type Support](#dynamic-type-support)
  - [High Contrast Support](#high-contrast-support)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Form](#swiftui-form)
  - [SwiftUI Usage](#swiftui-usage)
- [Best Practices](#best-practices)
  - [Form Design](#form-design)
  - [Form Validation](#form-validation)
  - [Form Interactions](#form-interactions)
- [Common Patterns](#common-patterns)
  - [Registration Form](#registration-form)
  - [Contact Form](#contact-form)
  - [Settings Form](#settings-form)
- [Error Handling](#error-handling)
  - [Form Errors](#form-errors)
- [Performance Considerations](#performance-considerations)
  - [Form Performance](#form-performance)
- [Migration Guide](#migration-guide)
  - [From UIKit Forms](#from-uikit-forms)
  - [From SwiftUI Forms](#from-swiftui-forms)
- [Support](#support)
<!-- TOC END -->


## Overview

The Form Components Guide provides comprehensive information about using form components in iOS UI Components. This guide covers form creation, validation, styling, accessibility, and best practices.

## Getting Started

### Basic Form Creation

```swift
// Create a basic form
let form = CustomForm(
    fields: [
        FormField(id: "name", type: .text, label: "Name", isRequired: true),
        FormField(id: "email", type: .email, label: "Email", isRequired: true),
        FormField(id: "password", type: .password, label: "Password", isRequired: true)
    ]
)

// Configure form
form.configure { config in
    config.enableValidation = true
    config.enableAutoSave = true
    config.enableAccessibility = true
}

// Handle form submission
form.onSubmit { formData in
    print("Form submitted: \(formData)")
    submitFormData(formData)
}
```

### Form Configuration

```swift
// Configure form
let form = CustomForm(fields: [])

form.configure { config in
    config.enableValidation = true
    config.enableAutoSave = true
    config.enableAccessibility = true
    config.enableHapticFeedback = true
    config.enableProgressIndicator = true
    config.enableFieldGrouping = true
    config.enableConditionalFields = true
    config.enableMultiStep = true
}

// Style the form
form.setBackgroundColor(.systemBackground)
form.setSpacing(16)
form.setPadding(UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
```

## Form Field Types

### Text Fields

```swift
// Text input field
let nameField = FormField(
    id: "name",
    type: .text,
    label: "Full Name",
    placeholder: "Enter your full name",
    isRequired: true
)

// Email input field
let emailField = FormField(
    id: "email",
    type: .email,
    label: "Email Address",
    placeholder: "Enter your email",
    validation: FieldValidation(
        required: true,
        pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    ),
    isRequired: true
)

// Password input field
let passwordField = FormField(
    id: "password",
    type: .password,
    label: "Password",
    placeholder: "Enter your password",
    validation: FieldValidation(
        required: true,
        minimumLength: 8,
        pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$"
    ),
    isRequired: true
)
```

### Number Fields

```swift
// Number input field
let ageField = FormField(
    id: "age",
    type: .number,
    label: "Age",
    placeholder: "Enter your age",
    validation: FieldValidation(
        required: true,
        minimumLength: 1,
        maximumLength: 3
    ),
    isRequired: true
)

// Phone input field
let phoneField = FormField(
    id: "phone",
    type: .phone,
    label: "Phone Number",
    placeholder: "Enter your phone number",
    validation: FieldValidation(
        required: true,
        pattern: "^[0-9]{10}$"
    ),
    isRequired: true
)
```

### Selection Fields

```swift
// Picker field
let countryField = FormField(
    id: "country",
    type: .picker,
    label: "Country",
    placeholder: "Select your country",
    validation: FieldValidation(required: true),
    isRequired: true
)

// Switch field
let newsletterField = FormField(
    id: "newsletter",
    type: .switch,
    label: "Subscribe to Newsletter",
    value: false
)

// Checkbox field
let termsField = FormField(
    id: "terms",
    type: .checkbox,
    label: "I agree to the Terms and Conditions",
    validation: FieldValidation(required: true),
    isRequired: true
)
```

## Form Validation

### Required Field Validation

```swift
// Create form with required fields
let form = CustomForm(
    fields: [
        FormField(id: "name", type: .text, label: "Name", isRequired: true),
        FormField(id: "email", type: .email, label: "Email", isRequired: true)
    ]
)

// Handle validation
form.onValidation { isValid in
    if isValid {
        print("Form is valid")
        enableSubmitButton()
    } else {
        print("Form has validation errors")
        disableSubmitButton()
    }
}
```

### Pattern Validation

```swift
// Email validation
let emailValidation = FieldValidation(
    required: true,
    pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
)

let emailField = FormField(
    id: "email",
    type: .email,
    label: "Email",
    validation: emailValidation,
    isRequired: true
)

// URL validation
let urlValidation = FieldValidation(
    required: true,
    pattern: "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
)

let urlField = FormField(
    id: "website",
    type: .url,
    label: "Website",
    validation: urlValidation,
    isRequired: true
)
```

### Custom Validation

```swift
// Custom validation function
let customValidation = FieldValidation(
    required: true,
    customValidation: { value in
        guard let text = value as? String else { return false }
        return text.count >= 5 && text.contains("@")
    }
)

let customField = FormField(
    id: "custom",
    type: .text,
    label: "Custom Field",
    validation: customValidation,
    isRequired: true
)
```

## Form Interactions

### Field Change Handling

```swift
let form = CustomForm(fields: [nameField, emailField])

// Handle field changes
form.onFieldChange { field in
    print("Field changed: \(field.id) = \(field.value ?? "")")
    
    // Real-time validation
    if field.id == "email" {
        validateEmail(field.value as? String ?? "")
    }
}
```

### Form Submission

```swift
let form = CustomForm(fields: [nameField, emailField, passwordField])

// Handle form submission
form.onSubmit { formData in
    print("Form submitted with data: \(formData)")
    
    // Show loading state
    form.isSubmitting = true
    
    // Submit form data
    submitFormData(formData) { success in
        DispatchQueue.main.async {
            form.isSubmitting = false
            
            if success {
                form.animateSuccess()
                showSuccessMessage()
            } else {
                form.animateError()
                showErrorMessage()
            }
        }
    }
}
```

### Auto Save

```swift
let form = CustomForm(fields: [nameField, emailField])

// Configure auto save
form.configure { config in
    config.enableAutoSave = true
    config.autoSaveDelay = 2.0 // Save after 2 seconds of inactivity
}

// Handle auto save
form.onAutoSave { formData in
    print("Auto saving form data: \(formData)")
    saveFormDataLocally(formData)
}
```

## Advanced Form Features

### Conditional Fields

```swift
// Create conditional form
let hasAccountField = FormField(
    id: "hasAccount",
    type: .switch,
    label: "I already have an account",
    value: false
)

let accountNumberField = FormField(
    id: "accountNumber",
    type: .text,
    label: "Account Number",
    placeholder: "Enter your account number",
    isRequired: true
)

let form = CustomForm(fields: [hasAccountField, accountNumberField])

// Configure conditional logic
form.configure { config in
    config.enableConditionalFields = true
}

// Handle conditional field changes
form.onFieldChange { field in
    if field.id == "hasAccount" {
        let hasAccount = field.value as? Bool ?? false
        accountNumberField.isHidden = !hasAccount
        accountNumberField.isRequired = hasAccount
    }
}
```

### Multi-Step Forms

```swift
// Create multi-step form
let step1Fields = [
    FormField(id: "firstName", type: .text, label: "First Name", isRequired: true),
    FormField(id: "lastName", type: .text, label: "Last Name", isRequired: true)
]

let step2Fields = [
    FormField(id: "email", type: .email, label: "Email", isRequired: true),
    FormField(id: "phone", type: .phone, label: "Phone", isRequired: true)
]

let step3Fields = [
    FormField(id: "address", type: .textarea, label: "Address", isRequired: true)
]

let multiStepForm = CustomForm(
    fields: step1Fields + step2Fields + step3Fields
)

// Configure multi-step
multiStepForm.configure { config in
    config.enableMultiStep = true
    config.enableProgressIndicator = true
}

// Handle step navigation
multiStepForm.onStepChange { currentStep in
    print("Current step: \(currentStep)")
    updateProgressIndicator(currentStep)
}
```

### Field Grouping

```swift
// Create form with field groups
let personalInfoGroup = FormFieldGroup(
    title: "Personal Information",
    fields: [nameField, emailField, phoneField]
)

let addressGroup = FormFieldGroup(
    title: "Address Information",
    fields: [addressField, cityField, zipField]
)

let form = CustomForm(
    fieldGroups: [personalInfoGroup, addressGroup]
)

// Configure field grouping
form.configure { config in
    config.enableFieldGrouping = true
}
```

## Form Styling

### Basic Styling

```swift
let form = CustomForm(fields: [nameField, emailField])

// Apply basic styling
form.setBackgroundColor(.systemBackground)
form.setSpacing(16)
form.setPadding(UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
form.setCornerRadius(12)
form.setBorderColor(.systemGray4)
form.setBorderWidth(1)
```

### Custom Styling

```swift
let form = CustomForm(fields: [nameField, emailField])

// Custom styling
form.configure { config in
    config.backgroundColor = .systemGray6
    config.fieldSpacing = 20
    config.fieldPadding = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    config.fieldCornerRadius = 8
    config.fieldBorderColor = .systemGray4
    config.fieldBorderWidth = 1
    config.labelTextColor = .label
    config.labelFont = .systemFont(ofSize: 16, weight: .medium)
    config.errorTextColor = .systemRed
    config.errorFont = .systemFont(ofSize: 14, weight: .regular)
}
```

## Form Accessibility

### VoiceOver Support

```swift
let form = CustomForm(fields: [nameField, emailField])

// Configure accessibility
form.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
form.accessibilityLabel = "Registration Form"
form.accessibilityHint = "Fill out the form to register"
```

### Dynamic Type Support

```swift
let form = CustomForm(fields: [nameField, emailField])

// Support dynamic type
form.configure { config in
    config.enableDynamicType = true
    config.labelTextStyle = .headline
    config.fieldTextStyle = .body
    config.errorTextStyle = .caption
}
```

### High Contrast Support

```swift
let form = CustomForm(fields: [nameField, emailField])

// Support high contrast
form.configure { config in
    config.enableHighContrast = true
}
```

## SwiftUI Support

### SwiftUI Form

```swift
public struct SwiftUIForm: View {
    public let fields: [FormField]
    public let onSubmit: ([String: Any]) -> Void
    public let onValidation: (Bool) -> Void
    
    public init(
        fields: [FormField],
        onSubmit: @escaping ([String: Any]) -> Void,
        onValidation: @escaping (Bool) -> Void
    )
    
    public var body: some View
}
```

### SwiftUI Usage

```swift
struct ContentView: View {
    @State private var formData: [String: Any] = [:]
    @State private var isValid = false
    
    var body: some View {
        SwiftUIForm(
            fields: [
                FormField(id: "name", type: .text, label: "Name", isRequired: true),
                FormField(id: "email", type: .email, label: "Email", isRequired: true)
            ],
            onSubmit: { data in
                formData = data
                print("Form submitted: \(data)")
            },
            onValidation: { valid in
                isValid = valid
            }
        )
        .padding()
    }
}
```

## Best Practices

### Form Design

1. **Clear Labels**: Use descriptive labels and placeholders
2. **Logical Order**: Arrange fields in logical order
3. **Validation Feedback**: Provide immediate feedback for validation errors
4. **Accessibility**: Always include proper accessibility labels
5. **Progress Indication**: Show progress for multi-step forms

### Form Validation

1. **Real-time Validation**: Validate as user types
2. **Clear Error Messages**: Provide helpful error messages
3. **Visual Feedback**: Show validation state visually
4. **Accessibility**: Announce validation errors to VoiceOver
5. **Performance**: Optimize validation for performance

### Form Interactions

1. **Responsive**: Respond quickly to user input
2. **Predictable**: Behave consistently across the app
3. **Accessible**: Support all accessibility features
4. **Secure**: Handle sensitive data appropriately
5. **User-Friendly**: Make forms easy to complete

## Common Patterns

### Registration Form

```swift
let registrationForm = CustomForm(
    fields: [
        FormField(id: "firstName", type: .text, label: "First Name", isRequired: true),
        FormField(id: "lastName", type: .text, label: "Last Name", isRequired: true),
        FormField(id: "email", type: .email, label: "Email", isRequired: true),
        FormField(id: "password", type: .password, label: "Password", isRequired: true),
        FormField(id: "confirmPassword", type: .password, label: "Confirm Password", isRequired: true),
        FormField(id: "terms", type: .checkbox, label: "I agree to the Terms", isRequired: true)
    ]
)

registrationForm.onSubmit { formData in
    registerUser(formData)
}
```

### Contact Form

```swift
let contactForm = CustomForm(
    fields: [
        FormField(id: "name", type: .text, label: "Name", isRequired: true),
        FormField(id: "email", type: .email, label: "Email", isRequired: true),
        FormField(id: "subject", type: .text, label: "Subject", isRequired: true),
        FormField(id: "message", type: .textarea, label: "Message", isRequired: true)
    ]
)

contactForm.onSubmit { formData in
    sendContactMessage(formData)
}
```

### Settings Form

```swift
let settingsForm = CustomForm(
    fields: [
        FormField(id: "notifications", type: .switch, label: "Enable Notifications"),
        FormField(id: "darkMode", type: .switch, label: "Dark Mode"),
        FormField(id: "language", type: .picker, label: "Language", isRequired: true),
        FormField(id: "autoSave", type: .switch, label: "Auto Save")
    ]
)

settingsForm.onSubmit { formData in
    updateSettings(formData)
}
```

## Error Handling

### Form Errors

```swift
public enum FormError: Error {
    case invalidConfiguration
    case validationFailed
    case submissionFailed
    case accessibilitySetupFailed
    case fieldNotFound
}

// Handle form errors
do {
    try form.configure(formConfig)
} catch FormError.invalidConfiguration {
    print("Invalid form configuration")
} catch {
    print("Form configuration failed: \(error)")
}
```

## Performance Considerations

### Form Performance

```swift
// Optimize form performance
let performanceConfig = FormPerformanceConfiguration()
performanceConfig.enableCaching = true
performanceConfig.enableLazyLoading = true
performanceConfig.enableOptimizedRendering = true

form.configurePerformance(performanceConfig)
```

## Migration Guide

### From UIKit Forms

```swift
// Old UIKit approach
let oldForm = UIView()
let nameTextField = UITextField()
let emailTextField = UITextField()
// ... setup fields manually

// New CustomForm approach
let newForm = CustomForm(
    fields: [
        FormField(id: "name", type: .text, label: "Name"),
        FormField(id: "email", type: .email, label: "Email")
    ]
)
```

### From SwiftUI Forms

```swift
// Old SwiftUI approach
Form {
    TextField("Name", text: $name)
    TextField("Email", text: $email)
}

// New SwiftUIForm approach
SwiftUIForm(
    fields: [
        FormField(id: "name", type: .text, label: "Name"),
        FormField(id: "email", type: .email, label: "Email")
    ],
    onSubmit: { data in
        // handle submission
    },
    onValidation: { valid in
        // handle validation
    }
)
```

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
