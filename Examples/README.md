# Examples

This directory contains comprehensive examples demonstrating how to use iOS UI Components in your applications.

## 📁 Directory Structure

```
Examples/
├── README.md                    # This file
├── BasicExample/               # Basic usage examples
│   └── BasicExample.swift      # Basic component examples
├── AdvancedExample/            # Advanced usage examples
│   └── AdvancedExample.swift   # Advanced component examples
├── IntegrationExample/         # Integration examples
│   └── IntegrationExample.swift # Integration examples
├── CustomizationExample/       # Customization examples
│   └── CustomizationExample.swift # Customization examples
├── AccessibilityExample/       # Accessibility examples
│   └── AccessibilityExample.swift # Accessibility examples
├── PerformanceExample/         # Performance examples
│   └── PerformanceExample.swift # Performance examples
└── SecurityExample/            # Security examples
    └── SecurityExample.swift   # Security examples
```

## 🚀 Getting Started

### Basic Examples

The `BasicExample` directory contains fundamental examples showing how to use each component:

- **Button Components**: Custom buttons with various styles
- **Text Field Components**: Advanced text input components
- **Card Components**: Beautiful card layouts
- **Navigation Components**: Custom navigation bars
- **Form Components**: Complete form implementations
- **Theming Examples**: Theme customization

### Running Examples

1. **Clone the repository**:
   ```bash
   git clone https://github.com/muhittincamdali/iOSUIComponents.git
   cd iOSUIComponents
   ```

2. **Open in Xcode**:
   ```bash
   open Package.swift
   ```

3. **Navigate to Examples**:
   - Open the Examples directory in Xcode
   - Select the example you want to run
   - Build and run the project

## 📱 Example Categories

### Button Examples

```swift
// Basic button usage
let primaryButton = CustomButton(
    title: "Get Started",
    style: .primary,
    size: .large
)

// Button with custom styling
let customButton = CustomButton(
    title: "Custom Style",
    style: .custom(customStyle),
    size: .medium
)

// Button with loading state
let loadingButton = CustomButton(
    title: "Submit",
    style: .primary,
    size: .medium
)
loadingButton.isLoading = true
```

### Text Field Examples

```swift
// Basic text field
let nameField = CustomTextField(
    placeholder: "Enter your name",
    type: .text
)

// Email field with validation
let emailField = CustomTextField(
    placeholder: "Enter your email",
    type: .email,
    validation: emailValidation
)

// Password field with security
let passwordField = CustomTextField(
    placeholder: "Enter your password",
    type: .password,
    validation: passwordValidation
)
passwordField.setSecureEntry(true)
```

### Card Examples

```swift
// Basic card
let basicCard = CustomCard(
    title: "Welcome",
    subtitle: "Get started with our app",
    content: "This is a basic card example.",
    style: .default,
    layout: .vertical
)

// Product card
let productCard = CustomCard(
    title: "iPhone 15 Pro",
    subtitle: "$999",
    content: "Latest Apple smartphone with advanced features.",
    image: UIImage(named: "iphone_image"),
    style: .product,
    layout: .vertical
)

// Info card
let infoCard = CustomCard(
    title: "Information",
    content: "This is an informational card.",
    style: .info,
    layout: .horizontal
)
```

### Navigation Examples

```swift
// Basic navigation bar
let navigationBar = CustomNavigationBar(
    title: "Home",
    style: .default
)

// Navigation bar with buttons
let navBar = CustomNavigationBar(
    title: "Navigation",
    style: .default
)

let backButton = CustomButton(title: "Back", style: .secondary)
let menuButton = CustomButton(title: "Menu", style: .secondary)

navBar.setLeftButton(backButton)
navBar.setRightButton(menuButton)
```

### Form Examples

```swift
// Basic form
let form = CustomForm(
    fields: [
        FormField(id: "name", type: .text, label: "Name", isRequired: true),
        FormField(id: "email", type: .email, label: "Email", isRequired: true),
        FormField(id: "password", type: .password, label: "Password", isRequired: true)
    ]
)

// Form with validation
form.onSubmit { formData in
    print("Form submitted: \(formData)")
    submitFormData(formData)
}

form.onValidation { isValid in
    print("Form validation: \(isValid)")
}
```

### Theming Examples

```swift
// Apply basic theme
let basicTheme = CustomTheme(
    name: "Basic Theme",
    colors: ThemeColors(
        primary: .systemBlue,
        secondary: .systemGray,
        background: .systemBackground,
        text: .label
    )
)

ThemeManager.shared.applyTheme(basicTheme)

// Apply dark theme
let darkTheme = CustomTheme(
    name: "Dark Theme",
    colors: ThemeColors(
        primary: .systemBlue,
        secondary: .systemGray,
        background: .black,
        text: .white
    )
)

ThemeManager.shared.applyTheme(darkTheme)
```

## 🎨 Customization Examples

### Custom Button Styles

```swift
// Create custom button style
let customButtonStyle = ButtonCustomStyle(
    backgroundColor: .systemPurple,
    textColor: .white,
    borderColor: .systemPurple,
    borderWidth: 2,
    cornerRadius: 20,
    shadowEnabled: true,
    shadowColor: .systemPurple,
    shadowOffset: CGSize(width: 0, height: 4),
    shadowRadius: 8,
    shadowOpacity: 0.3
)

let customButton = CustomButton(
    title: "Custom Style",
    style: .custom(customButtonStyle),
    size: .medium
)
```

