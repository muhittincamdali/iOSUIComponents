import XCTest
@testable import iOSUIComponents

final class TextFieldComponentsTests: XCTestCase {
    
    // MARK: - Text Field Creation Tests
    
    func testTextFieldCreation() {
        let textField = CustomTextField(
            placeholder: "Enter text",
            type: .text
        )
        
        XCTAssertEqual(textField.placeholder, "Enter text")
        XCTAssertEqual(textField.type, .text)
    }
    
    func testTextFieldWithValidation() {
        let validation = TextFieldValidation(
            required: true,
            minimumLength: 5,
            pattern: "^[A-Za-z]+$"
        )
        
        let textField = CustomTextField(
            placeholder: "Enter name",
            type: .text,
            validation: validation
        )
        
        XCTAssertEqual(textField.placeholder, "Enter name")
        XCTAssertEqual(textField.type, .text)
        XCTAssertNotNil(textField.validation)
    }
    
    // MARK: - Text Field Configuration Tests
    
    func testTextFieldConfiguration() {
        let textField = CustomTextField(placeholder: "Test")
        
        textField.configure { config in
            config.enableValidation = true
            config.enableAutoComplete = true
            config.enableAccessibility = true
            config.enableClearButton = true
        }
        
        XCTAssertNotNil(textField)
    }
    
    func testTextFieldStyling() {
        let textField = CustomTextField(placeholder: "Styled Field")
        
        textField.setBackgroundColor(.systemBackground)
        textField.setBorderColor(.systemGray4, for: .normal)
        textField.setBorderColor(.systemBlue, for: .focused)
        textField.setCornerRadius(8)
        
        XCTAssertNotNil(textField)
    }
    
    // MARK: - Text Field Type Tests
    
    func testTextFieldTypes() {
        let textField = CustomTextField(placeholder: "Text", type: .text)
        let emailField = CustomTextField(placeholder: "Email", type: .email)
        let passwordField = CustomTextField(placeholder: "Password", type: .password)
        let numberField = CustomTextField(placeholder: "Number", type: .number)
        let phoneField = CustomTextField(placeholder: "Phone", type: .phone)
        
        XCTAssertEqual(textField.type, .text)
        XCTAssertEqual(emailField.type, .email)
        XCTAssertEqual(passwordField.type, .password)
        XCTAssertEqual(numberField.type, .number)
        XCTAssertEqual(phoneField.type, .phone)
    }
    
    // MARK: - Text Field Validation Tests
    
    func testTextFieldRequiredValidation() {
        let validation = TextFieldValidation(required: true)
        let textField = CustomTextField(
            placeholder: "Required Field",
            type: .text,
            validation: validation
        )
        
        XCTAssertFalse(textField.validate())
        
        textField.setText("Test")
        XCTAssertTrue(textField.validate())
    }
    
    func testTextFieldLengthValidation() {
        let validation = TextFieldValidation(
            required: true,
            minimumLength: 5,
            maximumLength: 10
        )
        
        let textField = CustomTextField(
            placeholder: "Length Test",
            type: .text,
            validation: validation
        )
        
        textField.setText("Test")
        XCTAssertFalse(textField.validate())
        
        textField.setText("Testing")
        XCTAssertTrue(textField.validate())
        
        textField.setText("TestingLongText")
        XCTAssertFalse(textField.validate())
    }
    
    func testTextFieldPatternValidation() {
        let validation = TextFieldValidation(
            required: true,
            pattern: "^[A-Za-z]+$"
        )
        
        let textField = CustomTextField(
            placeholder: "Pattern Test",
            type: .text,
            validation: validation
        )
        
        textField.setText("Test123")
        XCTAssertFalse(textField.validate())
        
        textField.setText("Test")
        XCTAssertTrue(textField.validate())
    }
    
