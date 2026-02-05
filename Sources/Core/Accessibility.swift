import UIKit

// MARK: - Accessibility Helpers
/// Comprehensive accessibility support for UIKit components
public struct AccessibilityHelper {
    
    // MARK: - Configuration
    
    /// Configure accessibility for a button
    public static func configureButton(
        _ button: UIView,
        label: String,
        hint: String? = nil,
        traits: UIAccessibilityTraits = .button,
        value: String? = nil
    ) {
        button.isAccessibilityElement = true
        button.accessibilityLabel = label
        button.accessibilityHint = hint
        button.accessibilityTraits = traits
        button.accessibilityValue = value
    }
    
    /// Configure accessibility for a text field
    public static func configureTextField(
        _ textField: UITextField,
        label: String,
        hint: String? = nil,
        error: String? = nil
    ) {
        textField.isAccessibilityElement = true
        textField.accessibilityLabel = label
        textField.accessibilityHint = hint
        
        if let error = error {
            textField.accessibilityValue = "Error: \(error)"
            textField.accessibilityTraits.insert(.notEnabled)
        }
    }
    
    /// Configure accessibility for a progress indicator
    public static func configureProgress(
        _ view: UIView,
        label: String,
        value: Double,
        maxValue: Double = 1.0
    ) {
        view.isAccessibilityElement = true
        view.accessibilityLabel = label
        view.accessibilityValue = "\(Int(value / maxValue * 100)) percent"
        view.accessibilityTraits = .updatesFrequently
    }
    
    /// Configure accessibility for a switch/toggle
    public static func configureToggle(
        _ toggle: UISwitch,
        label: String,
        hint: String? = nil
    ) {
        toggle.isAccessibilityElement = true
        toggle.accessibilityLabel = label
        toggle.accessibilityHint = hint
    }
    
    /// Configure accessibility for an image
    public static func configureImage(
        _ imageView: UIImageView,
        label: String,
        isDecorative: Bool = false
    ) {
        if isDecorative {
            imageView.isAccessibilityElement = false
        } else {
            imageView.isAccessibilityElement = true
            imageView.accessibilityLabel = label
            imageView.accessibilityTraits = .image
        }
    }
    
    /// Configure accessibility for a container
    public static func configureContainer(
        _ container: UIView,
        label: String,
        elements: [UIView]
    ) {
        container.isAccessibilityElement = false
        container.accessibilityElements = elements
        container.accessibilityLabel = label
    }
    
    // MARK: - Announcements
    
    /// Post an accessibility announcement
    public static func announce(_ message: String, delay: TimeInterval = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIAccessibility.post(notification: .announcement, argument: message)
        }
    }
    
    /// Announce screen change
    public static func announceScreenChange(_ message: String) {
        UIAccessibility.post(notification: .screenChanged, argument: message)
    }
    
    /// Announce layout change
    public static func announceLayoutChange(_ element: UIView?) {
        UIAccessibility.post(notification: .layoutChanged, argument: element)
    }
    
    // MARK: - Queries
    
    /// Check if VoiceOver is running
    public static var isVoiceOverRunning: Bool {
        UIAccessibility.isVoiceOverRunning
    }
    
    /// Check if reduce motion is enabled
    public static var isReduceMotionEnabled: Bool {
        UIAccessibility.isReduceMotionEnabled
    }
    
    /// Check if bold text is enabled
    public static var isBoldTextEnabled: Bool {
        UIAccessibility.isBoldTextEnabled
    }
    
    /// Check if larger text sizes are enabled
    public static var isLargerTextEnabled: Bool {
        UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
    }
    
    /// Check if dark mode is enabled
    public static var isDarkModeEnabled: Bool {
        if #available(iOS 13.0, *) {
            return UITraitCollection.current.userInterfaceStyle == .dark
        }
        return false
    }
}

// MARK: - Accessibility Protocol
/// Protocol for components that support accessibility
public protocol AccessibleComponent {
    var accessibilityConfig: AccessibilityConfiguration { get set }
    func configureAccessibility()
}