### Custom Card Layouts

```swift
// Create custom card layout
let customLayout = CardCustomLayout(
    imagePosition: .left,
    textAlignment: .left,
    spacing: 16,
    padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
)

let customCard = CustomCard(
    title: "Custom Layout",
    content: "This card uses a custom layout.",
    style: .custom,
    layout: .custom(customLayout)
)
```

## ♿ Accessibility Examples

### VoiceOver Support

```swift
// Configure accessibility for button
let accessibleButton = CustomButton(
    title: "Accessible Button",
    style: .primary
)

accessibleButton.configure { config in
    config.enableAccessibility = true
}

accessibleButton.accessibilityLabel = "Submit Form Button"
accessibleButton.accessibilityHint = "Double tap to submit the form"
accessibleButton.accessibilityTraits = .button
```

### Dynamic Type Support

```swift
// Configure dynamic type for text field
let dynamicTextField = CustomTextField(
    placeholder: "Dynamic Type Field",
    type: .text
)

dynamicTextField.configure { config in
    config.enableDynamicType = true
    config.textStyle = .body
}
```

## 🔧 Configuration Examples

### Component Configuration

```swift
// Configure UI components manager
let manager = UIComponentsManager.shared

let config = UIComponentsConfiguration()
config.enableSwiftUI = true
config.enableUIKit = true
config.enableAccessibility = true
config.enableCustomization = true
config.enableTheming = true
config.enableAnimations = true

manager.start(with: config)
```

### Theme Configuration

```swift
// Configure theme manager
let themeManager = ThemeManager.shared

let themeConfig = ThemeConfiguration()
themeConfig.enableDynamicColors = true
themeConfig.enableDarkMode = true
themeConfig.enableCustomThemes = true
themeConfig.enableColorSchemes = true

themeManager.configure(themeConfig)
```

## 📱 SwiftUI Examples

### SwiftUI Button

```swift
struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            SwiftUIButton(
                title: "Primary Button",
                style: .primary,
                size: .large
            ) {
                print("Primary button tapped")
            }
            
            SwiftUIButton(
                title: "Secondary Button",
                style: .secondary,
                size: .medium
            ) {
                print("Secondary button tapped")
            }
        }
        .padding()
    }
}
```

### SwiftUI Text Field

```swift
struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        SwiftUITextField(
            placeholder: "Enter text",
            type: .text,
            onTextChange: { newText in
                text = newText
            },
            onValidation: { isValid in
                print("Validation: \(isValid)")
            }
        )
        .padding()
    }
}
```

### SwiftUI Card

```swift
struct ContentView: View {
    var body: some View {
        SwiftUICard(
            title: "SwiftUI Card",
            subtitle: "Modern card component",
            content: "This is a SwiftUI card with beautiful styling.",
            style: .elevated,
            layout: .vertical
        ) {
            print("SwiftUI card tapped")
        }
    }
}
```

## 🧪 Testing Examples

### Unit Tests

```swift
import XCTest
@testable import iOSUIComponents

class ButtonComponentsTests: XCTestCase {
    
    func testButtonCreation() {
        let button = CustomButton(
            title: "Test Button",
            style: .primary,
            size: .medium
        )
        
        XCTAssertEqual(button.title, "Test Button")
        XCTAssertEqual(button.style, .primary)
        XCTAssertEqual(button.size, .medium)
    }
    
    func testButtonTap() {
        let button = CustomButton(title: "Test")
        var tapped = false
        
        button.onTap {
            tapped = true
        }
        
        button.sendActions(for: .touchUpInside)
        XCTAssertTrue(tapped)
    }
}
```

### Integration Tests

```swift
import XCTest
@testable import iOSUIComponents

class FormIntegrationTests: XCTestCase {
    
    func testFormSubmission() {
        let form = CustomForm(
            fields: [
                FormField(id: "name", type: .text, label: "Name", isRequired: true),
                FormField(id: "email", type: .email, label: "Email", isRequired: true)
            ]
        )
        
        var submitted = false
        form.onSubmit { formData in
            submitted = true
            XCTAssertEqual(formData["name"] as? String, "John")
            XCTAssertEqual(formData["email"] as? String, "john@example.com")
        }
        
        // Simulate form submission
        form.submit()
        XCTAssertTrue(submitted)
    }
}
```

## 📚 Documentation

For more detailed information about each component, please refer to:

- [API Documentation](Documentation/)
- [Getting Started Guide](Documentation/GettingStarted.md)
- [Component Guide](Documentation/ComponentGuide.md)
- [Customization Guide](Documentation/Customization.md)
- [Accessibility Guide](Documentation/AccessibilityGuide.md)
- [Theming Guide](Documentation/ThemingGuide.md)

## 🤝 Contributing

We welcome contributions! If you'd like to add new examples or improve existing ones:

1. Fork the repository
2. Create a feature branch
3. Add your examples
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

## 🙏 Acknowledgments

- **Apple** for the excellent iOS development platform
- **The Swift Community** for inspiration and feedback
- **All Contributors** who help improve this framework
- **UI/UX Community** for best practices and standards 