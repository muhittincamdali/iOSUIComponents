# 🎨 Design System Guide

Complete design system documentation for iOS UI Components.

## 📋 Table of Contents

- [Design Principles](#design-principles)
- [Color System](#color-system)
- [Typography](#typography)
- [Spacing](#spacing)
- [Components](#components)
- [Themes](#themes)
- [Accessibility](#accessibility)

## 🎯 Design Principles

### **Core Principles**
- **Consistency**: Unified design language across all components
- **Accessibility**: Full support for VoiceOver and Dynamic Type
- **Performance**: Optimized for smooth animations and interactions
- **Flexibility**: Easy customization and theming
- **Modern**: Following latest iOS design guidelines

### **Design Philosophy**
- **User-Centered**: Components designed for real user needs
- **Mobile-First**: Optimized for mobile interactions
- **Scalable**: Components that grow with your app
- **Maintainable**: Clean, well-documented code

## 🎨 Color System

### **Primary Colors**
```swift
struct AppColors {
    // Primary brand colors
    static let primary = Color(hex: "#007AFF")
    static let primaryDark = Color(hex: "#0056CC")
    static let primaryLight = Color(hex: "#4DA3FF")
    
    // Secondary colors
    static let secondary = Color(hex: "#5856D6")
    static let secondaryDark = Color(hex: "#3B3A9E")
    static let secondaryLight = Color(hex: "#7B7AFF")
    
    // Accent colors
    static let accent = Color(hex: "#FF9500")
    static let accentDark = Color(hex: "#CC7700")
    static let accentLight = Color(hex: "#FFB340")
}
```

### **Semantic Colors**
```swift
struct SemanticColors {
    // Success states
    static let success = Color(hex: "#34C759")
    static let successLight = Color(hex: "#5CD671")
    static let successDark = Color(hex: "#28A745")
    
    // Warning states
    static let warning = Color(hex: "#FF9500")
    static let warningLight = Color(hex: "#FFB340")
    static let warningDark = Color(hex: "#CC7700")
    
    // Error states
    static let error = Color(hex: "#FF3B30")
    static let errorLight = Color(hex: "#FF6B61")
    static let errorDark = Color(hex: "#CC2E25")
    
    // Info states
    static let info = Color(hex: "#007AFF")
    static let infoLight = Color(hex: "#4DA3FF")
    static let infoDark = Color(hex: "#0056CC")
}
```

### **Neutral Colors**
```swift
struct NeutralColors {
    // Background colors
    static let background = Color(hex: "#F2F2F7")
    static let backgroundSecondary = Color(hex: "#FFFFFF")
    static let backgroundTertiary = Color(hex: "#E5E5EA")
    
    // Surface colors
    static let surface = Color.white
    static let surfaceSecondary = Color(hex: "#F9F9F9")
    static let surfaceTertiary = Color(hex: "#F2F2F7")
    
    // Text colors
    static let text = Color(hex: "#1C1C1E")
    static let textSecondary = Color(hex: "#8E8E93")
    static let textTertiary = Color(hex: "#C7C7CC")
    
    // Border colors
    static let border = Color(hex: "#C6C6C8")
    static let borderSecondary = Color(hex: "#E5E5EA")
    static let borderTertiary = Color(hex: "#F2F2F7")
}
```

### **Dark Mode Colors**
```swift
struct DarkModeColors {
    // Background colors
    static let background = Color(hex: "#000000")
    static let backgroundSecondary = Color(hex: "#1C1C1E")
    static let backgroundTertiary = Color(hex: "#2C2C2E")
    
    // Surface colors
    static let surface = Color(hex: "#1C1C1E")
    static let surfaceSecondary = Color(hex: "#2C2C2E")
    static let surfaceTertiary = Color(hex: "#3A3A3C")
    
    // Text colors
    static let text = Color.white
    static let textSecondary = Color(hex: "#8E8E93")
    static let textTertiary = Color(hex: "#48484A")
    
    // Border colors
    static let border = Color(hex: "#38383A")
    static let borderSecondary = Color(hex: "#48484A")
    static let borderTertiary = Color(hex: "#58585A")
}
```

## 📝 Typography

### **Font System**
```swift
struct AppFonts {
    // Headings
    static let h1 = Font.system(size: 32, weight: .bold, design: .default)
    static let h2 = Font.system(size: 28, weight: .semibold, design: .default)
    static let h3 = Font.system(size: 24, weight: .medium, design: .default)
    static let h4 = Font.system(size: 20, weight: .medium, design: .default)
    
    // Body text
    static let bodyLarge = Font.system(size: 18, weight: .regular, design: .default)
    static let body = Font.system(size: 16, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 14, weight: .regular, design: .default)
    
    // Captions
    static let caption = Font.system(size: 12, weight: .regular, design: .default)
    static let captionSmall = Font.system(size: 10, weight: .regular, design: .default)
    
    // Buttons
    static let button = Font.system(size: 16, weight: .semibold, design: .default)
    static let buttonSmall = Font.system(size: 14, weight: .semibold, design: .default)
}
```

### **Dynamic Type Support**
```swift
struct DynamicFonts {
    // Large text
    static let largeTitle = Font.largeTitle
    static let title1 = Font.title
    static let title2 = Font.title2
    static let title3 = Font.title3
    
    // Body text
    static let headline = Font.headline
    static let body = Font.body
    static let callout = Font.callout
    static let subheadline = Font.subheadline
    static let footnote = Font.footnote
    static let caption1 = Font.caption
    static let caption2 = Font.caption2
}
```

### **Custom Fonts**
```swift
struct CustomFonts {
    // Brand fonts
    static let brandBold = Font.custom("YourBrand-Bold", size: 24)
    static let brandRegular = Font.custom("YourBrand-Regular", size: 16)
    static let brandLight = Font.custom("YourBrand-Light", size: 14)
    
    // Display fonts
    static let displayLarge = Font.custom("YourDisplay-Bold", size: 48)
    static let displayMedium = Font.custom("YourDisplay-Bold", size: 36)
    static let displaySmall = Font.custom("YourDisplay-Bold", size: 24)
}
```

## 📏 Spacing

### **Spacing System**
```swift
struct AppSpacing {
    // Base spacing units
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64
    
    // Component-specific spacing
    static let buttonPadding: CGFloat = 16
    static let cardPadding: CGFloat = 20
    static let listItemSpacing: CGFloat = 12
    static let sectionSpacing: CGFloat = 32
}
```

### **Layout Spacing**
```swift
struct LayoutSpacing {
    // Screen margins
    static let screenMargin: CGFloat = 16
    static let screenMarginLarge: CGFloat = 24
    
    // Content spacing
    static let contentSpacing: CGFloat = 16
    static let contentSpacingLarge: CGFloat = 24
    
    // Section spacing
    static let sectionSpacing: CGFloat = 32
    static let sectionSpacingLarge: CGFloat = 48
}
```

### **Component Spacing**
```swift
struct ComponentSpacing {
    // Button spacing
    static let buttonHorizontalPadding: CGFloat = 16
    static let buttonVerticalPadding: CGFloat = 12
    static let buttonSpacing: CGFloat = 8
    
    // Card spacing
    static let cardPadding: CGFloat = 16
    static let cardSpacing: CGFloat = 12
    
    // List spacing
    static let listItemSpacing: CGFloat = 8
    static let listSectionSpacing: CGFloat = 16
}
```

## 🧩 Components

### **Button Components**
```swift
struct ButtonComponents {
    // Primary button
    static let primary = CustomButton(
        title: "Primary Action",
        style: .primary,
        size: .large
    )
    
    // Secondary button
    static let secondary = CustomButton(
        title: "Secondary Action",
        style: .secondary,
        size: .medium
    )
    
    // Outline button
    static let outline = CustomButton(
        title: "Outline Action",
        style: .outline,
        size: .medium
    )
    
    // Danger button
    static let danger = CustomButton(
        title: "Danger Action",
        style: .danger,
        size: .medium
    )
}
```

### **Card Components**
```swift
struct CardComponents {
    // Default card
    static let `default` = CustomCard(
        title: "Card Title",
        subtitle: "Card subtitle",
        style: .default
    )
    
    // Elevated card
    static let elevated = CustomCard(
        title: "Elevated Card",
        subtitle: "With shadow",
        style: .elevated
    )
    
    // Outlined card
    static let outlined = CustomCard(
        title: "Outlined Card",
        subtitle: "With border",
        style: .outlined
    )
}
```

### **Input Components**
```swift
struct InputComponents {
    // Text field
    static let textField = CustomTextField(
        placeholder: "Enter text",
        validation: .none
    )
    
    // Email field
    static let emailField = CustomTextField(
        placeholder: "Enter email",
        validation: .email
    )
    
    // Password field
    static let passwordField = CustomTextField(
        placeholder: "Enter password",
        validation: .password
    )
    
    // Toggle
    static let toggle = CustomToggle(
        title: "Enable feature",
        subtitle: "Optional description"
    )
    
    // Slider
    static let slider = CustomSlider(
        range: 0...100,
        step: 1
    )
}
```

## 🎨 Themes

### **Theme System**
```swift
struct AppTheme {
    let colors: ColorPalette
    let fonts: FontPalette
    let spacing: SpacingPalette
    
    static let light = AppTheme(
        colors: LightColorPalette(),
        fonts: DefaultFontPalette(),
        spacing: DefaultSpacingPalette()
    )
    
    static let dark = AppTheme(
        colors: DarkColorPalette(),
        fonts: DefaultFontPalette(),
        spacing: DefaultSpacingPalette()
    )
}
```

### **Color Palette Protocol**
```swift
protocol ColorPalette {
    var primary: Color { get }
    var secondary: Color { get }
    var accent: Color { get }
    var background: Color { get }
    var surface: Color { get }
    var text: Color { get }
    var textSecondary: Color { get }
    var border: Color { get }
    var success: Color { get }
    var warning: Color { get }
    var error: Color { get }
}
```

### **Font Palette Protocol**
```swift
protocol FontPalette {
    var h1: Font { get }
    var h2: Font { get }
    var h3: Font { get }
    var h4: Font { get }
    var bodyLarge: Font { get }
    var body: Font { get }
    var bodySmall: Font { get }
    var caption: Font { get }
    var captionSmall: Font { get }
    var button: Font { get }
    var buttonSmall: Font { get }
}
```

### **Spacing Palette Protocol**
```swift
protocol SpacingPalette {
    var xs: CGFloat { get }
    var sm: CGFloat { get }
    var md: CGFloat { get }
    var lg: CGFloat { get }
    var xl: CGFloat { get }
    var xxl: CGFloat { get }
    var xxxl: CGFloat { get }
}
```

## ♿ Accessibility

### **Accessibility Support**
```swift
struct AccessibilitySupport {
    // VoiceOver support
    static func configureVoiceOver(for view: some View) -> some View {
        view
            .accessibilityLabel("Accessibility label")
            .accessibilityHint("Accessibility hint")
            .accessibilityValue("Accessibility value")
    }
    
    // Dynamic Type support
    static func configureDynamicType(for text: Text) -> Text {
        text
            .font(.body)
            .lineLimit(nil)
            .minimumScaleFactor(0.8)
    }
    
    // High contrast support
    static func configureHighContrast(for color: Color) -> Color {
        color
            .environment(\.colorSchemeContrast, .increased)
    }
}
```

### **Accessibility Guidelines**
```swift
struct AccessibilityGuidelines {
    // Minimum touch targets
    static let minimumTouchTarget: CGFloat = 44
    
    // Color contrast ratios
    static let minimumContrastRatio: Double = 4.5
    
    // Focus indicators
    static let focusIndicatorColor = Color.blue
    
    // Screen reader support
    static let screenReaderSupport = true
}
```

### **Accessibility Testing**
```swift
struct AccessibilityTesting {
    // VoiceOver testing
    static func testVoiceOver(for view: some View) {
        // Test VoiceOver navigation
        // Test VoiceOver announcements
        // Test VoiceOver gestures
    }
    
    // Dynamic Type testing
    static func testDynamicType(for text: Text) {
        // Test different text sizes
        // Test text scaling
        // Test layout adaptation
    }
    
    // High contrast testing
    static func testHighContrast(for colors: [Color]) {
        // Test color contrast ratios
        // Test color visibility
        // Test color accessibility
    }
}
```

## 🎯 Best Practices

### **Design Consistency**
1. **Use Design Tokens**: Always use predefined colors, fonts, and spacing
2. **Follow Patterns**: Use consistent component patterns
3. **Maintain Hierarchy**: Use proper typography hierarchy
4. **Be Consistent**: Apply the same design rules everywhere

### **Performance Optimization**
1. **Lazy Loading**: Load components only when needed
2. **Memory Management**: Efficient memory usage
3. **Rendering Optimization**: Minimal re-renders
4. **Animation Performance**: Hardware-accelerated animations

### **Accessibility First**
1. **VoiceOver Support**: Full VoiceOver compatibility
2. **Dynamic Type**: Support all text sizes
3. **High Contrast**: Support high contrast mode
4. **Focus Management**: Proper focus indicators

## 📚 Next Steps

1. **Read [Getting Started](GettingStarted.md)** for quick setup
2. **Check [Component Guide](ComponentGuide.md)** for component usage
3. **Explore [Customization](Customization.md)** for theming options
4. **Review [API Reference](API.md)** for complete documentation

## 🤝 Support

- **Documentation**: [Complete Documentation](Documentation/)
- **Issues**: [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- **Discussions**: [GitHub Discussions](https://github.com/muhittincamdali/iOSUIComponents/discussions)

---

**Happy designing with iOS UI Components! 🚀** 