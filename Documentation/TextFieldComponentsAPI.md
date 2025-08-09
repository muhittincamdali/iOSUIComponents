# Text Field Components API

<!-- TOC START -->
## Table of Contents
- [Text Field Components API](#text-field-components-api)
- [Overview](#overview)
- [Core Components](#core-components)
  - [CustomTextField](#customtextfield)
  - [TextFieldType](#textfieldtype)
  - [TextFieldValidation](#textfieldvalidation)
- [Configuration](#configuration)
  - [TextFieldConfiguration](#textfieldconfiguration)
- [Usage Examples](#usage-examples)
  - [Basic Text Field](#basic-text-field)
  - [Email Text Field with Validation](#email-text-field-with-validation)
  - [Password Text Field](#password-text-field)
  - [Phone Number Text Field](#phone-number-text-field)
- [Accessibility](#accessibility)
  - [VoiceOver Support](#voiceover-support)
  - [Dynamic Type Support](#dynamic-type-support)
- [Validation](#validation)
  - [Built-in Validation Types](#built-in-validation-types)
  - [Custom Validation](#custom-validation)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Text Field Component](#swiftui-text-field-component)
  - [SwiftUI Usage](#swiftui-usage)
- [Error Handling](#error-handling)
  - [Text Field Errors](#text-field-errors)
- [Performance Considerations](#performance-considerations)
  - [Memory Management](#memory-management)
  - [Rendering Performance](#rendering-performance)
- [Best Practices](#best-practices)
  - [Text Field Design](#text-field-design)
  - [Code Organization](#code-organization)
- [Migration Guide](#migration-guide)
  - [From UITextField](#from-uitextfield)
  - [From SwiftUI TextField](#from-swiftui-textfield)
- [Version History](#version-history)
  - [Version 1.0.0](#version-100)
  - [Version 1.1.0](#version-110)
  - [Version 1.2.0](#version-120)
- [Support](#support)
<!-- TOC END -->


## Overview

The Text Field Components API provides advanced text input components for iOS applications. This API supports both SwiftUI and UIKit, offering enterprise-grade text field solutions with validation, auto-completion, accessibility features, and customizable styling.

## Core Components

### CustomTextField

The main text field component that provides extensive customization options.

```swift
public class CustomTextField: UIView {
    // MARK: - Properties
    public var placeholder: String
    public var text: String
    public var type: TextFieldType
    public var validation: TextFieldValidation?
    public var isSecureEntry: Bool
    public var isEnabled: Bool
    public var hasError: Bool
    
    // MARK: - Initialization
    public init(placeholder: String, type: TextFieldType = .text, validation: TextFieldValidation? = nil)
    
    // MARK: - Configuration
    public func configure(_ configuration: TextFieldConfiguration)
    public func setPlaceholder(_ placeholder: String)
    public func setText(_ text: String)
    public func setSecureEntry(_ isSecure: Bool)
    
    // MARK: - Events
    public func onTextChange(_ action: @escaping (String) -> Void)
    public func onValidation(_ action: @escaping (Bool) -> Void)
    public func onFocus(_ action: @escaping () -> Void)
    public func onBlur(_ action: @escaping () -> Void)
    
    // MARK: - Styling
    public func setBackgroundColor(_ color: UIColor)
    public func setTextColor(_ color: UIColor)
    public func setPlaceholderColor(_ color: UIColor)
    public func setBorderColor(_ color: UIColor, for state: TextFieldState)
    public func setCornerRadius(_ radius: CGFloat)
    public func setPadding(_ padding: UIEdgeInsets)
    
    // MARK: - Validation
    public func validate() -> Bool
    public func setValidation(_ validation: TextFieldValidation)
    public func clearError()
    public func showError(_ message: String)
}
```

### TextFieldType

Enumeration defining different text field types.

```swift
public enum TextFieldType {
    case text
    case email
    case password
    case number
    case phone
    case url
    case search
    case multiline
    case custom(TextFieldCustomType)
}

public struct TextFieldCustomType {
    public let keyboardType: UIKeyboardType
    public let autocapitalizationType: UITextAutocapitalizationType
    public let autocorrectionType: UITextAutocorrectionType
    public let spellCheckingType: UITextSpellCheckingType
    public let returnKeyType: UIReturnKeyType
}
```

### TextFieldValidation

Validation rules for text fields.

```swift
public struct TextFieldValidation {
    public let required: Bool
    public let minimumLength: Int?
    public let maximumLength: Int?
    public let pattern: String?
    public let customValidation: ((String) -> Bool)?
    
    public init(
        required: Bool = false,
        minimumLength: Int? = nil,
        maximumLength: Int? = nil,
        pattern: String? = nil,
        customValidation: ((String) -> Bool)? = nil
    )
}
```

## Configuration

### TextFieldConfiguration

Configuration object for text field setup.

```swift
public struct TextFieldConfiguration {
    public var enableValidation: Bool
    public var enableAutoComplete: Bool
    public var enableSecureEntry: Bool
    public var enableAccessibility: Bool
    public var enableClearButton: Bool
    public var enableCharacterCount: Bool
    public var enableSuggestions: Bool
    public var enableFormatting: Bool
    
    public init()
}
```

## Usage Examples

### Basic Text Field

```swift
// Create a basic text field
let textField = CustomTextField(
    placeholder: "Enter your name",
    type: .text
)

// Configure text field
textField.configure { config in
    config.enableValidation = true
    config.enableClearButton = true
}

// Handle text changes
textField.onTextChange { text in
    print("Text changed: \(text)")
}

// Handle validation
textField.onValidation { isValid in
    print("Validation result: \(isValid)")
}
```

### Email Text Field with Validation

```swift
// Create email text field with validation
let emailValidation = TextFieldValidation(
    required: true,
    pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
)

let emailTextField = CustomTextField(
    placeholder: "Enter your email",
    type: .email,
    validation: emailValidation
)

// Configure with custom styling
emailTextField.configure { config in
    config.enableValidation = true
    config.enableAutoComplete = true
}

// Style the text field
emailTextField.setBackgroundColor(.systemBackground)
emailTextField.setBorderColor(.systemGray4, for: .normal)
emailTextField.setBorderColor(.systemBlue, for: .focused)
emailTextField.setBorderColor(.systemRed, for: .error)
emailTextField.setCornerRadius(8)
```

### Password Text Field

```swift
// Create password text field
let passwordValidation = TextFieldValidation(
    required: true,
    minimumLength: 8,
    pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$"
)

let passwordTextField = CustomTextField(
    placeholder: "Enter your password",
    type: .password,
    validation: passwordValidation
)

// Configure password field
passwordTextField.configure { config in
    config.enableSecureEntry = true
    config.enableValidation = true
    config.enableCharacterCount = true
}

// Set secure entry
passwordTextField.setSecureEntry(true)

// Handle validation
passwordTextField.onValidation { isValid in
    if isValid {
        print("Password is valid")
    } else {
        passwordTextField.showError("Password must be at least 8 characters with letters and numbers")
    }
}
```

### Phone Number Text Field

```swift
// Create phone number text field
let phoneTextField = CustomTextField(
    placeholder: "Enter phone number",
    type: .phone
)

// Configure with formatting
phoneTextField.configure { config in
    config.enableFormatting = true
}

// Custom phone formatting
phoneTextField.onTextChange { text in
    let formatted = formatPhoneNumber(text)
    if formatted != text {
        phoneTextField.setText(formatted)
    }
}

func formatPhoneNumber(_ text: String) -> String {
    // Remove all non-digit characters
    let digits = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    
    // Format as (XXX) XXX-XXXX
    if digits.count >= 6 {
        let index = digits.index(digits.startIndex, offsetBy: 6)
        let firstPart = String(digits[..<index])
        let secondPart = String(digits[index...])
        
        return "(\(firstPart.prefix(3))) \(firstPart.dropFirst(3))-\(secondPart.prefix(4))"
    } else if digits.count >= 3 {
        let index = digits.index(digits.startIndex, offsetBy: 3)
        let firstPart = String(digits[..<index])
        let secondPart = String(digits[index...])
        
        return "(\(firstPart)) \(secondPart)"
    }
    
    return digits
}
```

## Accessibility

### VoiceOver Support

```swift
// Configure accessibility
emailTextField.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
emailTextField.accessibilityLabel = "Email Address Field"
emailTextField.accessibilityHint = "Enter your email address"
emailTextField.accessibilityTraits = .textField
```

### Dynamic Type Support

```swift
// Support dynamic type
emailTextField.configure { config in
    config.enableDynamicType = true
    config.textStyle = .body
}
```

## Validation

### Built-in Validation Types

```swift
// Email validation
let emailValidation = TextFieldValidation(
    required: true,
    pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
)

// Password validation
let passwordValidation = TextFieldValidation(
    required: true,
    minimumLength: 8,
    pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$"
)

// URL validation
let urlValidation = TextFieldValidation(
    required: true,
    pattern: "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
)

// Phone validation
let phoneValidation = TextFieldValidation(
    required: true,
    pattern: "^[0-9]{10}$"
)
```

### Custom Validation

```swift
// Custom validation function
let customValidation = TextFieldValidation(
    required: true,
    customValidation: { text in
        // Custom validation logic
        return text.contains("@") && text.contains(".")
    }
)

let customTextField = CustomTextField(
    placeholder: "Custom validation",
    type: .text,
    validation: customValidation
)
```

## SwiftUI Support

### SwiftUI Text Field Component

```swift
public struct SwiftUITextField: View {
    public let placeholder: String
    public let type: TextFieldType
    public let validation: TextFieldValidation?
    public let onTextChange: (String) -> Void
    public let onValidation: (Bool) -> Void
    
    public init(
        placeholder: String,
        type: TextFieldType = .text,
        validation: TextFieldValidation? = nil,
        onTextChange: @escaping (String) -> Void,
        onValidation: @escaping (Bool) -> Void
    )
    
    public var body: some View
}
```

### SwiftUI Usage

```swift
struct ContentView: View {
    @State private var email = ""
    @State private var isEmailValid = false
    
    var body: some View {
        VStack(spacing: 20) {
            SwiftUITextField(
                placeholder: "Enter email",
                type: .email,
                validation: TextFieldValidation(
                    required: true,
                    pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                ),
                onTextChange: { text in
                    email = text
                },
                onValidation: { isValid in
                    isEmailValid = isValid
                }
            )
            
            if !isEmailValid && !email.isEmpty {
                Text("Please enter a valid email address")
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
        .padding()
    }
}
```

## Error Handling

### Text Field Errors

```swift
public enum TextFieldError: Error {
    case invalidConfiguration
    case validationFailed
    case accessibilitySetupFailed
    case formattingFailed
    case typeNotFound
}

// Handle errors
do {
    try emailTextField.configure(textFieldConfig)
} catch TextFieldError.invalidConfiguration {
    print("Invalid text field configuration")
} catch {
    print("Text field configuration failed: \(error)")
}
```

## Performance Considerations

### Memory Management

- Text fields are automatically deallocated when not in use
- Validation patterns are cached for performance
- Auto-completion suggestions are managed efficiently

### Rendering Performance

- Efficient text rendering with Core Text
- Optimized validation calculations
- Smooth animations for focus states

## Best Practices

### Text Field Design

1. **Clear Labels**: Use descriptive placeholders and labels
2. **Appropriate Keyboard**: Set the correct keyboard type for the input
3. **Validation Feedback**: Provide immediate feedback for validation errors
4. **Accessibility**: Always include proper accessibility labels
5. **Visual States**: Clearly indicate focus, error, and success states

### Code Organization

1. **Configuration**: Use configuration objects for complex setups
2. **Validation**: Create reusable validation rules
3. **Styling**: Use consistent styling across all text fields
4. **Testing**: Test all text field states and interactions

## Migration Guide

### From UITextField

```swift
// Old UITextField approach
let oldTextField = UITextField()
oldTextField.placeholder = "Old Text Field"
oldTextField.borderStyle = .roundedRect
oldTextField.keyboardType = .emailAddress

// New CustomTextField approach
let newTextField = CustomTextField(
    placeholder: "New Text Field",
    type: .email
)
```

### From SwiftUI TextField

```swift
// Old SwiftUI approach
TextField("Old Text Field", text: $text)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .keyboardType(.emailAddress)

// New SwiftUITextField approach
SwiftUITextField(
    placeholder: "New Text Field",
    type: .email,
    onTextChange: { text in
        // handle text change
    },
    onValidation: { isValid in
        // handle validation
    }
)
```

## Version History

### Version 1.0.0
- Initial release with basic text field functionality
- Support for common text field types
- Basic validation support

### Version 1.1.0
- Added custom validation support
- Enhanced accessibility features
- Improved styling options

### Version 1.2.0
- Added auto-completion support
- Enhanced SwiftUI integration
- Performance optimizations

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
