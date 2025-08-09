# Theming API

<!-- TOC START -->
## Table of Contents
- [Theming API](#theming-api)
- [Overview](#overview)
- [Core Components](#core-components)
  - [ThemeManager](#thememanager)
  - [Theme](#theme)
  - [ThemeColors](#themecolors)
- [Usage Examples](#usage-examples)
  - [Basic Theme Application](#basic-theme-application)
  - [Dark Mode Support](#dark-mode-support)
  - [Custom Theme Creation](#custom-theme-creation)
- [Dynamic Theme Switching](#dynamic-theme-switching)
  - [Runtime Theme Changes](#runtime-theme-changes)
  - [Theme Configuration](#theme-configuration)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Theme Integration](#swiftui-theme-integration)
  - [SwiftUI Usage](#swiftui-usage)
- [Accessibility Support](#accessibility-support)
  - [High Contrast Support](#high-contrast-support)
  - [Dynamic Type Support](#dynamic-type-support)
- [Error Handling](#error-handling)
  - [Theme Errors](#theme-errors)
- [Performance Considerations](#performance-considerations)
  - [Theme Caching](#theme-caching)
  - [Memory Management](#memory-management)
- [Best Practices](#best-practices)
  - [Theme Design](#theme-design)
  - [Code Organization](#code-organization)
- [Migration Guide](#migration-guide)
  - [From Manual Styling](#from-manual-styling)
  - [From Hardcoded Colors](#from-hardcoded-colors)
- [Version History](#version-history)
  - [Version 1.0.0](#version-100)
  - [Version 1.1.0](#version-110)
  - [Version 1.2.0](#version-120)
- [Support](#support)
<!-- TOC END -->


## Overview

The Theming API provides comprehensive theming and design system management for iOS UI Components. This API supports dynamic themes, dark mode, custom color schemes, typography scaling, and accessibility features.

## Core Components

### ThemeManager

The main theme management component.

```swift
public class ThemeManager {
    // MARK: - Properties
    public static let shared = ThemeManager()
    public var currentTheme: Theme
    public var availableThemes: [Theme]
    
    // MARK: - Initialization
    private init()
    
    // MARK: - Theme Management
    public func applyTheme(_ theme: Theme)
    public func switchToTheme(_ themeName: String)
    public func createCustomTheme(_ theme: CustomTheme)
    public func updateTheme(_ theme: Theme)
    
    // MARK: - Configuration
    public func configure(_ configuration: ThemeConfiguration)
    public func enableDarkMode(_ enabled: Bool)
    public func enableDynamicColors(_ enabled: Bool)
}
```

### Theme

Base theme protocol.

```swift
public protocol Theme {
    var name: String { get }
    var colors: ThemeColors { get }
    var typography: ThemeTypography { get }
    var spacing: ThemeSpacing { get }
    var animations: ThemeAnimations { get }
}
```

### ThemeColors

Color scheme definition.

```swift
public struct ThemeColors {
    public let primary: UIColor
    public let secondary: UIColor
    public let background: UIColor
    public let surface: UIColor
    public let text: UIColor
    public let textSecondary: UIColor
    public let border: UIColor
    public let error: UIColor
    public let success: UIColor
    public let warning: UIColor
    public let info: UIColor
    
    public init(
        primary: UIColor,
        secondary: UIColor,
        background: UIColor,
        surface: UIColor,
        text: UIColor,
        textSecondary: UIColor,
        border: UIColor,
        error: UIColor,
        success: UIColor,
        warning: UIColor,
        info: UIColor
    )
}
```

## Usage Examples

### Basic Theme Application

```swift
// Create a basic theme
let basicTheme = CustomTheme(
    name: "Basic Theme",
    colors: ThemeColors(
        primary: .systemBlue,
        secondary: .systemGray,
        background: .systemBackground,
        surface: .systemBackground,
        text: .label,
        textSecondary: .secondaryLabel,
        border: .systemGray4,
        error: .systemRed,
        success: .systemGreen,
        warning: .systemOrange,
        info: .systemBlue
    ),
    typography: ThemeTypography(
        titleFont: .systemFont(ofSize: 24, weight: .bold),
        bodyFont: .systemFont(ofSize: 16, weight: .regular),
        captionFont: .systemFont(ofSize: 12, weight: .light)
    )
)

// Apply theme
ThemeManager.shared.applyTheme(basicTheme)
```

### Dark Mode Support

```swift
// Create dark theme
let darkTheme = CustomTheme(
    name: "Dark Theme",
    colors: ThemeColors(
        primary: .systemBlue,
        secondary: .systemGray,
        background: .systemBackground,
        surface: .secondarySystemBackground,
        text: .label,
        textSecondary: .secondaryLabel,
        border: .systemGray4,
        error: .systemRed,
        success: .systemGreen,
        warning: .systemOrange,
        info: .systemBlue
    )
)

// Enable dark mode
ThemeManager.shared.enableDarkMode(true)
ThemeManager.shared.applyTheme(darkTheme)
```

### Custom Theme Creation

```swift
// Create custom theme
let customTheme = CustomTheme(
    name: "Corporate Theme",
    colors: ThemeColors(
        primary: UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0),
        secondary: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0),
        background: .white,
        surface: UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0),
        text: .black,
        textSecondary: .darkGray,
        border: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0),
        error: .systemRed,
        success: .systemGreen,
        warning: .systemOrange,
        info: .systemBlue
    ),
    typography: ThemeTypography(
        titleFont: .systemFont(ofSize: 28, weight: .bold),
        bodyFont: .systemFont(ofSize: 16, weight: .medium),
        captionFont: .systemFont(ofSize: 14, weight: .regular)
    )
)

// Apply custom theme
ThemeManager.shared.applyTheme(customTheme)
```

## Dynamic Theme Switching

### Runtime Theme Changes

```swift
// Switch themes at runtime
ThemeManager.shared.switchToTheme("Dark Theme")

// Observe theme changes
NotificationCenter.default.addObserver(
    forName: .themeDidChange,
    object: nil,
    queue: .main
) { notification in
    if let newTheme = notification.object as? Theme {
        print("Theme changed to: \(newTheme.name)")
        updateUIForTheme(newTheme)
    }
}
```

### Theme Configuration

```swift
// Configure theme manager
let themeConfig = ThemeConfiguration()
themeConfig.enableDynamicColors = true
themeConfig.enableDarkMode = true
themeConfig.enableCustomThemes = true
themeConfig.enableColorSchemes = true
themeConfig.enableTypographyScaling = true

ThemeManager.shared.configure(themeConfig)
```

## SwiftUI Support

### SwiftUI Theme Integration

```swift
public struct SwiftUITheme: View {
    public let theme: Theme
    public let content: () -> AnyView
    
    public init(theme: Theme, @ViewBuilder content: @escaping () -> AnyView)
    
    public var body: some View
}
```

### SwiftUI Usage

```swift
struct ContentView: View {
    @State private var currentTheme: Theme = ThemeManager.shared.currentTheme
    
    var body: some View {
        SwiftUITheme(theme: currentTheme) {
            AnyView(
                VStack {
                    Text("Themed Content")
                        .foregroundColor(currentTheme.colors.text)
                    Button("Switch Theme") {
                        ThemeManager.shared.switchToTheme("Dark Theme")
                        currentTheme = ThemeManager.shared.currentTheme
                    }
                }
                .background(currentTheme.colors.background)
            )
        }
    }
}
```

## Accessibility Support

### High Contrast Support

```swift
// Enable high contrast
ThemeManager.shared.enableHighContrast(true)

// Create high contrast theme
let highContrastTheme = CustomTheme(
    name: "High Contrast",
    colors: ThemeColors(
        primary: .white,
        secondary: .black,
        background: .black,
        surface: .black,
        text: .white,
        textSecondary: .lightGray,
        border: .white,
        error: .systemRed,
        success: .systemGreen,
        warning: .systemOrange,
        info: .systemBlue
    )
)
```

### Dynamic Type Support

```swift
// Enable dynamic type
ThemeManager.shared.enableDynamicType(true)

// Configure typography scaling
let typographyConfig = TypographyConfiguration()
typographyConfig.enableScaling = true
typographyConfig.scaleFactor = 1.2
typographyConfig.minimumScaleFactor = 0.8
typographyConfig.maximumScaleFactor = 2.0

ThemeManager.shared.configureTypography(typographyConfig)
```

## Error Handling

### Theme Errors

```swift
public enum ThemeError: Error {
    case themeNotFound
    case invalidTheme
    case colorNotFound
    case typographyNotFound
    case configurationFailed
}

// Handle theme errors
do {
    try ThemeManager.shared.applyTheme(customTheme)
} catch ThemeError.themeNotFound {
    print("Theme not found")
} catch ThemeError.invalidTheme {
    print("Invalid theme configuration")
} catch {
    print("Theme application failed: \(error)")
}
```

## Performance Considerations

### Theme Caching

```swift
// Configure theme caching
let cacheConfig = ThemeCacheConfiguration()
cacheConfig.enableCaching = true
cacheConfig.maxCacheSize = 50 * 1024 * 1024 // 50MB
cacheConfig.cacheExpiration = 3600 // 1 hour

ThemeManager.shared.configureCaching(cacheConfig)
```

### Memory Management

```swift
// Configure memory management
let memoryConfig = ThemeMemoryConfiguration()
memoryConfig.enableWeakReferences = true
memoryConfig.enableAutomaticCleanup = true
memoryConfig.maxThemeCount = 10

ThemeManager.shared.configureMemory(memoryConfig)
```

## Best Practices

### Theme Design

1. **Consistency**: Maintain consistent color usage across themes
2. **Accessibility**: Ensure sufficient contrast ratios
3. **Scalability**: Design themes to work at different scales
4. **Documentation**: Document all theme properties
5. **Testing**: Test themes in different environments

### Code Organization

1. **Centralized Management**: Use centralized theme management
2. **Type Safety**: Use strongly typed theme objects
3. **Immutability**: Use immutable theme objects
4. **Observers**: Use observers for theme changes

## Migration Guide

### From Manual Styling

```swift
// Old manual approach
button.backgroundColor = .blue
button.setTitleColor(.white, for: .normal)
label.font = .systemFont(ofSize: 16, weight: .medium)

// New theme approach
let theme = ThemeManager.shared.currentTheme
button.backgroundColor = theme.colors.primary
button.setTitleColor(theme.colors.text, for: .normal)
label.font = theme.typography.bodyFont
```

### From Hardcoded Colors

```swift
// Old hardcoded approach
let primaryColor = UIColor.blue
let backgroundColor = UIColor.white
let textColor = UIColor.black

// New theme approach
let theme = ThemeManager.shared.currentTheme
let primaryColor = theme.colors.primary
let backgroundColor = theme.colors.background
let textColor = theme.colors.text
```

## Version History

### Version 1.0.0
- Initial release with basic theming
- Support for light and dark themes
- Basic color schemes

### Version 1.1.0
- Added custom theme support
- Enhanced accessibility features
- Improved typography system

### Version 1.2.0
- Added dynamic theme switching
- Enhanced SwiftUI support
- Performance optimizations

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
