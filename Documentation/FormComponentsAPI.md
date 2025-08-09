# Form Components API

<!-- TOC START -->
## Table of Contents
- [Form Components API](#form-components-api)
- [Overview](#overview)
- [Core Components](#core-components)
  - [CustomForm](#customform)
  - [FormField](#formfield)
  - [FormFieldType](#formfieldtype)
- [Configuration](#configuration)
  - [FormConfiguration](#formconfiguration)
- [Usage Examples](#usage-examples)
  - [Basic Form](#basic-form)
  - [Advanced Form with Conditional Fields](#advanced-form-with-conditional-fields)
  - [Multi-Step Form](#multi-step-form)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Form Component](#swiftui-form-component)
  - [SwiftUI Usage](#swiftui-usage)
- [Validation](#validation)
  - [Built-in Validation Types](#built-in-validation-types)
  - [Custom Validation](#custom-validation)
- [Accessibility](#accessibility)
  - [VoiceOver Support](#voiceover-support)
  - [Dynamic Type Support](#dynamic-type-support)
- [Error Handling](#error-handling)
  - [Form Errors](#form-errors)
- [Performance Considerations](#performance-considerations)
  - [Memory Management](#memory-management)
  - [Rendering Performance](#rendering-performance)
- [Best Practices](#best-practices)
  - [Form Design](#form-design)
  - [Code Organization](#code-organization)
- [Migration Guide](#migration-guide)
  - [From UIKit Forms](#from-uikit-forms)
  - [From SwiftUI Forms](#from-swiftui-forms)
- [Version History](#version-history)
  - [Version 1.0.0](#version-100)
  - [Version 1.1.0](#version-110)
  - [Version 1.2.0](#version-120)
- [Support](#support)
<!-- TOC END -->


## Overview

The Form Components API provides comprehensive form components for iOS applications. This API supports both SwiftUI and UIKit, offering enterprise-grade form solutions with validation, auto-completion, accessibility features, and customizable styling.

## Core Components

### CustomForm

The main form component that provides extensive customization options.

```swift
public class CustomForm: UIView {
    // MARK: - Properties
    public var fields: [FormField]
    public var validation: FormValidation?
    public var isSubmitting: Bool
    public var hasErrors: Bool
    
    // MARK: - Initialization
    public init(fields: [FormField], validation: FormValidation? = nil)
    
    // MARK: - Configuration
    public func configure(_ configuration: FormConfiguration)
    public func addField(_ field: FormField)
    public func removeField(_ field: FormField)
    public func clearForm()
    
    // MARK: - Events
    public func onSubmit(_ action: @escaping ([String: Any]) -> Void)
    public func onValidation(_ action: @escaping (Bool) -> Void)
    public func onFieldChange(_ action: @escaping (FormField) -> Void)
    
    // MARK: - Validation
    public func validate() -> Bool
    public func getFormData() -> [String: Any]
    public func setFormData(_ data: [String: Any])
}
```

### FormField

Model for form fields.

```swift
public struct FormField {
    public let id: String
    public let type: FormFieldType
    public let label: String
    public let placeholder: String?
    public let validation: FieldValidation?
    public let isRequired: Bool
    public let value: Any?
    
    public init(
        id: String,
        type: FormFieldType,
        label: String,
        placeholder: String? = nil,
        validation: FieldValidation? = nil,
        isRequired: Bool = false,
        value: Any? = nil
    )
}
```

### FormFieldType

Enumeration defining different form field types.

```swift
public enum FormFieldType {
    case text
    case email
    case password
    case number
    case phone
    case date
    case picker
    case switch
    case checkbox
    case radio
    case textarea
    case custom(FormFieldCustomType)
}
```

## Configuration

### FormConfiguration

Configuration object for form setup.

```swift
public struct FormConfiguration {
    public var enableValidation: Bool
    public var enableAutoSave: Bool
    public var enableAccessibility: Bool
    public var enableHapticFeedback: Bool
    public var enableProgressIndicator: Bool
    public var enableFieldGrouping: Bool
    public var enableConditionalFields: Bool
    public var enableMultiStep: Bool
    
    public init()
}
```

## Usage Examples

### Basic Form

```swift
// Create form fields
let nameField = FormField(
    id: "name",
    type: .text,
    label: "Full Name",
    placeholder: "Enter your full name",
    isRequired: true
)

let emailField = FormField(
    id: "email",
    type: .email,
    label: "Email Address",
    placeholder: "Enter your email",
    validation: FieldValidation(pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"),
    isRequired: true
)

let passwordField = FormField(
    id: "password",
    type: .password,
    label: "Password",
    placeholder: "Enter your password",
    validation: FieldValidation(minimumLength: 8),
    isRequired: true
)

// Create form
let form = CustomForm(
    fields: [nameField, emailField, passwordField]
)

// Configure form
form.configure { config in
    config.enableValidation = true
    config.enableAutoSave = true
    config.enableAccessibility = true
}

// Handle form submission
form.onSubmit { formData in
    print("Form submitted with data: \(formData)")
    
    // Simulate API call
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        print("Form submitted successfully")
    }
}

// Handle validation
form.onValidation { isValid in
    print("Form validation: \(isValid)")
}
```

### Advanced Form with Conditional Fields

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

let form = CustomForm(
    fields: [hasAccountField, accountNumberField]
)

// Configure conditional logic
form.configure { config in
    config.enableConditionalFields = true
}

// Handle field changes
form.onFieldChange { field in
    if field.id == "hasAccount" {
        let hasAccount = field.value as? Bool ?? false
        accountNumberField.isHidden = !hasAccount
    }
}
```

### Multi-Step Form

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
}
```

## SwiftUI Support

### SwiftUI Form Component

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

## Validation

### Built-in Validation Types

```swift
// Required field validation
let requiredValidation = FieldValidation(required: true)

// Email validation
let emailValidation = FieldValidation(
    required: true,
    pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
)

// Password validation
let passwordValidation = FieldValidation(
    required: true,
    minimumLength: 8,
    pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$"
)

// Phone validation
let phoneValidation = FieldValidation(
    required: true,
    pattern: "^[0-9]{10}$"
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
```

## Accessibility

### VoiceOver Support

```swift
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
// Support dynamic type
form.configure { config in
    config.enableDynamicType = true
    config.labelTextStyle = .headline
    config.fieldTextStyle = .body
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

// Handle errors
do {
    try form.configure(formConfig)
} catch FormError.invalidConfiguration {
    print("Invalid form configuration")
} catch {
    print("Form configuration failed: \(error)")
}
```

## Performance Considerations

### Memory Management

- Forms are automatically deallocated when not in use
- Validation patterns are cached for performance
- Form data is managed efficiently

### Rendering Performance

- Efficient form rendering with optimized layouts
- Optimized validation calculations
- Smooth animations for field transitions

## Best Practices

### Form Design

1. **Clear Labels**: Use descriptive labels and placeholders
2. **Logical Order**: Arrange fields in logical order
3. **Validation Feedback**: Provide immediate feedback for validation errors
4. **Accessibility**: Always include proper accessibility labels
5. **Progress Indication**: Show progress for multi-step forms

### Code Organization

1. **Configuration**: Use configuration objects for complex setups
2. **Validation**: Create reusable validation rules
3. **Styling**: Use consistent styling across all forms
4. **Testing**: Test all form states and interactions

## Migration Guide

### From UIKit Forms

```swift
// Old UIKit approach
let oldForm = UIView()
let nameTextField = UITextField()
let emailTextField = UITextField()
// ... setup fields

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

## Version History

### Version 1.0.0
- Initial release with basic form functionality
- Support for common form field types
- Basic validation support

### Version 1.1.0
- Added custom validation support
- Enhanced accessibility features
- Improved styling options

### Version 1.2.0
- Added multi-step form support
- Enhanced SwiftUI integration
- Performance optimizations

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
