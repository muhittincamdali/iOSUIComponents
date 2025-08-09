# Button Components API

<!-- TOC START -->
## Table of Contents
- [Button Components API](#button-components-api)
- [Overview](#overview)
- [Core Components](#core-components)
  - [CustomButton](#custombutton)
  - [ButtonStyle](#buttonstyle)
  - [ButtonSize](#buttonsize)
- [Configuration](#configuration)
  - [ButtonConfiguration](#buttonconfiguration)
- [Usage Examples](#usage-examples)
  - [Basic Button Creation](#basic-button-creation)
  - [Advanced Button with Loading State](#advanced-button-with-loading-state)
  - [Custom Styled Button](#custom-styled-button)
- [Accessibility](#accessibility)
  - [VoiceOver Support](#voiceover-support)
  - [Dynamic Type Support](#dynamic-type-support)
- [Animation](#animation)
  - [Built-in Animations](#built-in-animations)
  - [Custom Animations](#custom-animations)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Button Component](#swiftui-button-component)
  - [SwiftUI Usage](#swiftui-usage)
- [Error Handling](#error-handling)
  - [Button Errors](#button-errors)
- [Performance Considerations](#performance-considerations)
  - [Memory Management](#memory-management)
  - [Rendering Performance](#rendering-performance)
- [Best Practices](#best-practices)
  - [Button Design](#button-design)
  - [Code Organization](#code-organization)
- [Migration Guide](#migration-guide)
  - [From UIKit Buttons](#from-uikit-buttons)
  - [From SwiftUI Buttons](#from-swiftui-buttons)
- [Version History](#version-history)
  - [Version 1.0.0](#version-100)
  - [Version 1.1.0](#version-110)
  - [Version 1.2.0](#version-120)
- [Support](#support)
<!-- TOC END -->


## Overview

The Button Components API provides a comprehensive set of customizable button components for iOS applications. This API supports both SwiftUI and UIKit, offering enterprise-grade button solutions with advanced customization options, accessibility features, and smooth animations.

## Core Components

### CustomButton

The main button component that provides extensive customization options.

```swift
public class CustomButton: UIView {
    // MARK: - Properties
    public var title: String
    public var style: ButtonStyle
    public var size: ButtonSize
    public var isEnabled: Bool
    public var isLoading: Bool
    
    // MARK: - Initialization
    public init(title: String, style: ButtonStyle = .primary, size: ButtonSize = .medium)
    
    // MARK: - Configuration
    public func configure(_ configuration: ButtonConfiguration)
    public func setTitle(_ title: String, for state: UIControl.State)
    public func setImage(_ image: UIImage?, for state: UIControl.State)
    
    // MARK: - Actions
    public func onTap(_ action: @escaping () -> Void)
    public func onLongPress(_ action: @escaping () -> Void)
    
    // MARK: - Styling
    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State)
    public func setTextColor(_ color: UIColor, for state: UIControl.State)
    public func setCornerRadius(_ radius: CGFloat)
    public func setShadow(enabled: Bool, color: UIColor?, offset: CGSize?, radius: CGFloat?)
    
    // MARK: - Animation
    public func animateTap()
    public func animateLoading()
    public func animateSuccess()
    public func animateError()
}
```

### ButtonStyle

Enumeration defining different button styles.

```swift
public enum ButtonStyle {
    case primary
    case secondary
    case outline
    case ghost
    case danger
    case success
    case warning
    case info
    case custom(ButtonCustomStyle)
}

public struct ButtonCustomStyle {
    public let backgroundColor: UIColor
    public let textColor: UIColor
    public let borderColor: UIColor?
    public let borderWidth: CGFloat
    public let cornerRadius: CGFloat
    public let shadowEnabled: Bool
    public let shadowColor: UIColor?
    public let shadowOffset: CGSize
    public let shadowRadius: CGFloat
    public let shadowOpacity: Float
}
```

### ButtonSize

Enumeration defining different button sizes.

```swift
public enum ButtonSize {
    case small
    case medium
    case large
    case custom(width: CGFloat, height: CGFloat)
}
```

## Configuration

### ButtonConfiguration

Configuration object for button setup.

```swift
public struct ButtonConfiguration {
    public var enableCustomStyles: Bool
    public var enableAnimations: Bool
    public var enableAccessibility: Bool
    public var enableHapticFeedback: Bool
    public var enableLoadingStates: Bool
    public var enableIconSupport: Bool
    public var enableBadgeSupport: Bool
    public var enableProgressIndicators: Bool
    
    public init()
}
```

## Usage Examples

### Basic Button Creation

```swift
// Create a primary button
let primaryButton = CustomButton(
    title: "Get Started",
    style: .primary,
    size: .large
)

// Configure button
primaryButton.configure { config in
    config.backgroundColor = .systemBlue
    config.textColor = .white
    config.cornerRadius = 12
    config.shadowEnabled = true
}

// Add tap action
primaryButton.onTap {
    print("Button tapped!")
}
```

### Advanced Button with Loading State

```swift
// Create button with loading state
let submitButton = CustomButton(
    title: "Submit",
    style: .primary,
    size: .medium
)

// Configure with loading support
submitButton.configure { config in
    config.enableLoadingStates = true
    config.enableHapticFeedback = true
}

// Handle loading state
submitButton.onTap {
    submitButton.isLoading = true
    
    // Simulate API call
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        submitButton.isLoading = false
        submitButton.animateSuccess()
    }
}
```

### Custom Styled Button

```swift
// Create custom styled button
let customStyle = ButtonCustomStyle(
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
    style: .custom(customStyle),
    size: .medium
)
```

## Accessibility

### VoiceOver Support

```swift
// Configure accessibility
primaryButton.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
primaryButton.accessibilityLabel = "Get Started Button"
primaryButton.accessibilityHint = "Double tap to begin the onboarding process"
primaryButton.accessibilityTraits = .button
```

### Dynamic Type Support

```swift
// Support dynamic type
primaryButton.configure { config in
    config.enableDynamicType = true
    config.textStyle = .body
}
```

## Animation

### Built-in Animations

```swift
// Tap animation
primaryButton.animateTap()

// Loading animation
primaryButton.animateLoading()

// Success animation
primaryButton.animateSuccess()

// Error animation
primaryButton.animateError()
```

### Custom Animations

```swift
// Custom animation
primaryButton.animate(
    duration: 0.3,
    delay: 0,
    options: [.curveEaseInOut],
    animations: {
        primaryButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    },
    completion: { _ in
        UIView.animate(withDuration: 0.1) {
            primaryButton.transform = .identity
        }
    }
)
```

## SwiftUI Support

### SwiftUI Button Component

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

// Handle errors
do {
    try primaryButton.configure(buttonConfig)
} catch ButtonError.invalidConfiguration {
    print("Invalid button configuration")
} catch {
    print("Button configuration failed: \(error)")
}
```

## Performance Considerations

### Memory Management

- Buttons are automatically deallocated when not in use
- Image caching is handled internally
- Animation memory is properly managed

### Rendering Performance

- Hardware acceleration for animations
- Efficient drawing with Core Graphics
- Optimized layout calculations

## Best Practices

### Button Design

1. **Clear Purpose**: Ensure button purpose is immediately clear
2. **Consistent Styling**: Maintain consistent button styles across app
3. **Adequate Size**: Minimum 44x44 points for touch targets
4. **Visual Feedback**: Provide clear visual feedback for interactions
5. **Accessibility**: Always include proper accessibility labels

### Code Organization

1. **Configuration**: Use configuration objects for complex setups
2. **Reusability**: Create reusable button styles
3. **Testing**: Test all button states and interactions
4. **Documentation**: Document custom button implementations

## Migration Guide

### From UIKit Buttons

```swift
// Old UIKit approach
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

### From SwiftUI Buttons

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

## Version History

### Version 1.0.0
- Initial release with basic button functionality
- Support for primary and secondary styles
- Basic animation support

### Version 1.1.0
- Added custom style support
- Enhanced accessibility features
- Improved animation system

### Version 1.2.0
- Added loading state support
- Enhanced SwiftUI integration
- Performance optimizations

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
