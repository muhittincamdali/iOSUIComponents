# Text Field Components Guide

## Overview

The Text Field Components Guide provides comprehensive information about using text field components in iOS UI Components. This guide covers text field creation, validation, styling, accessibility, and best practices.

## Getting Started

### Basic Text Field Creation

```swift
// Create a basic text field
let textField = CustomTextField(
    placeholder: "Enter text",
    type: .text
)

// Add to view
view.addSubview(textField)

// Handle text changes
textField.onTextChange { text in
    print("Text changed: \(text)")
}
```

### Text Field Configuration

```swift
// Configure text field
let textField = CustomTextField(placeholder: "Configured Field")

textField.configure { config in
    config.enableValidation = true
    config.enableAutoComplete = true
    config.enableAccessibility = true
    config.enableClearButton = true
}

// Style the text field
textField.setBackgroundColor(.systemBackground)
textField.setBorderColor(.systemGray4, for: .normal)
textField.setBorderColor(.systemBlue, for: .focused)
textField.setCornerRadius(8)
```

## Text Field Types

### Text Input

```swift
let textField = CustomTextField(
    placeholder: "Enter your name",
    type: .text
)

textField.configure { config in
    config.keyboardType = .default
    config.autocapitalizationType = .words
    config.autocorrectionType = .yes
}
```

### Email Input

```swift
let emailField = CustomTextField(
    placeholder: "Enter your email",
    type: .email
)

// Configure email validation
let emailValidation = TextFieldValidation(
    required: true,
    pattern: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
)

emailField.setValidation(emailValidation)

emailField.onValidation { isValid in
    if isValid {
        print("Email is valid")
    } else {
        print("Please enter a valid email")
    }
}
```

### Password Input

```swift
let passwordField = CustomTextField(
    placeholder: "Enter your password",
    type: .password
)

// Configure password validation
let passwordValidation = TextFieldValidation(
    required: true,
    minimumLength: 8,
    pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$"
)

passwordField.setValidation(passwordValidation)
passwordField.setSecureEntry(true)

passwordField.onValidation { isValid in
    if isValid {
        print("Password is valid")
    } else {
        print("Password must be at least 8 characters with letters and numbers")
    }
}
```

### Number Input

```swift
let numberField = CustomTextField(
    placeholder: "Enter number",
    type: .number
)

numberField.configure { config in
    config.keyboardType = .numberPad
    config.enableFormatting = true
}

// Format number input
numberField.onTextChange { text in
    let formatted = formatNumber(text)
    if formatted != text {
        numberField.setText(formatted)
    }
}
```

### Phone Input

```swift
let phoneField = CustomTextField(
    placeholder: "Enter phone number",
    type: .phone
)

phoneField.configure { config in
    config.keyboardType = .phonePad
    config.enableFormatting = true
}

// Format phone number
phoneField.onTextChange { text in
    let formatted = formatPhoneNumber(text)
    if formatted != text {
        phoneField.setText(formatted)
    }
}
```

## Text Field Validation

### Required Field Validation

```swift
let requiredField = CustomTextField(
    placeholder: "Required field",
    type: .text
)

let requiredValidation = TextFieldValidation(required: true)
requiredField.setValidation(requiredValidation)

requiredField.onValidation { isValid in
    if !isValid {
        requiredField.showError("This field is required")
    } else {
        requiredField.clearError()
    }
}
```

### Length Validation

```swift
let lengthField = CustomTextField(
    placeholder: "Enter text (5-20 characters)",
    type: .text
)

let lengthValidation = TextFieldValidation(
    required: true,
    minimumLength: 5,
    maximumLength: 20
)

lengthField.setValidation(lengthValidation)
```

### Pattern Validation

```swift
let urlField = CustomTextField(
    placeholder: "Enter URL",
    type: .url
)

let urlValidation = TextFieldValidation(
    required: true,
    pattern: "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
)

urlField.setValidation(urlValidation)
```

### Custom Validation

```swift
let customField = CustomTextField(
    placeholder: "Custom validation",
    type: .text
)

let customValidation = TextFieldValidation(
    required: true,
    customValidation: { value in
        guard let text = value as? String else { return false }
        return text.count >= 5 && text.contains("@")
    }
)

customField.setValidation(customValidation)
```

## Text Field Styling

### Basic Styling

```swift
let styledField = CustomTextField(
    placeholder: "Styled field",
    type: .text
)

// Apply styling
styledField.setBackgroundColor(.systemBackground)
styledField.setBorderColor(.systemGray4, for: .normal)
styledField.setBorderColor(.systemBlue, for: .focused)
styledField.setBorderColor(.systemRed, for: .error)
styledField.setBorderWidth(1)
styledField.setCornerRadius(8)
styledField.setPadding(UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
```

### Custom Styling

```swift
let customField = CustomTextField(
    placeholder: "Custom styled field",
    type: .text
)

// Custom styling
customField.configure { config in
    config.backgroundColor = .systemGray6
    config.textColor = .label
    config.placeholderColor = .systemGray
    config.borderStyle = .roundedRect
    config.cornerRadius = 12
    config.shadowEnabled = true
    config.shadowColor = .black
    config.shadowOffset = CGSize(width: 0, height: 2)
    config.shadowRadius = 4
}
```

