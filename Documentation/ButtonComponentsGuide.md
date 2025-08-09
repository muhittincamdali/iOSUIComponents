# Button Components Guide

## Overview

The Button Components Guide provides comprehensive information about using button components in iOS UI Components. This guide covers button creation, styling, interactions, accessibility, and best practices.

## Getting Started

### Basic Button Creation

```swift
// Create a basic button
let basicButton = CustomButton(
    title: "Tap Me",
    style: .primary,
    size: .medium
)

// Add to view
view.addSubview(basicButton)

// Handle tap action
basicButton.onTap {
    print("Button tapped!")
}
```

### Button Configuration

```swift
// Configure button
let button = CustomButton(title: "Configured Button")

button.configure { config in
    config.enableCustomStyles = true
    config.enableAnimations = true
    config.enableAccessibility = true
    config.enableHapticFeedback = true
}

// Style the button
button.setBackgroundColor(.systemBlue)
button.setTextColor(.white)
button.setCornerRadius(12)
button.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 2), radius: 4)
```

## Button Styles

### Primary Button

```swift
let primaryButton = CustomButton(
    title: "Primary Action",
    style: .primary,
    size: .large
)

// Configure primary button
primaryButton.configure { config in
    config.backgroundColor = .systemBlue
    config.textColor = .white
    config.cornerRadius = 12
    config.shadowEnabled = true
}
```

### Secondary Button

```swift
let secondaryButton = CustomButton(
    title: "Secondary Action",
    style: .secondary,
    size: .medium
)

// Configure secondary button
secondaryButton.configure { config in
    config.backgroundColor = .systemGray5
    config.textColor = .systemBlue
    config.cornerRadius = 8
    config.borderEnabled = true
    config.borderColor = .systemBlue
    config.borderWidth = 1
}
```

### Outline Button

```swift
let outlineButton = CustomButton(
    title: "Outline Style",
    style: .outline,
    size: .medium
)

// Configure outline button
outlineButton.configure { config in
    config.backgroundColor = .clear
    config.textColor = .systemBlue
    config.cornerRadius = 8
    config.borderEnabled = true
    config.borderColor = .systemBlue
    config.borderWidth = 2
}
```

### Danger Button

```swift
let dangerButton = CustomButton(
    title: "Delete",
    style: .danger,
    size: .medium
)

// Configure danger button
dangerButton.configure { config in
    config.backgroundColor = .systemRed
    config.textColor = .white
    config.cornerRadius = 8
    config.shadowEnabled = true
}
```

## Button Sizes

### Small Button

```swift
let smallButton = CustomButton(
    title: "Small",
    style: .primary,
    size: .small
)

// Configure small button
smallButton.configure { config in
    config.height = 32
    config.fontSize = 14
    config.padding = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
}
```

### Medium Button

```swift
let mediumButton = CustomButton(
    title: "Medium",
    style: .primary,
    size: .medium
)

// Configure medium button
mediumButton.configure { config in
    config.height = 44
    config.fontSize = 16
    config.padding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
}
```

### Large Button

```swift
let largeButton = CustomButton(
    title: "Large",
    style: .primary,
    size: .large
)

// Configure large button
largeButton.configure { config in
    config.height = 56
    config.fontSize = 18
    config.padding = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
}
```

## Button Interactions

### Tap Action

```swift
let button = CustomButton(title: "Tap Me")

// Handle tap
button.onTap {
    print("Button tapped!")
    // Perform action
    submitForm()
}
```

### Long Press Action

```swift
let button = CustomButton(title: "Long Press Me")

// Handle long press
button.onLongPress {
    print("Button long pressed!")
    // Show context menu
    showContextMenu()
}
```

### State Changes

```swift
let button = CustomButton(title: "State Button")

// Handle state changes
button.onStateChange { state in
    switch state {
    case .normal:
        print("Button is normal")
    case .highlighted:
        print("Button is highlighted")
    case .disabled:
        print("Button is disabled")
    }
}
```

## Button Animations

### Tap Animation

```swift
let button = CustomButton(title: "Animated Button")

// Configure animations
button.configure { config in
    config.enableAnimations = true
    config.tapAnimation = .scale
    config.animationDuration = 0.2
}

// Handle tap with animation
button.onTap {
    button.animateTap()
    // Perform action after animation
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        performAction()
    }
}
```

### Loading Animation

```swift
let button = CustomButton(title: "Loading Button")

// Show loading state
button.isLoading = true
button.setTitle("Loading...", for: .normal)

// Simulate API call
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    button.isLoading = false
    button.setTitle("Complete", for: .normal)
    button.animateSuccess()
}
```

### Success Animation

```swift
let button = CustomButton(title: "Submit")

button.onTap {
    button.animateLoading()
    
    // Simulate API call
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        button.animateSuccess()
        button.setTitle("Success!", for: .normal)
    }
}
```

