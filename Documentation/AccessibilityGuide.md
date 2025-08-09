# Accessibility Guide

## Overview

The Accessibility Guide provides comprehensive information about implementing accessibility features in iOS UI Components. This guide covers VoiceOver support, Dynamic Type, High Contrast mode, and other accessibility best practices.

## Core Accessibility Features

### VoiceOver Support

VoiceOver is Apple's screen reader that helps users with visual impairments navigate iOS applications.

```swift
// Configure VoiceOver support
let accessibilityManager = AccessibilityManager()

// Enable VoiceOver features
let voiceOverConfig = VoiceOverConfiguration()
voiceOverConfig.enableLabels = true
voiceOverConfig.enableHints = true
voiceOverConfig.enableTraits = true
voiceOverConfig.enableActions = true

accessibilityManager.configure(voiceOverConfig)
```

### Dynamic Type Support

Dynamic Type allows users to adjust text size based on their preferences.

```swift
// Support Dynamic Type
let textField = CustomTextField(placeholder: "Enter text")
textField.configure { config in
    config.enableDynamicType = true
    config.textStyle = .body
}

// Configure typography scaling
let typographyConfig = TypographyConfiguration()
typographyConfig.enableScaling = true
typographyConfig.scaleFactor = 1.2
typographyConfig.minimumScaleFactor = 0.8
typographyConfig.maximumScaleFactor = 2.0
```

### High Contrast Support

High Contrast mode provides better visibility for users with visual impairments.

```swift
// Support High Contrast
let button = CustomButton(title: "High Contrast Button")
button.configure { config in
    config.enableHighContrast = true
}

// Configure high contrast colors
let highContrastColors = HighContrastColors(
    primary: .white,
    secondary: .black,
    background: .black,
    text: .white,
    border: .white
)
```

## Implementation Examples

### Button Accessibility

```swift
// Create accessible button
let accessibleButton = CustomButton(
    title: "Submit Form",
    style: .primary
)

// Configure accessibility
accessibleButton.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
accessibleButton.accessibilityLabel = "Submit Form Button"
accessibleButton.accessibilityHint = "Double tap to submit the form"
accessibleButton.accessibilityTraits = .button
accessibleButton.accessibilityValue = "Form submission button"

// Add custom accessibility action
accessibleButton.addAccessibilityAction(
    name: "Submit",
    action: {
        print("Form submitted via accessibility action")
    }
)
```

### Text Field Accessibility

```swift
// Create accessible text field
let accessibleTextField = CustomTextField(
    placeholder: "Enter your email",
    type: .email
)

// Configure accessibility
accessibleTextField.configure { config in
    config.enableAccessibility = true
    config.enableDynamicType = true
}

// Set accessibility properties
accessibleTextField.accessibilityLabel = "Email Address Field"
accessibleTextField.accessibilityHint = "Enter your email address"
accessibleTextField.accessibilityTraits = .textField
accessibleTextField.accessibilityValue = "Email input field"

// Support keyboard navigation
accessibleTextField.accessibilityTraits.insert(.keyboardKey)
```

### Card Accessibility

```swift
// Create accessible card
let accessibleCard = CustomCard(
    title: "Product Information",
    content: "This is a product card with detailed information."
)

// Configure accessibility
accessibleCard.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
accessibleCard.accessibilityLabel = "Product Information Card"
accessibleCard.accessibilityHint = "Double tap to view product details"
accessibleCard.accessibilityTraits = .button

// Add accessibility elements
accessibleCard.accessibilityElements = [
    accessibleCard.titleLabel,
    accessibleCard.contentLabel
]
```

## SwiftUI Accessibility

### SwiftUI Accessibility Support

```swift
public struct SwiftUIAccessibleButton: View {
    public let title: String
    public let action: () -> Void
    public let accessibilityLabel: String
    public let accessibilityHint: String
    
    public init(
        title: String,
        action: @escaping () -> Void,
        accessibilityLabel: String,
        accessibilityHint: String
    )
    
    public var body: some View
}
```