## Text Field Interactions

### Text Change Handling

```swift
let textField = CustomTextField(
    placeholder: "Type here",
    type: .text
)

// Handle text changes
textField.onTextChange { text in
    print("Text changed: \(text)")
    
    // Real-time validation
    if text.count > 0 {
        textField.setBorderColor(.systemGreen, for: .normal)
    } else {
        textField.setBorderColor(.systemGray4, for: .normal)
    }
}
```

### Focus Handling

```swift
let textField = CustomTextField(
    placeholder: "Focus handling",
    type: .text
)

// Handle focus events
textField.onFocus {
    print("Text field focused")
    textField.setBorderColor(.systemBlue, for: .focused)
}

textField.onBlur {
    print("Text field lost focus")
    textField.setBorderColor(.systemGray4, for: .normal)
}
```

### Validation Handling

```swift
let textField = CustomTextField(
    placeholder: "Validated field",
    type: .email
)

// Handle validation
textField.onValidation { isValid in
    if isValid {
        textField.setBorderColor(.systemGreen, for: .normal)
        textField.clearError()
    } else {
        textField.setBorderColor(.systemRed, for: .error)
        textField.showError("Please enter a valid email")
    }
}
```

## Text Field Accessibility

### VoiceOver Support

```swift
let textField = CustomTextField(
    placeholder: "Accessible field",
    type: .text
)

// Configure accessibility
textField.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
textField.accessibilityLabel = "Email Address Field"
textField.accessibilityHint = "Enter your email address"
textField.accessibilityTraits = .textField
textField.accessibilityValue = "Email input field"
```

### Dynamic Type Support

```swift
let textField = CustomTextField(
    placeholder: "Dynamic type field",
    type: .text
)

// Support dynamic type
textField.configure { config in
    config.enableDynamicType = true
    config.textStyle = .body
}
```

### High Contrast Support

```swift
let textField = CustomTextField(
    placeholder: "High contrast field",
    type: .text
)

// Support high contrast
textField.configure { config in
    config.enableHighContrast = true
}
```

## SwiftUI Support

### SwiftUI Text Field

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

## Best Practices

### Text Field Design

1. **Clear Labels**: Use descriptive placeholders and labels
2. **Appropriate Keyboard**: Set the correct keyboard type for the input
3. **Validation Feedback**: Provide immediate feedback for validation errors
4. **Accessibility**: Always include proper accessibility labels
5. **Visual States**: Clearly indicate focus, error, and success states

### Text Field Validation

1. **Real-time Validation**: Validate as user types
2. **Clear Error Messages**: Provide helpful error messages
3. **Visual Feedback**: Show validation state visually
4. **Accessibility**: Announce validation errors to VoiceOver
5. **Performance**: Optimize validation for performance

### Text Field Interactions

1. **Responsive**: Respond quickly to user input
2. **Predictable**: Behave consistently across the app
3. **Accessible**: Support all accessibility features
4. **Secure**: Handle sensitive data appropriately
5. **Formatted**: Format input appropriately

## Common Patterns

### Form Text Field

```swift
let formField = CustomTextField(
    placeholder: "Enter your name",
    type: .text
)

formField.configure { config in
    config.enableValidation = true
    config.enableAutoComplete = true
    config.enableAccessibility = true
    config.enableClearButton = true
}

formField.onTextChange { text in
    // Update form data
    updateFormData(key: "name", value: text)
}

formField.onValidation { isValid in
    // Update form validation state
    updateFormValidation(field: "name", isValid: isValid)
}
```

### Search Text Field

```swift
let searchField = CustomTextField(
    placeholder: "Search...",
    type: .search
)

searchField.configure { config in
    config.enableClearButton = true
    config.enableSearchIcon = true
    config.enableDebouncing = true
    config.debounceDelay = 0.5
}

searchField.onTextChange { text in
    // Debounced search
    performSearch(query: text)
}
```

### Password Text Field

```swift
let passwordField = CustomTextField(
    placeholder: "Enter password",
    type: .password
)

passwordField.configure { config in
    config.enableSecureEntry = true
    config.enablePasswordToggle = true
    config.enableStrengthIndicator = true
}

passwordField.onTextChange { text in
    // Check password strength
    let strength = checkPasswordStrength(text)
    updatePasswordStrengthIndicator(strength)
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

// Handle text field errors
do {
    try textField.configure(textFieldConfig)
} catch TextFieldError.invalidConfiguration {
    print("Invalid text field configuration")
} catch {
    print("Text field configuration failed: \(error)")
}
```

## Performance Considerations

### Text Field Performance

```swift
// Optimize text field performance
let performanceConfig = TextFieldPerformanceConfiguration()
performanceConfig.enableCaching = true
performanceConfig.enableLazyLoading = true
performanceConfig.enableOptimizedRendering = true

textField.configurePerformance(performanceConfig)
```

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

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