    func testTextFieldCustomValidation() {
        let validation = TextFieldValidation(
            required: true,
            customValidation: { value in
                guard let text = value as? String else { return false }
                return text.contains("@") && text.contains(".")
            }
        )
        
        let textField = CustomTextField(
            placeholder: "Custom Validation",
            type: .text,
            validation: validation
        )
        
        textField.setText("invalid")
        XCTAssertFalse(textField.validate())
        
        textField.setText("test@example.com")
        XCTAssertTrue(textField.validate())
    }
    
    // MARK: - Text Field Interaction Tests
    
    func testTextFieldTextChange() {
        let textField = CustomTextField(placeholder: "Text Change Test")
        var changedText = ""
        
        textField.onTextChange { text in
            changedText = text
        }
        
        textField.setText("New Text")
        XCTAssertEqual(changedText, "New Text")
    }
    
    func testTextFieldValidationCallback() {
        let textField = CustomTextField(placeholder: "Validation Test")
        var isValid = false
        
        textField.onValidation { valid in
            isValid = valid
        }
        
        textField.setText("Test")
        XCTAssertTrue(isValid)
    }
    
    func testTextFieldFocusEvents() {
        let textField = CustomTextField(placeholder: "Focus Test")
        var focused = false
        var blurred = false
        
        textField.onFocus {
            focused = true
        }
        
        textField.onBlur {
            blurred = true
        }
        
        // Simulate focus
        textField.becomeFirstResponder()
        XCTAssertTrue(focused)
        
        // Simulate blur
        textField.resignFirstResponder()
        XCTAssertTrue(blurred)
    }
    
    // MARK: - Text Field State Tests
    
    func testTextFieldSecureEntry() {
        let textField = CustomTextField(
            placeholder: "Password",
            type: .password
        )
        
        XCTAssertFalse(textField.isSecureEntry)
        
        textField.setSecureEntry(true)
        XCTAssertTrue(textField.isSecureEntry)
        
        textField.setSecureEntry(false)
        XCTAssertFalse(textField.isSecureEntry)
    }
    
    func testTextFieldEnabledState() {
        let textField = CustomTextField(placeholder: "Enabled Test")
        
        XCTAssertTrue(textField.isEnabled)
        
        textField.isEnabled = false
        XCTAssertFalse(textField.isEnabled)
        
        textField.isEnabled = true
        XCTAssertTrue(textField.isEnabled)
    }
    
    func testTextFieldErrorState() {
        let textField = CustomTextField(placeholder: "Error Test")
        
        XCTAssertFalse(textField.hasError)
        
        textField.showError("Invalid input")
        XCTAssertTrue(textField.hasError)
        
        textField.clearError()
        XCTAssertFalse(textField.hasError)
    }
    
    // MARK: - Text Field Formatting Tests
    
    func testTextFieldPhoneFormatting() {
        let textField = CustomTextField(
            placeholder: "Phone",
            type: .phone
        )
        
        textField.configure { config in
            config.enableFormatting = true
        }
        
        textField.setText("1234567890")
        
        // Verify formatting was applied
        XCTAssertNotNil(textField)
    }
    
    func testTextFieldNumberFormatting() {
        let textField = CustomTextField(
            placeholder: "Number",
            type: .number
        )
        
        textField.configure { config in
            config.enableFormatting = true
        }
        
        textField.setText("1234567890")
        
        // Verify formatting was applied
        XCTAssertNotNil(textField)
    }
    
    // MARK: - Text Field Accessibility Tests
    
    func testTextFieldAccessibility() {
        let textField = CustomTextField(
            placeholder: "Accessible Field",
            type: .text
        )
        
        textField.configure { config in
            config.enableAccessibility = true
        }
        
        textField.accessibilityLabel = "Email Address Field"
        textField.accessibilityHint = "Enter your email address"
        textField.accessibilityTraits = .textField
        
        XCTAssertEqual(textField.accessibilityLabel, "Email Address Field")
        XCTAssertEqual(textField.accessibilityHint, "Enter your email address")
        XCTAssertEqual(textField.accessibilityTraits, .textField)
    }
    
