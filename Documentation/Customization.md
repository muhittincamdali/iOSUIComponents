# 🎨 Customization Guide

Complete customization documentation for iOS UI Components.

## 📋 Table of Contents

- [Theme Customization](#theme-customization)
- [Component Customization](#component-customization)
- [Color Customization](#color-customization)
- [Typography Customization](#typography-customization)
- [Animation Customization](#animation-customization)
- [Layout Customization](#layout-customization)
- [Advanced Customization](#advanced-customization)

## 🎨 Theme Customization

### **Creating Custom Themes**
```swift
struct CustomTheme: AppTheme {
    let colors: ColorPalette
    let fonts: FontPalette
    let spacing: SpacingPalette
    
    init() {
        self.colors = CustomColorPalette()
        self.fonts = CustomFontPalette()
        self.spacing = CustomSpacingPalette()
    }
}

struct CustomColorPalette: ColorPalette {
    let primary = Color(hex: "#FF6B35")
    let secondary = Color(hex: "#4ECDC4")
    let accent = Color(hex: "#45B7D1")
    let background = Color(hex: "#F7F7F7")
    let surface = Color.white
    let text = Color(hex: "#2C3E50")
    let textSecondary = Color(hex: "#7F8C8D")
    let border = Color(hex: "#BDC3C7")
    let success = Color(hex: "#27AE60")
    let warning = Color(hex: "#F39C12")
    let error = Color(hex: "#E74C3C")
}
```

### **Applying Custom Themes**
```swift
struct ContentView: View {
    @State private var currentTheme: AppTheme = .light
    
    var body: some View {
        VStack {
            // Your content here
        }
        .environment(\.appTheme, currentTheme)
    }
}

// Theme environment key
struct AppThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = .light
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}
```

### **Dynamic Theme Switching**
```swift
class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme = .light
    
    func switchTheme() {
        currentTheme = currentTheme == .light ? .dark : .light
    }
    
    func setCustomTheme(_ theme: AppTheme) {
        currentTheme = theme
    }
}

struct ThemeAwareView: View {
    @ObservedObject var themeManager = ThemeManager()
    
    var body: some View {
        VStack {
            // Your themed content
        }
        .environment(\.appTheme, themeManager.currentTheme)
    }
}
```

## 🧩 Component Customization

### **Button Customization**
```swift
struct CustomButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let cornerRadius: CGFloat
    let padding: EdgeInsets
    
    init(
        backgroundColor: Color = .blue,
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 8,
        padding: EdgeInsets = EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Usage
Button("Custom Button") {
    // Action
}
.buttonStyle(CustomButtonStyle(
    backgroundColor: .orange,
    foregroundColor: .white,
    cornerRadius: 12
))
```

### **Card Customization**
```swift
struct CustomCardStyle: ViewModifier {
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let shadowColor: Color
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(
                color: shadowColor,
                radius: shadowRadius,
                x: 0,
                y: 2
            )
    }
}

extension View {
    func customCardStyle(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = 12,
        shadowRadius: CGFloat = 4,
        shadowColor: Color = .black.opacity(0.1)
    ) -> some View {
        modifier(CustomCardStyle(
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius,
            shadowRadius: shadowRadius,
            shadowColor: shadowColor
        ))
    }
}
```

### **TextField Customization**
```swift
struct CustomTextFieldStyle: TextFieldStyle {
    let borderColor: Color
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    
    init(
        borderColor: Color = .gray,
        backgroundColor: Color = .clear,
        cornerRadius: CGFloat = 8,
        borderWidth: CGFloat = 1
    ) {
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}

// Usage
TextField("Enter text", text: $text)
    .textFieldStyle(CustomTextFieldStyle(
        borderColor: .blue,
        cornerRadius: 12
    ))
```

## 🎨 Color Customization

### **Color Palette Creation**
```swift
struct BrandColorPalette: ColorPalette {
    // Primary brand colors
    let primary = Color(hex: "#1E3A8A")
    let primaryLight = Color(hex: "#3B82F6")
    let primaryDark = Color(hex: "#1E40AF")
    
    // Secondary brand colors
    let secondary = Color(hex: "#059669")
    let secondaryLight = Color(hex: "#10B981")
    let secondaryDark = Color(hex: "#047857")
    
    // Accent colors
    let accent = Color(hex: "#F59E0B")
    let accentLight = Color(hex: "#FBBF24")
    let accentDark = Color(hex: "#D97706")
    
    // Neutral colors
    let background = Color(hex: "#F8FAFC")
    let surface = Color.white
    let text = Color(hex: "#1F2937")
    let textSecondary = Color(hex: "#6B7280")
    let border = Color(hex: "#E5E7EB")
    
    // Semantic colors
    let success = Color(hex: "#10B981")
    let warning = Color(hex: "#F59E0B")
    let error = Color(hex: "#EF4444")
    let info = Color(hex: "#3B82F6")
}
```

### **Gradient Customization**
```swift
struct CustomGradients {
    static let primaryGradient = LinearGradient(
        colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let secondaryGradient = LinearGradient(
        colors: [Color(hex: "#f093fb"), Color(hex: "#f5576c")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let accentGradient = LinearGradient(
        colors: [Color(hex: "#4facfe"), Color(hex: "#00f2fe")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let radialGradient = RadialGradient(
        colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
        center: .center,
        startRadius: 0,
        endRadius: 200
    )
}
```

### **Color Utilities**
```swift
extension Color {
    // Create color from hex
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    // Create color with opacity
    func withOpacity(_ opacity: Double) -> Color {
        self.opacity(opacity)
    }
    
    // Create lighter version
    func lighter(by percentage: CGFloat = 0.2) -> Color {
        return self.adjustBrightness(by: percentage)
    }
    
    // Create darker version
    func darker(by percentage: CGFloat = 0.2) -> Color {
        return self.adjustBrightness(by: -percentage)
    }
}
```

## 📝 Typography Customization

### **Custom Font System**
```swift
struct CustomFontSystem {
    // Display fonts
    static let displayLarge = Font.custom("Inter-Bold", size: 48)
    static let displayMedium = Font.custom("Inter-Bold", size: 36)
    static let displaySmall = Font.custom("Inter-Bold", size: 24)
    
    // Heading fonts
    static let h1 = Font.custom("Inter-SemiBold", size: 32)
    static let h2 = Font.custom("Inter-SemiBold", size: 28)
    static let h3 = Font.custom("Inter-Medium", size: 24)
    static let h4 = Font.custom("Inter-Medium", size: 20)
    
    // Body fonts
    static let bodyLarge = Font.custom("Inter-Regular", size: 18)
    static let body = Font.custom("Inter-Regular", size: 16)
    static let bodySmall = Font.custom("Inter-Regular", size: 14)
    
    // Caption fonts
    static let caption = Font.custom("Inter-Regular", size: 12)
    static let captionSmall = Font.custom("Inter-Regular", size: 10)
    
    // Button fonts
    static let button = Font.custom("Inter-SemiBold", size: 16)
    static let buttonSmall = Font.custom("Inter-SemiBold", size: 14)
}
```

### **Dynamic Type Support**
```swift
struct DynamicFontSystem {
    // Large text
    static let largeTitle = Font.largeTitle.weight(.bold)
    static let title1 = Font.title.weight(.semibold)
    static let title2 = Font.title2.weight(.medium)
    static let title3 = Font.title3.weight(.medium)
    
    // Body text
    static let headline = Font.headline.weight(.semibold)
    static let body = Font.body.weight(.regular)
    static let callout = Font.callout.weight(.regular)
    static let subheadline = Font.subheadline.weight(.medium)
    static let footnote = Font.footnote.weight(.regular)
    static let caption1 = Font.caption.weight(.regular)
    static let caption2 = Font.caption2.weight(.regular)
}
```

### **Font Utilities**
```swift
extension Font {
    // Custom font with weight
    static func custom(_ name: String, size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return Font.custom(name, size: size, relativeTo: .body)
    }
    
    // Responsive font
    static func responsive(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return Font.system(size: size, weight: weight, design: .default)
    }
    
    // Monospace font
    static func monospace(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return Font.system(size: size, weight: weight, design: .monospaced)
    }
}
```

## 🎭 Animation Customization

### **Custom Animations**
```swift
struct CustomAnimations {
    // Easing functions
    static let easeInOut = Animation.easeInOut(duration: 0.3)
    static let easeIn = Animation.easeIn(duration: 0.2)
    static let easeOut = Animation.easeOut(duration: 0.2)
    static let spring = Animation.spring(response: 0.5, dampingFraction: 0.8)
    
    // Custom durations
    static let fast = Animation.easeInOut(duration: 0.15)
    static let normal = Animation.easeInOut(duration: 0.3)
    static let slow = Animation.easeInOut(duration: 0.5)
    
    // Custom spring animations
    static let bouncy = Animation.spring(response: 0.3, dampingFraction: 0.6)
    static let smooth = Animation.spring(response: 0.5, dampingFraction: 0.9)
    static let snappy = Animation.spring(response: 0.2, dampingFraction: 0.7)
}
```

### **Animation Modifiers**
```swift
struct AnimationModifiers {
    // Scale animation
    static func scaleEffect(_ scale: CGFloat, isPressed: Bool) -> some ViewModifier {
        return ViewModifier { content in
            content
                .scaleEffect(isPressed ? scale : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
        }
    }
    
    // Rotation animation
    static func rotationEffect(_ angle: Angle, isActive: Bool) -> some ViewModifier {
        return ViewModifier { content in
            content
                .rotationEffect(isActive ? angle : .zero)
                .animation(.easeInOut(duration: 0.3), value: isActive)
        }
    }
    
    // Opacity animation
    static func opacityEffect(_ opacity: Double, isVisible: Bool) -> some ViewModifier {
        return ViewModifier { content in
            content
                .opacity(isVisible ? opacity : 0.0)
                .animation(.easeInOut(duration: 0.2), value: isVisible)
        }
    }
}
```

### **Transition Animations**
```swift
struct CustomTransitions {
    // Slide transitions
    static let slideFromLeft = AnyTransition.slide(edge: .leading)
    static let slideFromRight = AnyTransition.slide(edge: .trailing)
    static let slideFromTop = AnyTransition.slide(edge: .top)
    static let slideFromBottom = AnyTransition.slide(edge: .bottom)
    
    // Scale transitions
    static let scaleIn = AnyTransition.scale(scale: 0.8).combined(with: .opacity)
    static let scaleOut = AnyTransition.scale(scale: 1.2).combined(with: .opacity)
    
    // Custom transitions
    static let fadeIn = AnyTransition.opacity
    static let fadeOut = AnyTransition.opacity.combined(with: .scale(scale: 0.9))
}
```

## 📐 Layout Customization

### **Custom Spacing**
```swift
struct CustomSpacing {
    // Component spacing
    static let buttonSpacing: CGFloat = 12
    static let cardSpacing: CGFloat = 16
    static let listSpacing: CGFloat = 8
    static let sectionSpacing: CGFloat = 24
    
    // Screen spacing
    static let screenMargin: CGFloat = 20
    static let screenMarginLarge: CGFloat = 32
    
    // Content spacing
    static let contentSpacing: CGFloat = 16
    static let contentSpacingLarge: CGFloat = 24
    
    // Custom spacing
    static let tight: CGFloat = 4
    static let loose: CGFloat = 32
    static let extraLoose: CGFloat = 48
}
```

### **Layout Utilities**
```swift
struct LayoutUtilities {
    // Responsive layout
    static func responsiveLayout<T: View>(@ViewBuilder content: () -> T) -> some View {
        GeometryReader { geometry in
            content()
                .frame(maxWidth: geometry.size.width)
                .frame(maxHeight: geometry.size.height)
        }
    }
    
    // Aspect ratio layout
    static func aspectRatioLayout<T: View>(ratio: CGFloat, @ViewBuilder content: () -> T) -> some View {
        content()
            .aspectRatio(ratio, contentMode: .fit)
    }
    
    // Flexible layout
    static func flexibleLayout<T: View>(@ViewBuilder content: () -> T) -> some View {
        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
```

### **Grid Layout**
```swift
struct CustomGridLayout {
    static func adaptiveGrid(
        minimumWidth: CGFloat = 150,
        spacing: CGFloat = 16
    ) -> some Layout {
        return AdaptiveGridLayout(minimumWidth: minimumWidth, spacing: spacing)
    }
    
    static func fixedGrid(
        columns: Int,
        spacing: CGFloat = 16
    ) -> some Layout {
        return FixedGridLayout(columns: columns, spacing: spacing)
    }
}

struct AdaptiveGridLayout: Layout {
    let minimumWidth: CGFloat
    let spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // Implementation
        return CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Implementation
    }
}
```

## 🔧 Advanced Customization

### **Custom View Modifiers**
```swift
struct CustomViewModifiers {
    // Glass morphism effect
    static func glassMorphism() -> some ViewModifier {
        return ViewModifier { content in
            content
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
        }
    }
    
    // Neumorphism effect
    static func neumorphism(
        lightColor: Color = .white,
        darkColor: Color = .gray.opacity(0.3)
    ) -> some ViewModifier {
        return ViewModifier { content in
            content
                .background(lightColor)
                .cornerRadius(16)
                .shadow(color: darkColor, radius: 8, x: 4, y: 4)
                .shadow(color: lightColor, radius: 8, x: -4, y: -4)
        }
    }
    
    // Gradient border
    static func gradientBorder(
        colors: [Color],
        lineWidth: CGFloat = 2
    ) -> some ViewModifier {
        return ViewModifier { content in
            content
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing),
                            lineWidth: lineWidth
                        )
                )
        }
    }
}
```

### **Custom Environment Values**
```swift
struct CustomEnvironmentValues {
    // Custom theme
    struct ThemeKey: EnvironmentKey {
        static let defaultValue: AppTheme = .light
    }
    
    // Custom spacing
    struct SpacingKey: EnvironmentKey {
        static let defaultValue: CGFloat = 16
    }
    
    // Custom animation
    struct AnimationKey: EnvironmentKey {
        static let defaultValue: Animation = .easeInOut(duration: 0.3)
    }
}

extension EnvironmentValues {
    var customTheme: AppTheme {
        get { self[CustomEnvironmentValues.ThemeKey.self] }
        set { self[CustomEnvironmentValues.ThemeKey.self] = newValue }
    }
    
    var customSpacing: CGFloat {
        get { self[CustomEnvironmentValues.SpacingKey.self] }
        set { self[CustomEnvironmentValues.SpacingKey.self] = newValue }
    }
    
    var customAnimation: Animation {
        get { self[CustomEnvironmentValues.AnimationKey.self] }
        set { self[CustomEnvironmentValues.AnimationKey.self] = newValue }
    }
}
```

### **Custom Preference Keys**
```swift
struct CustomPreferenceKeys {
    // Size preference
    struct SizePreferenceKey: PreferenceKey {
        static var defaultValue: CGSize = .zero
        
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
    }
    
    // Position preference
    struct PositionPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint = .zero
        
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            value = nextValue()
        }
    }
}
```

## 📚 Next Steps

1. **Read [Getting Started](GettingStarted.md)** for quick setup
2. **Check [Component Guide](ComponentGuide.md)** for component usage
3. **Explore [Design System](DesignSystem.md)** for design principles
4. **Review [API Reference](API.md)** for complete documentation

## 🤝 Support

- **Documentation**: [Complete Documentation](Documentation/)
- **Issues**: [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- **Discussions**: [GitHub Discussions](https://github.com/muhittincamdali/iOSUIComponents/discussions)

---

**Happy customizing with iOS UI Components! 🎨** 