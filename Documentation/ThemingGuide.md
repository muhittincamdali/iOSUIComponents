# Theming Guide

<!-- TOC START -->
## Table of Contents
- [Theming Guide](#theming-guide)
- [Overview](#overview)
- [Getting Started](#getting-started)
  - [Basic Theme Application](#basic-theme-application)
  - [Theme Configuration](#theme-configuration)
- [Theme Types](#theme-types)
  - [Light Theme](#light-theme)
  - [Dark Theme](#dark-theme)
  - [Custom Theme](#custom-theme)
- [Dynamic Theme Switching](#dynamic-theme-switching)
  - [Runtime Theme Changes](#runtime-theme-changes)
  - [Automatic Theme Switching](#automatic-theme-switching)
- [Color Schemes](#color-schemes)
  - [Primary Color Scheme](#primary-color-scheme)
  - [Semantic Color Scheme](#semantic-color-scheme)
  - [Custom Color Scheme](#custom-color-scheme)
- [Typography](#typography)
  - [Font Scales](#font-scales)
  - [Dynamic Type Support](#dynamic-type-support)
- [Spacing System](#spacing-system)
  - [Standard Spacing](#standard-spacing)
  - [Custom Spacing](#custom-spacing)
- [Animation Theming](#animation-theming)
  - [Animation Scales](#animation-scales)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Theme Integration](#swiftui-theme-integration)
  - [SwiftUI Usage](#swiftui-usage)
- [Accessibility Support](#accessibility-support)
  - [High Contrast Support](#high-contrast-support)
  - [Reduced Motion Support](#reduced-motion-support)
- [Best Practices](#best-practices)
  - [Theme Design](#theme-design)
  - [Color Usage](#color-usage)
  - [Typography Usage](#typography-usage)
- [Common Patterns](#common-patterns)
  - [Brand Theme](#brand-theme)
  - [Seasonal Theme](#seasonal-theme)
  - [Accessibility Theme](#accessibility-theme)
- [Error Handling](#error-handling)
  - [Theme Errors](#theme-errors)
- [Performance Considerations](#performance-considerations)
  - [Theme Caching](#theme-caching)
  - [Memory Management](#memory-management)
- [Migration Guide](#migration-guide)
  - [From Manual Styling](#from-manual-styling)
  - [From Hardcoded Colors](#from-hardcoded-colors)
- [Support](#support)
<!-- TOC END -->


## Overview

The Theming Guide provides comprehensive information about using theming and design system features in iOS UI Components. This guide covers theme creation, customization, dark mode support, and best practices.

## Getting Started

### Basic Theme Application

```swift
// Create a basic theme
let basicTheme = CustomTheme(
    name: "Basic Theme",
    colors: ThemeColors(
        primary: .systemBlue,
        secondary: .systemGray,
        background: .systemBackground,
        text: .label
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

### Theme Configuration

```swift
// Configure theme manager
let themeManager = ThemeManager.shared

themeManager.configure { config in
    config.enableDynamicColors = true
    config.enableDarkMode = true
    config.enableCustomThemes = true
    config.enableColorSchemes = true
    config.enableTypographyScaling = true
    config.enableSpacingScaling = true
    config.enableAnimationScaling = true
}
```

## Theme Types

### Light Theme

```swift
let lightTheme = CustomTheme(
    name: "Light Theme",
    colors: ThemeColors(
        primary: .systemBlue,
        secondary: .systemGray,
        background: .white,
        surface: .systemGray6,
        text: .black,
        textSecondary: .darkGray,
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
```

### Dark Theme

```swift
let darkTheme = CustomTheme(
    name: "Dark Theme",
    colors: ThemeColors(
        primary: .systemBlue,
        secondary: .systemGray,
        background: .black,
        surface: .systemGray6,
        text: .white,
        textSecondary: .lightGray,
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
```

### Custom Theme

```swift
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

### Automatic Theme Switching

```swift
// Enable automatic theme switching based on system
ThemeManager.shared.enableAutomaticThemeSwitching(true)

// Configure theme switching
ThemeManager.shared.configure { config in
    config.enableDarkMode = true
    config.followSystemAppearance = true
    config.animationDuration = 0.3
}
```

## Color Schemes

### Primary Color Scheme

```swift
let primaryColorScheme = ColorScheme(
    name: "Primary",
    colors: [
        "primary": .systemBlue,
        "primaryLight": .systemBlue.withAlphaComponent(0.8),
        "primaryDark": .systemBlue.withAlphaComponent(1.2),
        "primaryBackground": .systemBlue.withAlphaComponent(0.1)
    ]
)
```

### Semantic Color Scheme

```swift
let semanticColorScheme = ColorScheme(
    name: "Semantic",
    colors: [
        "success": .systemGreen,
        "warning": .systemOrange,
        "error": .systemRed,
        "info": .systemBlue,
        "neutral": .systemGray
    ]
)
```

### Custom Color Scheme

```swift
let customColorScheme = ColorScheme(
    name: "Custom",
    colors: [
        "brand": UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0),
        "accent": UIColor(red: 0.8, green: 0.4, blue: 0.2, alpha: 1.0),
        "highlight": UIColor(red: 0.9, green: 0.9, blue: 0.2, alpha: 1.0)
    ]
)
```

## Typography

### Font Scales

```swift
let typographyScale = TypographyScale(
    name: "Standard",
    fonts: [
        "largeTitle": .systemFont(ofSize: 34, weight: .bold),
        "title1": .systemFont(ofSize: 28, weight: .bold),
        "title2": .systemFont(ofSize: 22, weight: .bold),
        "title3": .systemFont(ofSize: 20, weight: .semibold),
        "headline": .systemFont(ofSize: 17, weight: .semibold),
        "body": .systemFont(ofSize: 17, weight: .regular),
        "callout": .systemFont(ofSize: 16, weight: .regular),
        "subheadline": .systemFont(ofSize: 15, weight: .regular),
        "footnote": .systemFont(ofSize: 13, weight: .regular),
        "caption1": .systemFont(ofSize: 12, weight: .regular),
        "caption2": .systemFont(ofSize: 11, weight: .regular)
    ]
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

## Spacing System

### Standard Spacing

```swift
let spacingSystem = SpacingSystem(
    name: "Standard",
    spacings: [
        "xs": 4,
        "sm": 8,
        "md": 16,
        "lg": 24,
        "xl": 32,
        "xxl": 48
    ]
)
```

### Custom Spacing

```swift
let customSpacing = SpacingSystem(
    name: "Custom",
    spacings: [
        "tiny": 2,
        "small": 6,
        "medium": 12,
        "large": 18,
        "huge": 36,
        "massive": 64
    ]
)
```

## Animation Theming

### Animation Scales

```swift
let animationScale = AnimationScale(
    name: "Standard",
    durations: [
        "fast": 0.1,
        "normal": 0.3,
        "slow": 0.5,
        "verySlow": 1.0
    ],
    easings: [
        "linear": .linear,
        "easeIn": .easeIn,
        "easeOut": .easeOut,
        "easeInOut": .easeInOut
    ]
)
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

### Reduced Motion Support

```swift
// Enable reduced motion
ThemeManager.shared.enableReducedMotion(true)

// Configure reduced motion theme
let reducedMotionTheme = CustomTheme(
    name: "Reduced Motion",
    animations: ThemeAnimations(
        enableAnimations: false,
        duration: 0.0,
        easing: .linear
    )
)
```

## Best Practices

### Theme Design

1. **Consistency**: Maintain consistent color usage across themes
2. **Accessibility**: Ensure sufficient contrast ratios
3. **Scalability**: Design themes to work at different scales
4. **Documentation**: Document all theme properties
5. **Testing**: Test themes in different environments

### Color Usage

1. **Semantic Colors**: Use semantic color names
2. **Contrast Ratios**: Maintain adequate contrast ratios
3. **Color Independence**: Don't rely solely on color for information
4. **Dark Mode**: Design for both light and dark modes
5. **Brand Colors**: Use brand colors consistently

### Typography Usage

1. **Scalable Fonts**: Use system fonts that scale properly
2. **Adequate Sizes**: Ensure text is readable at all sizes
3. **Hierarchy**: Use typography to create clear hierarchy
4. **Consistency**: Use consistent font families
5. **Accessibility**: Support Dynamic Type

## Common Patterns

### Brand Theme

```swift
let brandTheme = CustomTheme(
    name: "Brand Theme",
    colors: ThemeColors(
        primary: brandColor,
        secondary: brandColor.withAlphaComponent(0.8),
        background: .white,
        surface: .systemGray6,
        text: .black,
        textSecondary: .darkGray,
        border: .systemGray4,
        error: .systemRed,
        success: .systemGreen,
        warning: .systemOrange,
        info: brandColor
    ),
    typography: ThemeTypography(
        titleFont: brandFont(ofSize: 24, weight: .bold),
        bodyFont: brandFont(ofSize: 16, weight: .regular),
        captionFont: brandFont(ofSize: 12, weight: .light)
    )
)
```

### Seasonal Theme

```swift
let seasonalTheme = CustomTheme(
    name: "Seasonal Theme",
    colors: ThemeColors(
        primary: seasonalColor,
        secondary: seasonalColor.withAlphaComponent(0.8),
        background: seasonalBackgroundColor,
        surface: seasonalSurfaceColor,
        text: seasonalTextColor,
        textSecondary: seasonalTextSecondaryColor,
        border: seasonalBorderColor,
        error: .systemRed,
        success: .systemGreen,
        warning: .systemOrange,
        info: seasonalColor
    )
)
```

### Accessibility Theme

```swift
let accessibilityTheme = CustomTheme(
    name: "Accessibility Theme",
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
    ),
    typography: ThemeTypography(
        titleFont: .systemFont(ofSize: 28, weight: .bold),
        bodyFont: .systemFont(ofSize: 18, weight: .regular),
        captionFont: .systemFont(ofSize: 16, weight: .regular)
    )
)
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

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
