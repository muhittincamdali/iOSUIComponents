import SwiftUI

// MARK: - iOS UI Components
public struct iOSUIComponents {
    
    // MARK: - Version
    public static let version = "1.0.0"
    
    // MARK: - Initialize
    public static func initialize() {
        print("iOS UI Components initialized - Version \(version)")
    }
}

// MARK: - Design System
public struct DesignSystem {
    
    // MARK: - Colors
    public struct Colors {
        // Primary Colors
        public static let primary = Color(hex: "#007AFF")
        public static let primaryDark = Color(hex: "#0056CC")
        public static let primaryLight = Color(hex: "#4DA3FF")
        
        // Secondary Colors
        public static let secondary = Color(hex: "#5856D6")
        public static let secondaryDark = Color(hex: "#3634A3")
        public static let secondaryLight = Color(hex: "#7B7AFF")
        
        // Accent Colors
        public static let accent = Color(hex: "#FF9500")
        public static let accentDark = Color(hex: "#CC7700")
        public static let accentLight = Color(hex: "#FFB340")
        
        // Success Colors
        public static let success = Color(hex: "#34C759")
        public static let successDark = Color(hex: "#28A745")
        public static let successLight = Color(hex: "#5CDB95")
        
        // Warning Colors
        public static let warning = Color(hex: "#FF9500")
        public static let warningDark = Color(hex: "#CC7700")
        public static let warningLight = Color(hex: "#FFB340")
        
        // Error Colors
        public static let error = Color(hex: "#FF3B30")
        public static let errorDark = Color(hex: "#CC2E26")
        public static let errorLight = Color(hex: "#FF6B61")
        
        // Neutral Colors
        public static let background = Color(hex: "#F2F2F7")
        public static let surface = Color.white
        public static let text = Color(hex: "#1C1C1E")
        public static let textSecondary = Color(hex: "#8E8E93")
        public static let textTertiary = Color(hex: "#C7C7CC")
        
        // System Colors
        public static let systemBackground = Color(.systemBackground)
        public static let systemGroupedBackground = Color(.systemGroupedBackground)
        public static let systemGray = Color(.systemGray)
        public static let systemGray2 = Color(.systemGray2)
        public static let systemGray3 = Color(.systemGray3)
        public static let systemGray4 = Color(.systemGray4)
        public static let systemGray5 = Color(.systemGray5)
        public static let systemGray6 = Color(.systemGray6)
    }
    
    // MARK: - Typography
    public struct Typography {
        // Headings
        public static let h1 = Font.system(size: 32, weight: .bold)
        public static let h2 = Font.system(size: 28, weight: .semibold)
        public static let h3 = Font.system(size: 24, weight: .medium)
        public static let h4 = Font.system(size: 20, weight: .semibold)
        public static let h5 = Font.system(size: 18, weight: .medium)
        public static let h6 = Font.system(size: 16, weight: .semibold)
        
        // Body Text
        public static let bodyLarge = Font.system(size: 18, weight: .regular)
        public static let body = Font.system(size: 16, weight: .regular)
        public static let bodySmall = Font.system(size: 14, weight: .regular)
        
        // Captions
        public static let caption = Font.system(size: 12, weight: .regular)
        public static let captionSmall = Font.system(size: 10, weight: .regular)
        
        // Buttons
        public static let button = Font.system(size: 16, weight: .semibold)
        public static let buttonSmall = Font.system(size: 14, weight: .medium)
    }
    
    // MARK: - Spacing
    public struct Spacing {
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 16
        public static let lg: CGFloat = 24
        public static let xl: CGFloat = 32
        public static let xxl: CGFloat = 48
    }
    
    // MARK: - Border Radius
    public struct BorderRadius {
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 12
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 20
        public static let xxl: CGFloat = 24
        public static let round: CGFloat = 50
    }
    
    // MARK: - Shadows
    public struct Shadows {
        public static let small = Shadow(
            color: .black.opacity(0.1),
            radius: 2,
            x: 0,
            y: 1
        )
        
        public static let medium = Shadow(
            color: .black.opacity(0.15),
            radius: 4,
            x: 0,
            y: 2
        )
        
        public static let large = Shadow(
            color: .black.opacity(0.2),
            radius: 8,
            x: 0,
            y: 4
        )
        
        public static let extraLarge = Shadow(
            color: .black.opacity(0.25),
            radius: 16,
            x: 0,
            y: 8
        )
    }
}

