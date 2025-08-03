import SwiftUI

// MARK: - iOS UI Components
public struct iOSUIComponents {
    
    // MARK: - Version
    public static let version = "1.0.0"
    
    // MARK: - Initialization
    public static func initialize() {
        print("🎨 iOS UI Components v\(version) initialized")
    }
}

// MARK: - Design System
public struct DesignSystem {
    
    // MARK: - Colors
    public struct Colors {
        // Primary Colors
        public static let primary = Color("PrimaryColor")
        public static let primaryLight = Color("PrimaryLightColor")
        public static let primaryDark = Color("PrimaryDarkColor")
        
        // Secondary Colors
        public static let secondary = Color("SecondaryColor")
        public static let secondaryLight = Color("SecondaryLightColor")
        public static let secondaryDark = Color("SecondaryDarkColor")
        
        // Accent Colors
        public static let accent = Color("AccentColor")
        public static let accentLight = Color("AccentLightColor")
        public static let accentDark = Color("AccentDarkColor")
        
        // Semantic Colors
        public static let success = Color("SuccessColor")
        public static let warning = Color("WarningColor")
        public static let error = Color("ErrorColor")
        public static let info = Color("InfoColor")
        
        // Neutral Colors
        public static let background = Color("BackgroundColor")
        public static let surface = Color("SurfaceColor")
        public static let text = Color("TextColor")
        public static let textSecondary = Color("TextSecondaryColor")
        public static let border = Color("BorderColor")
        public static let divider = Color("DividerColor")
        
        // Status Colors
        public static let online = Color("OnlineColor")
        public static let offline = Color("OfflineColor")
        public static let busy = Color("BusyColor")
        public static let away = Color("AwayColor")
    }
    
    // MARK: - Typography
    public struct Typography {
        // Font Sizes
        public static let displayLarge: CGFloat = 57
        public static let displayMedium: CGFloat = 45
        public static let displaySmall: CGFloat = 36
        public static let headlineLarge: CGFloat = 32
        public static let headlineMedium: CGFloat = 28
        public static let headlineSmall: CGFloat = 24
        public static let titleLarge: CGFloat = 22
        public static let titleMedium: CGFloat = 16
        public static let titleSmall: CGFloat = 14
        public static let bodyLarge: CGFloat = 16
        public static let bodyMedium: CGFloat = 14
        public static let bodySmall: CGFloat = 12
        public static let labelLarge: CGFloat = 14
        public static let labelMedium: CGFloat = 12
        public static let labelSmall: CGFloat = 11
        
        // Font Weights
        public static let light = Font.Weight.light
        public static let regular = Font.Weight.regular
        public static let medium = Font.Weight.medium
        public static let semibold = Font.Weight.semibold
        public static let bold = Font.Weight.bold
        public static let heavy = Font.Weight.heavy
        
        // Line Heights
        public static let lineHeightTight: CGFloat = 1.2
        public static let lineHeightNormal: CGFloat = 1.4
        public static let lineHeightRelaxed: CGFloat = 1.6
        public static let lineHeightLoose: CGFloat = 1.8
    }
    
    // MARK: - Spacing
    public struct Spacing {
        // Base Spacing
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 16
        public static let lg: CGFloat = 24
        public static let xl: CGFloat = 32
        public static let xxl: CGFloat = 48
        public static let xxxl: CGFloat = 64
        
        // Component Spacing
        public static let buttonPadding: CGFloat = 16
        public static let cardPadding: CGFloat = 16
        public static let listItemSpacing: CGFloat = 8
        public static let sectionSpacing: CGFloat = 24
        public static let screenPadding: CGFloat = 16
        public static let modalPadding: CGFloat = 24
    }
    
    // MARK: - Border Radius
    public struct BorderRadius {
        // Base Radius
        public static let none: CGFloat = 0
        public static let xs: CGFloat = 2
        public static let sm: CGFloat = 4
        public static let md: CGFloat = 8
        public static let lg: CGFloat = 12
        public static let xl: CGFloat = 16
        public static let xxl: CGFloat = 24
        public static let full: CGFloat = 999
        
        // Component Radius
        public static let button: CGFloat = 8
        public static let card: CGFloat = 12
        public static let input: CGFloat = 8
        public static let avatar: CGFloat = 50
        public static let badge: CGFloat = 12
        public static let modal: CGFloat = 16
    }
    
    // MARK: - Shadows
    public struct Shadows {
        // Shadow Levels
        public static let none = Shadow(radius: 0, x: 0, y: 0, opacity: 0)
        public static let sm = Shadow(radius: 1, x: 0, y: 1, opacity: 0.05)
        public static let md = Shadow(radius: 4, x: 0, y: 2, opacity: 0.1)
        public static let lg = Shadow(radius: 8, x: 0, y: 4, opacity: 0.15)
        public static let xl = Shadow(radius: 16, x: 0, y: 8, opacity: 0.2)
        public static let xxl = Shadow(radius: 24, x: 0, y: 12, opacity: 0.25)
        
        // Component Shadows
        public static let button = md
        public static let card = lg
        public static let modal = xl
        public static let dropdown = md
        public static let tooltip = sm
    }
}

// MARK: - Shadow
public struct Shadow {
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat
    public let opacity: Double
    
    public init(radius: CGFloat, x: CGFloat, y: CGFloat, opacity: Double) {
        self.radius = radius
        self.x = x
        self.y = y
        self.opacity = opacity
    }
}