### SwiftUI Usage

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            SwiftUIAccessibleButton(
                title: "Accessible Button",
                action: {
                    print("Button tapped")
                },
                accessibilityLabel: "Accessible Button",
                accessibilityHint: "Double tap to perform action"
            )
            .accessibilityLabel("Accessible Button")
            .accessibilityHint("Double tap to perform action")
            .accessibilityAddTraits(.isButton)
        }
    }
}
```

## Best Practices

### General Accessibility Guidelines

1. **Clear Labels**: Always provide clear, descriptive labels
2. **Meaningful Hints**: Give helpful hints for complex interactions
3. **Logical Order**: Ensure logical navigation order
4. **Sufficient Contrast**: Maintain adequate color contrast
5. **Touch Targets**: Make touch targets at least 44x44 points

### VoiceOver Best Practices

1. **Descriptive Labels**: Use descriptive, action-oriented labels
2. **Contextual Hints**: Provide context for complex interactions
3. **State Information**: Announce state changes clearly
4. **Navigation**: Ensure logical navigation flow
5. **Custom Actions**: Add custom actions for complex interactions

### Dynamic Type Best Practices

1. **Scalable Fonts**: Use system fonts that scale properly
2. **Adequate Spacing**: Ensure sufficient spacing for larger text
3. **Layout Flexibility**: Design layouts that accommodate larger text
4. **Minimum Sizes**: Set appropriate minimum text sizes
5. **Testing**: Test with different text size preferences

### High Contrast Best Practices

1. **Sufficient Contrast**: Ensure adequate contrast ratios
2. **Color Independence**: Don't rely solely on color for information
3. **Border Support**: Use borders to define boundaries
4. **Icon Support**: Provide text alternatives for icons
5. **Testing**: Test in High Contrast mode

## Testing Accessibility

### VoiceOver Testing

```swift
// Test VoiceOver functionality
func testVoiceOverAccessibility() {
    let button = CustomButton(title: "Test Button")
    
    // Verify accessibility properties
    XCTAssertEqual(button.accessibilityLabel, "Test Button")
    XCTAssertEqual(button.accessibilityTraits, .button)
    XCTAssertTrue(button.isAccessibilityElement)
}
```

### Dynamic Type Testing

```swift
// Test Dynamic Type support
func testDynamicTypeSupport() {
    let textField = CustomTextField(placeholder: "Test")
    
    // Verify Dynamic Type configuration
    XCTAssertTrue(textField.configuration.enableDynamicType)
    XCTAssertEqual(textField.configuration.textStyle, .body)
}
```

### High Contrast Testing

```swift
// Test High Contrast support
func testHighContrastSupport() {
    let card = CustomCard(title: "Test Card")
    
    // Verify High Contrast configuration
    XCTAssertTrue(card.configuration.enableHighContrast)
    XCTAssertNotNil(card.highContrastColors)
}
```

## Common Accessibility Issues

### Missing Labels

```swift
// ❌ Bad: Missing accessibility label
let button = UIButton()
button.setTitle("Submit", for: .normal)

// ✅ Good: Proper accessibility label
let button = CustomButton(title: "Submit")
button.accessibilityLabel = "Submit Form Button"
button.accessibilityHint = "Double tap to submit the form"
```

### Insufficient Contrast

```swift
// ❌ Bad: Low contrast colors
button.backgroundColor = .lightGray
button.setTitleColor(.white, for: .normal)

// ✅ Good: High contrast colors
button.backgroundColor = .systemBlue
button.setTitleColor(.white, for: .normal)
```

### Small Touch Targets

```swift
// ❌ Bad: Small touch target
button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

// ✅ Good: Adequate touch target
button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
```

## Accessibility Configuration

### Global Accessibility Settings

```swift
// Configure global accessibility
let globalAccessibilityConfig = GlobalAccessibilityConfiguration()
globalAccessibilityConfig.enableVoiceOver = true
globalAccessibilityConfig.enableDynamicType = true
globalAccessibilityConfig.enableHighContrast = true
globalAccessibilityConfig.enableReducedMotion = true

AccessibilityManager.shared.configure(globalAccessibilityConfig)
```

### Component-Specific Accessibility

```swift
// Configure component accessibility
let componentAccessibilityConfig = ComponentAccessibilityConfiguration()
componentAccessibilityConfig.enableLabels = true
componentAccessibilityConfig.enableHints = true
componentAccessibilityConfig.enableTraits = true
componentAccessibilityConfig.enableActions = true

component.configureAccessibility(componentAccessibilityConfig)
```

## Error Handling

### Accessibility Errors

```swift
public enum AccessibilityError: Error {
    case invalidConfiguration
    case voiceOverSetupFailed
    case dynamicTypeSetupFailed
    case highContrastSetupFailed
    case reducedMotionSetupFailed
}

// Handle accessibility errors
do {
    try accessibilityManager.configure(accessibilityConfig)
} catch AccessibilityError.invalidConfiguration {
    print("Invalid accessibility configuration")
} catch {
    print("Accessibility setup failed: \(error)")
}
```

## Performance Considerations

### Accessibility Performance

```swift
// Optimize accessibility performance
let performanceConfig = AccessibilityPerformanceConfiguration()
performanceConfig.enableCaching = true
performanceConfig.enableLazyLoading = true
performanceConfig.enableOptimizedRendering = true

accessibilityManager.configurePerformance(performanceConfig)
```

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