// MARK: - Shadow
public struct Shadow {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat
    
    public init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
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
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            alpha: Double(a) / 255
        )
    }
}

// MARK: - View Extensions
public extension View {
    func applyShadow(_ shadow: Shadow) -> some View {
        self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
    
    func applyShadow(_ shadow: Shadow, condition: Bool) -> some View {
        self.shadow(
            color: condition ? shadow.color : .clear,
            radius: condition ? shadow.radius : 0,
            x: condition ? shadow.x : 0,
            y: condition ? shadow.y : 0
        )
    }
}

// MARK: - Theme Support
public struct Theme {
    public let colors: ColorPalette
    public let typography: TypographyPalette
    public let spacing: SpacingPalette
    
    public init(
        colors: ColorPalette,
        typography: TypographyPalette,
        spacing: SpacingPalette
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
    }
}

public struct ColorPalette {
    public let primary: Color
    public let secondary: Color
    public let accent: Color
    public let background: Color
    public let surface: Color
    public let text: Color
    public let textSecondary: Color
    
    public init(
        primary: Color,
        secondary: Color,
        accent: Color,
        background: Color,
        surface: Color,
        text: Color,
        textSecondary: Color
    ) {
        self.primary = primary
        self.secondary = secondary
        self.accent = accent
        self.background = background
        self.surface = surface
        self.text = text
        self.textSecondary = textSecondary
    }
}

public struct TypographyPalette {
    public let h1: Font
    public let h2: Font
    public let h3: Font
    public let body: Font
    public let caption: Font
    public let button: Font
    
    public init(
        h1: Font,
        h2: Font,
        h3: Font,
        body: Font,
        caption: Font,
        button: Font
    ) {
        self.h1 = h1
        self.h2 = h2
        self.h3 = h3
        self.body = body
        self.caption = caption
        self.button = button
    }
}

public struct SpacingPalette {
    public let xs: CGFloat
    public let sm: CGFloat
    public let md: CGFloat
    public let lg: CGFloat
    public let xl: CGFloat
    
    public init(
        xs: CGFloat,
        sm: CGFloat,
        md: CGFloat,
        lg: CGFloat,
        xl: CGFloat
    ) {
        self.xs = xs
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
    }
}

// MARK: - Default Themes
public extension Theme {
    static let light = Theme(
        colors: ColorPalette(
            primary: DesignSystem.Colors.primary,
            secondary: DesignSystem.Colors.secondary,
            accent: DesignSystem.Colors.accent,
            background: DesignSystem.Colors.background,
            surface: DesignSystem.Colors.surface,
            text: DesignSystem.Colors.text,
            textSecondary: DesignSystem.Colors.textSecondary
        ),
        typography: TypographyPalette(
            h1: DesignSystem.Typography.h1,
            h2: DesignSystem.Typography.h2,
            h3: DesignSystem.Typography.h3,
            body: DesignSystem.Typography.body,
            caption: DesignSystem.Typography.caption,
            button: DesignSystem.Typography.button
        ),
        spacing: SpacingPalette(
            xs: DesignSystem.Spacing.xs,
            sm: DesignSystem.Spacing.sm,
            md: DesignSystem.Spacing.md,
            lg: DesignSystem.Spacing.lg,
            xl: DesignSystem.Spacing.xl
        )
    )
    
    static let dark = Theme(
        colors: ColorPalette(
            primary: DesignSystem.Colors.primaryLight,
            secondary: DesignSystem.Colors.secondaryLight,
            accent: DesignSystem.Colors.accentLight,
            background: Color.black,
            surface: Color(hex: "#1C1C1E"),
            text: Color.white,
            textSecondary: Color(hex: "#8E8E93")
        ),
        typography: TypographyPalette(
            h1: DesignSystem.Typography.h1,
            h2: DesignSystem.Typography.h2,
            h3: DesignSystem.Typography.h3,
            body: DesignSystem.Typography.body,
            caption: DesignSystem.Typography.caption,
            button: DesignSystem.Typography.button
        ),
        spacing: SpacingPalette(
            xs: DesignSystem.Spacing.xs,
            sm: DesignSystem.Spacing.sm,
            md: DesignSystem.Spacing.md,
            lg: DesignSystem.Spacing.lg,
            xl: DesignSystem.Spacing.xl
        )
    )
} 