## Button Accessibility

### VoiceOver Support

```swift
let button = CustomButton(title: "Accessible Button")

// Configure accessibility
button.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
button.accessibilityLabel = "Submit Form Button"
button.accessibilityHint = "Double tap to submit the form"
button.accessibilityTraits = .button
button.accessibilityValue = "Form submission button"
```

### Dynamic Type Support

```swift
let button = CustomButton(title: "Dynamic Type Button")

// Support dynamic type
button.configure { config in
    config.enableDynamicType = true
    config.textStyle = .body
}
```

### High Contrast Support

```swift
let button = CustomButton(title: "High Contrast Button")

// Support high contrast
button.configure { config in
    config.enableHighContrast = true
}
```

## SwiftUI Support

### SwiftUI Button

```swift
public struct SwiftUIButton: View {
    public let title: String
    public let style: ButtonStyle
    public let size: ButtonSize
    public let action: () -> Void
    
    public init(
        title: String,
        style: ButtonStyle = .primary,
        size: ButtonSize = .medium,
        action: @escaping () -> Void
    )
    
    public var body: some View
}
```

### SwiftUI Usage

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

## Best Practices

### Button Design

1. **Clear Purpose**: Ensure button purpose is immediately clear
2. **Consistent Styling**: Maintain consistent button styles across app
3. **Adequate Size**: Make buttons at least 44x44 points for touch targets
4. **Visual Feedback**: Provide clear visual feedback for interactions
5. **Accessibility**: Always include proper accessibility labels

### Button States

1. **Normal State**: Default appearance
2. **Highlighted State**: When user touches button
3. **Disabled State**: When button is not interactive
4. **Loading State**: When button is processing
5. **Success State**: When action completes successfully

### Button Interactions

1. **Tap**: Primary interaction
2. **Long Press**: Secondary interaction
3. **Haptic Feedback**: Provide tactile feedback
4. **Visual Feedback**: Show state changes
5. **Accessibility**: Support VoiceOver and other assistive technologies

## Common Patterns

### Form Submission Button

```swift
let submitButton = CustomButton(
    title: "Submit",
    style: .primary,
    size: .large
)

submitButton.configure { config in
    config.enableLoadingStates = true
    config.enableHapticFeedback = true
    config.enableAccessibility = true
}

submitButton.onTap {
    submitButton.isLoading = true
    submitButton.setTitle("Submitting...", for: .normal)
    
    // Submit form
    submitForm { success in
        DispatchQueue.main.async {
            submitButton.isLoading = false
            if success {
                submitButton.animateSuccess()
                submitButton.setTitle("Success!", for: .normal)
            } else {
                submitButton.animateError()
                submitButton.setTitle("Try Again", for: .normal)
            }
        }
    }
}
```

### Navigation Button

```swift
let backButton = CustomButton(
    title: "Back",
    style: .secondary,
    size: .medium
)

backButton.configure { config in
    config.enableHapticFeedback = true
    config.enableAccessibility = true
}

backButton.onTap {
    navigationController?.popViewController(animated: true)
}
```

### Action Button

```swift
let actionButton = CustomButton(
    title: "Share",
    style: .outline,
    size: .medium
)

actionButton.configure { config in
    config.enableAnimations = true
    config.enableHapticFeedback = true
}

actionButton.onTap {
    actionButton.animateTap()
    shareContent()
}
```

## Error Handling

### Button Errors

```swift
public enum ButtonError: Error {
    case invalidConfiguration
    case animationFailed
    case accessibilitySetupFailed
    case styleNotFound
    case sizeNotFound
}

// Handle button errors
do {
    try button.configure(buttonConfig)
} catch ButtonError.invalidConfiguration {
    print("Invalid button configuration")
} catch {
    print("Button configuration failed: \(error)")
}
```

## Performance Considerations

### Button Performance

```swift
// Optimize button performance
let performanceConfig = ButtonPerformanceConfiguration()
performanceConfig.enableCaching = true
performanceConfig.enableLazyLoading = true
performanceConfig.enableOptimizedRendering = true

button.configurePerformance(performanceConfig)
```

## Migration Guide

### From UIButton

```swift
// Old UIButton approach
let oldButton = UIButton(type: .system)
oldButton.setTitle("Old Button", for: .normal)
oldButton.backgroundColor = .systemBlue
oldButton.layer.cornerRadius = 8

// New CustomButton approach
let newButton = CustomButton(
    title: "New Button",
    style: .primary,
    size: .medium
)
```

### From SwiftUI Button

```swift
// Old SwiftUI approach
Button("Old Button") {
    // action
}
.buttonStyle(.borderedProminent)

// New SwiftUIButton approach
SwiftUIButton(
    title: "New Button",
    style: .primary,
    size: .medium
) {
    // action
}
```

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
