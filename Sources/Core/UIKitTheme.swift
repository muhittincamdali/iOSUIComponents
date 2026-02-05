import UIKit

// MARK: - Theme Protocol
/// Protocol defining a theme for UIKit components
public protocol UIKitTheme {
    // Colors
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var accentColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var surfaceColor: UIColor { get }
    var errorColor: UIColor { get }
    var successColor: UIColor { get }
    var warningColor: UIColor { get }
    var textPrimaryColor: UIColor { get }
    var textSecondaryColor: UIColor { get }
    var borderColor: UIColor { get }
    var shadowColor: UIColor { get }
    
    // Typography
    var fontRegular: UIFont { get }
    var fontMedium: UIFont { get }
    var fontSemibold: UIFont { get }
    var fontBold: UIFont { get }
    
    // Dimensions
    var cornerRadiusSmall: CGFloat { get }
    var cornerRadiusMedium: CGFloat { get }
    var cornerRadiusLarge: CGFloat { get }
    var spacingXS: CGFloat { get }
    var spacingS: CGFloat { get }
    var spacingM: CGFloat { get }
    var spacingL: CGFloat { get }
    var spacingXL: CGFloat { get }
    
    // Animation
    var animationDuration: TimeInterval { get }
    var animationCurve: UIView.AnimationCurve { get }
}

// MARK: - Default Theme
public struct DefaultTheme: UIKitTheme {
    public static let shared = DefaultTheme()
    
    // Colors
    public var primaryColor: UIColor { UIColor.systemBlue }
    public var secondaryColor: UIColor { UIColor.systemGray }
    public var accentColor: UIColor { UIColor.systemIndigo }
    public var backgroundColor: UIColor { UIColor.systemBackground }
    public var surfaceColor: UIColor { UIColor.secondarySystemBackground }
    public var errorColor: UIColor { UIColor.systemRed }
    public var successColor: UIColor { UIColor.systemGreen }
    public var warningColor: UIColor { UIColor.systemOrange }
    public var textPrimaryColor: UIColor { UIColor.label }
    public var textSecondaryColor: UIColor { UIColor.secondaryLabel }
    public var borderColor: UIColor { UIColor.separator }
    public var shadowColor: UIColor { UIColor.black.withAlphaComponent(0.1) }
    
    // Typography
    public var fontRegular: UIFont { .systemFont(ofSize: 16, weight: .regular) }
    public var fontMedium: UIFont { .systemFont(ofSize: 16, weight: .medium) }
    public var fontSemibold: UIFont { .systemFont(ofSize: 16, weight: .semibold) }
    public var fontBold: UIFont { .systemFont(ofSize: 16, weight: .bold) }
    
    // Dimensions
    public var cornerRadiusSmall: CGFloat { 4 }
    public var cornerRadiusMedium: CGFloat { 8 }
    public var cornerRadiusLarge: CGFloat { 12 }
    public var spacingXS: CGFloat { 4 }
    public var spacingS: CGFloat { 8 }
    public var spacingM: CGFloat { 16 }
    public var spacingL: CGFloat { 24 }
    public var spacingXL: CGFloat { 32 }
    
    // Animation
    public var animationDuration: TimeInterval { 0.25 }
    public var animationCurve: UIView.AnimationCurve { .easeInOut }
    
    private init() {}
}

// MARK: - Dark Theme
public struct DarkTheme: UIKitTheme {
    public static let shared = DarkTheme()
    
    public var primaryColor: UIColor { UIColor(red: 0.38, green: 0.62, blue: 1.0, alpha: 1.0) }
    public var secondaryColor: UIColor { UIColor.systemGray }
    public var accentColor: UIColor { UIColor.systemPurple }
    public var backgroundColor: UIColor { UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.0) }
    public var surfaceColor: UIColor { UIColor(red: 0.17, green: 0.17, blue: 0.18, alpha: 1.0) }
    public var errorColor: UIColor { UIColor(red: 1.0, green: 0.45, blue: 0.45, alpha: 1.0) }
    public var successColor: UIColor { UIColor(red: 0.45, green: 0.9, blue: 0.55, alpha: 1.0) }
    public var warningColor: UIColor { UIColor(red: 1.0, green: 0.75, blue: 0.35, alpha: 1.0) }
    public var textPrimaryColor: UIColor { UIColor.white }
    public var textSecondaryColor: UIColor { UIColor(white: 0.7, alpha: 1.0) }
    public var borderColor: UIColor { UIColor(white: 0.3, alpha: 1.0) }
    public var shadowColor: UIColor { UIColor.black.withAlphaComponent(0.3) }
    
    public var fontRegular: UIFont { .systemFont(ofSize: 16, weight: .regular) }
    public var fontMedium: UIFont { .systemFont(ofSize: 16, weight: .medium) }
    public var fontSemibold: UIFont { .systemFont(ofSize: 16, weight: .semibold) }
    public var fontBold: UIFont { .systemFont(ofSize: 16, weight: .bold) }
    
    public var cornerRadiusSmall: CGFloat { 4 }
    public var cornerRadiusMedium: CGFloat { 8 }
    public var cornerRadiusLarge: CGFloat { 12 }
    public var spacingXS: CGFloat { 4 }
    public var spacingS: CGFloat { 8 }
    public var spacingM: CGFloat { 16 }
    public var spacingL: CGFloat { 24 }
    public var spacingXL: CGFloat { 32 }
    
    public var animationDuration: TimeInterval { 0.25 }
    public var animationCurve: UIView.AnimationCurve { .easeInOut }
    
    private init() {}
}

// MARK: - Theme Manager
/// Singleton class for managing app-wide theming
public final class ThemeManager {
    public static let shared = ThemeManager()
    
    public var currentTheme: UIKitTheme = DefaultTheme.shared {
        didSet {
            NotificationCenter.default.post(name: .themeDidChange, object: nil)
        }
    }
    
    private init() {}
    
    /// Apply theme to all registered components
    public func applyTheme(_ theme: UIKitTheme) {
        currentTheme = theme
        configureGlobalAppearance()
    }
    
    /// Configure global UIKit appearance proxies
    public func configureGlobalAppearance() {
        UINavigationBar.appearance().tintColor = currentTheme.primaryColor
        UITabBar.appearance().tintColor = currentTheme.primaryColor
        UISwitch.appearance().onTintColor = currentTheme.primaryColor
        UISlider.appearance().minimumTrackTintColor = currentTheme.primaryColor
        UIProgressView.appearance().progressTintColor = currentTheme.primaryColor
    }
}

// MARK: - Notification Names
public extension Notification.Name {
    static let themeDidChange = Notification.Name("UIKitThemeDidChange")
}

// MARK: - UIColor Helpers
public extension UIColor {
    /// Create color from hex string
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// Adjust brightness of color
    func adjustBrightness(by factor: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
    }
}