/// Configuration for accessibility
public struct AccessibilityConfiguration {
    public var label: String
    public var hint: String?
    public var value: String?
    public var traits: UIAccessibilityTraits
    public var customActions: [UIAccessibilityCustomAction]
    
    public init(
        label: String,
        hint: String? = nil,
        value: String? = nil,
        traits: UIAccessibilityTraits = .none,
        customActions: [UIAccessibilityCustomAction] = []
    ) {
        self.label = label
        self.hint = hint
        self.value = value
        self.traits = traits
        self.customActions = customActions
    }
}

// MARK: - UIView Accessibility Extension
public extension UIView {
    
    /// Configure accessibility in a builder pattern style
    @discardableResult
    func accessible(
        label: String,
        hint: String? = nil,
        traits: UIAccessibilityTraits = .none
    ) -> Self {
        self.isAccessibilityElement = true
        self.accessibilityLabel = label
        self.accessibilityHint = hint
        self.accessibilityTraits = traits
        return self
    }
    
    /// Hide from accessibility
    @discardableResult
    func accessibilityHidden() -> Self {
        self.isAccessibilityElement = false
        self.accessibilityElementsHidden = true
        return self
    }
    
    /// Group children for accessibility
    func groupAccessibilityElements() {
        self.shouldGroupAccessibilityChildren = true
    }
}

// MARK: - Dynamic Type Support
public extension UILabel {
    
    /// Configure label for dynamic type
    func configureDynamicType(
        style: UIFont.TextStyle,
        maximumPointSize: CGFloat? = nil
    ) {
        self.font = UIFont.preferredFont(forTextStyle: style)
        self.adjustsFontForContentSizeCategory = true
        
        if let maxSize = maximumPointSize {
            self.font = UIFontMetrics(forTextStyle: style)
                .scaledFont(for: self.font, maximumPointSize: maxSize)
        }
    }
}

public extension UIButton {
    
    /// Configure button title for dynamic type
    func configureDynamicType(style: UIFont.TextStyle) {
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: style)
        self.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}

// MARK: - Minimum Touch Target
public extension UIView {
    
    /// Ensure minimum touch target size (44x44 points per Apple HIG)
    func ensureMinimumTouchTarget() {
        if bounds.width < 44 {
            widthAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        }
        if bounds.height < 44 {
            heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        }
    }
}

// MARK: - Color Contrast Checker
public struct ContrastChecker {
    
    /// Calculate contrast ratio between two colors
    public static func contrastRatio(
        foreground: UIColor,
        background: UIColor
    ) -> CGFloat {
        let fgLuminance = relativeLuminance(of: foreground)
        let bgLuminance = relativeLuminance(of: background)
        
        let lighter = max(fgLuminance, bgLuminance)
        let darker = min(fgLuminance, bgLuminance)
        
        return (lighter + 0.05) / (darker + 0.05)
    }
    
    /// Check if contrast ratio meets WCAG AA requirements (4.5:1 for normal text)
    public static func meetsWCAG_AA(
        foreground: UIColor,
        background: UIColor,
        largeText: Bool = false
    ) -> Bool {
        let ratio = contrastRatio(foreground: foreground, background: background)
        return ratio >= (largeText ? 3.0 : 4.5)
    }
    
    /// Check if contrast ratio meets WCAG AAA requirements (7:1 for normal text)
    public static func meetsWCAG_AAA(
        foreground: UIColor,
        background: UIColor,
        largeText: Bool = false
    ) -> Bool {
        let ratio = contrastRatio(foreground: foreground, background: background)
        return ratio >= (largeText ? 4.5 : 7.0)
    }
    
    private static func relativeLuminance(of color: UIColor) -> CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        func adjust(_ component: CGFloat) -> CGFloat {
            return component <= 0.03928
                ? component / 12.92
                : pow((component + 0.055) / 1.055, 2.4)
        }
        
        return 0.2126 * adjust(red) + 0.7152 * adjust(green) + 0.0722 * adjust(blue)
    }
}