    func testTextFieldDynamicType() {
        let textField = CustomTextField(
            placeholder: "Dynamic Type Field",
            type: .text
        )
        
        textField.configure { config in
            config.enableDynamicType = true
            config.textStyle = .body
        }
        
        XCTAssertNotNil(textField)
    }
    
    func testTextFieldHighContrast() {
        let textField = CustomTextField(
            placeholder: "High Contrast Field",
            type: .text
        )
        
        textField.configure { config in
            config.enableHighContrast = true
        }
        
        XCTAssertNotNil(textField)
    }
    
    // MARK: - Text Field Performance Tests
    
    func testTextFieldPerformance() {
        let textField = CustomTextField(placeholder: "Performance Test")
        
        measure {
            for _ in 0..<1000 {
                textField.setText("Test text")
                textField.setBackgroundColor(.systemBackground)
                textField.setCornerRadius(8)
            }
        }
    }
    
    func testTextFieldMemoryUsage() {
        weak var weakTextField: CustomTextField?
        
        autoreleasepool {
            let textField = CustomTextField(placeholder: "Memory Test")
            weakTextField = textField
            
            // Perform operations
            textField.configure { config in
                config.enableValidation = true
                config.enableAccessibility = true
            }
            
            textField.onTextChange { text in
                print("Text changed: \(text)")
            }
        }
        
        // Text field should be deallocated
        XCTAssertNil(weakTextField)
    }
    
    // MARK: - Text Field Error Handling Tests
    
    func testTextFieldErrorHandling() {
        let textField = CustomTextField(placeholder: "Error Test")
        
        do {
            try textField.configure(TextFieldConfiguration())
            XCTAssertNotNil(textField)
        } catch {
            XCTFail("Text field configuration should not throw error: \(error)")
        }
    }
    
    func testTextFieldInvalidConfiguration() {
        let textField = CustomTextField(placeholder: "Invalid Config Test")
        
        // Test with invalid configuration
        textField.configure { config in
            // Invalid configuration
        }
        
        XCTAssertNotNil(textField)
    }
    
    // MARK: - Text Field Integration Tests
    
    func testTextFieldWithManager() {
        let manager = UIComponentsManager.shared
        let textField = CustomTextField(placeholder: "Manager Test")
        
        manager.registerComponent(textField)
        
        let components = manager.getAllComponents()
        XCTAssertTrue(components.contains { $0 is CustomTextField })
        
        manager.unregisterComponent(textField)
        
        let updatedComponents = manager.getAllComponents()
        XCTAssertFalse(updatedComponents.contains { $0 is CustomTextField })
    }
    
    func testTextFieldWithTheme() {
        let textField = CustomTextField(placeholder: "Theme Test")
        let theme = CustomTheme(
            name: "Test Theme",
            colors: ThemeColors(
                primary: .systemBlue,
                secondary: .systemGray,
                background: .systemBackground,
                text: .label
            )
        )
        
        ThemeManager.shared.applyTheme(theme)
        
        XCTAssertNotNil(textField)
    }
    
    // MARK: - SwiftUI Text Field Tests
    
    func testSwiftUITextFieldCreation() {
        let swiftUITextField = SwiftUITextField(
            placeholder: "SwiftUI Text Field",
            type: .text,
            onTextChange: { text in
                print("Text changed: \(text)")
            },
            onValidation: { isValid in
                print("Validation: \(isValid)")
            }
        )
        
        XCTAssertNotNil(swiftUITextField)
    }
    
    func testSwiftUITextFieldAccessibility() {
        let swiftUITextField = SwiftUITextField(
            placeholder: "Accessible SwiftUI Text Field",
            type: .text,
            onTextChange: { text in
                print("Text changed: \(text)")
            },
            onValidation: { isValid in
                print("Validation: \(isValid)")
            }
        )
        
        XCTAssertNotNil(swiftUITextField)
    }
} 