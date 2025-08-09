# Navigation Components API

<!-- TOC START -->
## Table of Contents
- [Navigation Components API](#navigation-components-api)
- [Overview](#overview)
- [Core Components](#core-components)
  - [CustomNavigationBar](#customnavigationbar)
  - [CustomTabBar](#customtabbar)
  - [TabBarItem](#tabbaritem)
- [Configuration](#configuration)
  - [NavigationBarConfiguration](#navigationbarconfiguration)
  - [TabBarConfiguration](#tabbarconfiguration)
- [Usage Examples](#usage-examples)
  - [Basic Navigation Bar](#basic-navigation-bar)
  - [Custom Tab Bar](#custom-tab-bar)
  - [Transparent Navigation Bar](#transparent-navigation-bar)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Navigation Bar](#swiftui-navigation-bar)
  - [SwiftUI Tab Bar](#swiftui-tab-bar)
- [Accessibility](#accessibility)
  - [VoiceOver Support](#voiceover-support)
  - [Tab Bar Accessibility](#tab-bar-accessibility)
- [Error Handling](#error-handling)
  - [Navigation Errors](#navigation-errors)
- [Performance Considerations](#performance-considerations)
  - [Memory Management](#memory-management)
  - [Rendering Performance](#rendering-performance)
- [Best Practices](#best-practices)
  - [Navigation Design](#navigation-design)
  - [Code Organization](#code-organization)
- [Migration Guide](#migration-guide)
  - [From UINavigationBar](#from-uinavigationbar)
  - [From UITabBar](#from-uitabbar)
- [Version History](#version-history)
  - [Version 1.0.0](#version-100)
  - [Version 1.1.0](#version-110)
  - [Version 1.2.0](#version-120)
- [Support](#support)
<!-- TOC END -->


## Overview

The Navigation Components API provides comprehensive navigation components for iOS applications. This API supports both SwiftUI and UIKit, offering enterprise-grade navigation solutions with custom navigation bars, tab bars, side menus, and advanced navigation patterns.

## Core Components

### CustomNavigationBar

The main navigation bar component that provides extensive customization options.

```swift
public class CustomNavigationBar: UIView {
    // MARK: - Properties
    public var title: String
    public var leftButton: CustomButton?
    public var rightButton: CustomButton?
    public var style: NavigationBarStyle
    public var isTransparent: Bool
    public var isBlurred: Bool
    
    // MARK: - Initialization
    public init(title: String, style: NavigationBarStyle = .default)
    
    // MARK: - Configuration
    public func configure(_ configuration: NavigationBarConfiguration)
    public func setTitle(_ title: String)
    public func setLeftButton(_ button: CustomButton?)
    public func setRightButton(_ button: CustomButton?)
    
    // MARK: - Styling
    public func setBackgroundColor(_ color: UIColor)
    public func setTitleColor(_ color: UIColor)
    public func setTransparent(_ isTransparent: Bool)
    public func setBlurred(_ isBlurred: Bool)
    public func setShadow(enabled: Bool, color: UIColor?, offset: CGSize?, radius: CGFloat?)
}
```

### CustomTabBar

The main tab bar component with advanced customization.

```swift
public class CustomTabBar: UIView {
    // MARK: - Properties
    public var items: [TabBarItem]
    public var selectedIndex: Int
    public var style: TabBarStyle
    public var isTranslucent: Bool
    
    // MARK: - Initialization
    public init(items: [TabBarItem], style: TabBarStyle = .default)
    
    // MARK: - Configuration
    public func configure(_ configuration: TabBarConfiguration)
    public func setItems(_ items: [TabBarItem])
    public func setSelectedIndex(_ index: Int)
    
    // MARK: - Events
    public func onTabSelected(_ action: @escaping (Int) -> Void)
    
    // MARK: - Styling
    public func setBackgroundColor(_ color: UIColor)
    public func setTranslucent(_ isTranslucent: Bool)
    public func setBadge(_ badge: String?, for index: Int)
}
```

### TabBarItem

Model for tab bar items.

```swift
public struct TabBarItem {
    public let title: String
    public let image: UIImage
    public let selectedImage: UIImage?
    public let badge: String?
    
    public init(title: String, image: UIImage, selectedImage: UIImage? = nil, badge: String? = nil)
}
```

## Configuration

### NavigationBarConfiguration

Configuration object for navigation bar setup.

```swift
public struct NavigationBarConfiguration {
    public var enableCustomButtons: Bool
    public var enableTransparency: Bool
    public var enableBlurEffect: Bool
    public var enableAccessibility: Bool
    public var enableHapticFeedback: Bool
    public var enableLargeTitles: Bool
    public var enableSearchBar: Bool
    public var enableProgressBar: Bool
    
    public init()
}
```

### TabBarConfiguration

Configuration object for tab bar setup.

```swift
public struct TabBarConfiguration {
    public var enableCustomStyling: Bool
    public var enableAnimations: Bool
    public var enableAccessibility: Bool
    public var enableHapticFeedback: Bool
    public var enableBadgeSupport: Bool
    public var enableTranslucency: Bool
    public var enableCustomIcons: Bool
    public var enableSelectionIndicator: Bool
    
    public init()
}
```

## Usage Examples

### Basic Navigation Bar

```swift
// Create a basic navigation bar
let navigationBar = CustomNavigationBar(
    title: "Home",
    style: .default
)

// Configure navigation bar
navigationBar.configure { config in
    config.enableCustomButtons = true
    config.enableAccessibility = true
}

// Add left button
let backButton = CustomButton(
    title: "Back",
    style: .secondary,
    size: .small
)

navigationBar.setLeftButton(backButton)

// Add right button
let menuButton = CustomButton(
    title: "Menu",
    style: .secondary,
    size: .small
)

navigationBar.setRightButton(menuButton)

// Style navigation bar
navigationBar.setBackgroundColor(.systemBackground)
navigationBar.setTitleColor(.label)
navigationBar.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 1), radius: 2)
```

### Custom Tab Bar

```swift
// Create tab bar items
let homeItem = TabBarItem(
    title: "Home",
    image: UIImage(systemName: "house")!,
    selectedImage: UIImage(systemName: "house.fill")!
)

let searchItem = TabBarItem(
    title: "Search",
    image: UIImage(systemName: "magnifyingglass")!,
    selectedImage: UIImage(systemName: "magnifyingglass")!
)

let profileItem = TabBarItem(
    title: "Profile",
    image: UIImage(systemName: "person")!,
    selectedImage: UIImage(systemName: "person.fill")!,
    badge: "3"
)

// Create tab bar
let tabBar = CustomTabBar(
    items: [homeItem, searchItem, profileItem],
    style: .default
)

// Configure tab bar
tabBar.configure { config in
    config.enableAnimations = true
    config.enableAccessibility = true
    config.enableBadgeSupport = true
}

// Handle tab selection
tabBar.onTabSelected { index in
    print("Selected tab: \(index)")
}

// Style tab bar
tabBar.setBackgroundColor(.systemBackground)
tabBar.setTranslucent(true)
```

### Transparent Navigation Bar

```swift
// Create transparent navigation bar
let transparentNavBar = CustomNavigationBar(
    title: "Transparent",
    style: .transparent
)

// Configure for transparency
transparentNavBar.configure { config in
    config.enableTransparency = true
    config.enableBlurEffect = true
}

// Set transparency
transparentNavBar.setTransparent(true)
transparentNavBar.setBlurred(true)
```

## SwiftUI Support

### SwiftUI Navigation Bar

```swift
public struct SwiftUINavigationBar: View {
    public let title: String
    public let leftButton: SwiftUIButton?
    public let rightButton: SwiftUIButton?
    public let style: NavigationBarStyle
    public let onLeftButtonTap: (() -> Void)?
    public let onRightButtonTap: (() -> Void)?
    
    public init(
        title: String,
        style: NavigationBarStyle = .default,
        leftButton: SwiftUIButton? = nil,
        rightButton: SwiftUIButton? = nil,
        onLeftButtonTap: (() -> Void)? = nil,
        onRightButtonTap: (() -> Void)? = nil
    )
    
    public var body: some View
}
```

### SwiftUI Tab Bar

```swift
public struct SwiftUITabBar: View {
    public let items: [TabBarItem]
    public let selectedIndex: Binding<Int>
    public let style: TabBarStyle
    public let onTabSelected: (Int) -> Void
    
    public init(
        items: [TabBarItem],
        selectedIndex: Binding<Int>,
        style: TabBarStyle = .default,
        onTabSelected: @escaping (Int) -> Void
    )
    
    public var body: some View
}
```

## Accessibility

### VoiceOver Support

```swift
// Configure accessibility for navigation bar
navigationBar.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
navigationBar.accessibilityLabel = "Main Navigation Bar"
navigationBar.accessibilityHint = "Navigate through the app"
```

### Tab Bar Accessibility

```swift
// Configure accessibility for tab bar
tabBar.configure { config in
    config.enableAccessibility = true
}

// Set accessibility for tab items
for (index, item) in tabBar.items.enumerated() {
    tabBar.setAccessibilityLabel("\(item.title) Tab", for: index)
    tabBar.setAccessibilityHint("Double tap to select \(item.title)", for: index)
}
```

## Error Handling

### Navigation Errors

```swift
public enum NavigationError: Error {
    case invalidConfiguration
    case buttonCreationFailed
    case accessibilitySetupFailed
    case styleNotFound
    case itemNotFound
}

// Handle errors
do {
    try navigationBar.configure(navConfig)
} catch NavigationError.invalidConfiguration {
    print("Invalid navigation configuration")
} catch {
    print("Navigation configuration failed: \(error)")
}
```

## Performance Considerations

### Memory Management

- Navigation components are automatically deallocated when not in use
- Button images are cached efficiently
- Animation memory is properly managed

### Rendering Performance

- Hardware acceleration for animations
- Efficient drawing with Core Graphics
- Optimized layout calculations

## Best Practices

### Navigation Design

1. **Clear Hierarchy**: Use clear navigation structure
2. **Consistent Styling**: Maintain consistent navigation styling
3. **Accessibility**: Always include proper accessibility labels
4. **User Feedback**: Provide clear feedback for navigation actions
5. **Performance**: Optimize navigation transitions

### Code Organization

1. **Configuration**: Use configuration objects for complex setups
2. **Reusability**: Create reusable navigation components
3. **Testing**: Test all navigation states and interactions
4. **Documentation**: Document custom navigation implementations

## Migration Guide

### From UINavigationBar

```swift
// Old UINavigationBar approach
let oldNavBar = UINavigationBar()
oldNavBar.barTintColor = .systemBlue
oldNavBar.tintColor = .white

// New CustomNavigationBar approach
let newNavBar = CustomNavigationBar(
    title: "New Navigation",
    style: .default
)
```

### From UITabBar

```swift
// Old UITabBar approach
let oldTabBar = UITabBar()
oldTabBar.items = [tabBarItem1, tabBarItem2, tabBarItem3]

// New CustomTabBar approach
let newTabBar = CustomTabBar(
    items: [item1, item2, item3],
    style: .default
)
```

## Version History

### Version 1.0.0
- Initial release with basic navigation functionality
- Support for common navigation patterns
- Basic customization support

### Version 1.1.0
- Added custom styling support
- Enhanced accessibility features
- Improved animation system

### Version 1.2.0
- Added SwiftUI integration
- Enhanced tab bar functionality
- Performance optimizations

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