// MARK: - Theme
public struct Theme {
    public let colors: ColorPalette
    public let typography: TypographyPalette
    public let spacing: SpacingPalette
    
    public init(colors: ColorPalette, typography: TypographyPalette, spacing: SpacingPalette) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
    }
}

// MARK: - Color Palette
public protocol ColorPalette {
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

// MARK: - Typography Palette
public protocol TypographyPalette {
    var displayLarge: Font { get }
    var displayMedium: Font { get }
    var displaySmall: Font { get }
    var headlineLarge: Font { get }
    var headlineMedium: Font { get }
    var headlineSmall: Font { get }
    var titleLarge: Font { get }
    var titleMedium: Font { get }
    var titleSmall: Font { get }
    var bodyLarge: Font { get }
    var bodyMedium: Font { get }
    var bodySmall: Font { get }
    var labelLarge: Font { get }
    var labelMedium: Font { get }
    var labelSmall: Font { get }
}

// MARK: - Spacing Palette
public protocol SpacingPalette {
    var xs: CGFloat { get }
    var sm: CGFloat { get }
    var md: CGFloat { get }
    var lg: CGFloat { get }
    var xl: CGFloat { get }
    var xxl: CGFloat { get }
    var xxxl: CGFloat { get }
}

// MARK: - Default Themes
public extension Theme {
    static let light = Theme(
        colors: LightColorPalette(),
        typography: DefaultTypographyPalette(),
        spacing: DefaultSpacingPalette()
    )
    
    static let dark = Theme(
        colors: DarkColorPalette(),
        typography: DefaultTypographyPalette(),
        spacing: DefaultSpacingPalette()
    )
}

// MARK: - Light Color Palette
public struct LightColorPalette: ColorPalette {
    public let primary = Color.blue
    public let secondary = Color.gray
    public let accent = Color.orange
    public let background = Color.white
    public let surface = Color.gray.opacity(0.1)
    public let text = Color.black
    public let textSecondary = Color.gray
    public let border = Color.gray.opacity(0.1)
    public let success = Color.green
    public let warning = Color.orange
    public let error = Color.red
}

// MARK: - Dark Color Palette
public struct DarkColorPalette: ColorPalette {
    public let primary = Color.blue
    public let secondary = Color.gray
    public let accent = Color.orange
    public let background = Color.black
    public let surface = Color.gray.opacity(0.1)
    public let text = Color.white
    public let textSecondary = Color.gray
    public let border = Color.gray.opacity(0.1)
    public let success = Color.green
    public let warning = Color.orange
    public let error = Color.red
}

// MARK: - Default Typography Palette
public struct DefaultTypographyPalette: TypographyPalette {
    public let displayLarge = Font.system(size: DesignSystem.Typography.displayLarge, weight: .bold)
    public let displayMedium = Font.system(size: DesignSystem.Typography.displayMedium, weight: .bold)
    public let displaySmall = Font.system(size: DesignSystem.Typography.displaySmall, weight: .bold)
    public let headlineLarge = Font.system(size: DesignSystem.Typography.headlineLarge, weight: .semibold)
    public let headlineMedium = Font.system(size: DesignSystem.Typography.headlineMedium, weight: .semibold)
    public let headlineSmall = Font.system(size: DesignSystem.Typography.headlineSmall, weight: .semibold)
    public let titleLarge = Font.system(size: DesignSystem.Typography.titleLarge, weight: .medium)
    public let titleMedium = Font.system(size: DesignSystem.Typography.titleMedium, weight: .medium)
    public let titleSmall = Font.system(size: DesignSystem.Typography.titleSmall, weight: .medium)
    public let bodyLarge = Font.system(size: DesignSystem.Typography.bodyLarge, weight: .regular)
    public let bodyMedium = Font.system(size: DesignSystem.Typography.bodyMedium, weight: .regular)
    public let bodySmall = Font.system(size: DesignSystem.Typography.bodySmall, weight: .regular)
    public let labelLarge = Font.system(size: DesignSystem.Typography.labelLarge, weight: .medium)
    public let labelMedium = Font.system(size: DesignSystem.Typography.labelMedium, weight: .medium)
    public let labelSmall = Font.system(size: DesignSystem.Typography.labelSmall, weight: .medium)
}

// MARK: - Default Spacing Palette
public struct DefaultSpacingPalette: SpacingPalette {
    public let xs = DesignSystem.Spacing.xs
    public let sm = DesignSystem.Spacing.sm
    public let md = DesignSystem.Spacing.md
    public let lg = DesignSystem.Spacing.lg
    public let xl = DesignSystem.Spacing.xl
    public let xxl = DesignSystem.Spacing.xxl
    public let xxxl = DesignSystem.Spacing.xxxl
}

// MARK: - Color Extensions
public extension Color {
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
}

// MARK: - View Extensions
public extension View {
    func applyShadow(_ shadow: Shadow) -> some View {
        self.shadow(
            color: .black.opacity(shadow.opacity),
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
    
    func applyCornerRadius(_ radius: CGFloat) -> some View {
        self.cornerRadius(radius)
    }
    
    func applyPadding(_ padding: CGFloat) -> some View {
        self.padding(padding)
    }
    
    func applyBackground(_ color: Color) -> some View {
        self.background(color)
    }
    
    func applyBorder(_ color: Color, width: CGFloat = 1) -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(color, lineWidth: width)
        )
    }
} 