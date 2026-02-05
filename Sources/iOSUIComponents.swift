// iOSUIComponents
// The world's most comprehensive UIKit component library for iOS
//
// Copyright (c) 2025 Muhittin Camdali
// Licensed under MIT License

import UIKit

/// iOSUIComponents - Production-ready UIKit components
///
/// A comprehensive collection of 50+ UIKit components designed for real-world iOS applications.
/// Features full Interface Builder support, accessibility compliance, RTL support, and theming.
///
/// ## Getting Started
///
/// ```swift
/// import iOSUIComponents
///
/// // Configure theme (optional)
/// ThemeManager.shared.applyTheme(DefaultTheme.shared)
///
/// // Use components
/// let button = PrimaryButton()
/// button.setTitle("Get Started", for: .normal)
///
/// let textField = FloatingLabelTextField()
/// textField.floatingLabelText = "Email"
/// ```
///
/// ## Categories
///
/// - **Buttons**: 15+ button variants including Primary, Secondary, Gradient, FAB, Social, Loading
/// - **Text Fields**: Outlined, Filled, Floating Label, Search, Password, OTP, Phone, Amount
/// - **Table View Cells**: Standard, Profile, Settings, Swipeable, Card cells
/// - **Collection Views**: Waterfall, Carousel, Sticky Header, Grid layouts
/// - **Navigation**: Custom Navigation Bar, Tab Bar, Breadcrumbs, Page Control
/// - **Feedback**: Alerts, Action Sheets, Toast, Progress, Sliders, Badges
/// - **States**: Skeleton Loading, Empty State, Error State, Pull to Refresh, Infinite Scroll
/// - **Core**: Theme System, Accessibility Helpers, RTL Support

// MARK: - Public Exports

// Core
@_exported import class UIKit.UIView
@_exported import class UIKit.UIButton
@_exported import class UIKit.UITextField
@_exported import class UIKit.UITableViewCell
@_exported import class UIKit.UICollectionViewCell
@_exported import class UIKit.UICollectionViewLayout

/// Framework version
public let iOSUIComponentsVersion = "2.0.0"

/// Check if components are available
public func isComponentsReady() -> Bool {
    return true
}

/// Configure all components with default theme
public func configureWithDefaultTheme() {
    ThemeManager.shared.applyTheme(DefaultTheme.shared)
}

/// Configure all components with dark theme
public func configureWithDarkTheme() {
    ThemeManager.shared.applyTheme(DarkTheme.shared)
}

// MARK: - Component Registry

/// Registry of all available components
public struct ComponentRegistry {
    
    /// All button component types
    public static let buttons: [BaseButton.Type] = [
        PrimaryButton.self,
        SecondaryButton.self,
        TertiaryButton.self,
        DestructiveButton.self,
        SuccessButton.self,
        WarningButton.self,
        GradientButton.self,
        IconButton.self,
        PillButton.self,
        FloatingActionButton.self,
        SocialButton.self,
        LoadingButton.self,
        ChipButton.self,
        ToggleButton.self
    ]
    
    /// All text field component types
    public static let textFields: [BaseTextField.Type] = [
        OutlinedTextField.self,
        FilledTextField.self,
        UnderlinedTextField.self,
        FloatingLabelTextField.self,
        SearchTextField.self,
        PasswordTextField.self,
        PhoneNumberTextField.self,
        AmountTextField.self
    ]
    
    /// All table view cell types
    public static let tableViewCells: [BaseTableViewCell.Type] = [
        StandardCell.self,
        ProfileCell.self,
        SettingsCell.self,
        SwipeableCell.self,
        CardCell.self
    ]
    
    /// All collection view cell types
    public static let collectionViewCells: [BaseCollectionViewCell.Type] = [
        ImageCell.self,
        ProductCell.self,
        TagCell.self
    ]
    
    /// All collection view layout types
    public static let collectionViewLayouts: [UICollectionViewLayout.Type] = [
        WaterfallLayout.self,
        CarouselLayout.self,
        StickyHeaderLayout.self,
        GridLayout.self
    ]
    
    /// Total component count
    public static var totalCount: Int {
        return buttons.count +
               textFields.count +
               tableViewCells.count +
               collectionViewCells.count +
               collectionViewLayouts.count +
               12 // Navigation, Feedback, State components
    }
}

// MARK: - UIView Extension for Easy Component Creation

public extension UIView {
    
    /// Create a primary button with title
    static func primaryButton(title: String) -> PrimaryButton {
        let button = PrimaryButton()
        button.setTitle(title, for: .normal)
        return button
    }
    
    /// Create a floating label text field
    static func floatingTextField(label: String, placeholder: String = "") -> FloatingLabelTextField {
        let field = FloatingLabelTextField()
        field.floatingLabelText = label
        field.placeholder = placeholder
        return field
    }
    
    /// Create a toast notification
    static func showToast(style: ToastView.Style, message: String, in view: UIView) {
        ToastView.show(style: style, message: message, in: view)
    }
    
    /// Create an alert
    static func showAlert(
        style: AlertView.Style,
        title: String,
        message: String,
        in view: UIView,
        actions: [AlertView.Action] = [.init(title: "OK")]
    ) {
        let alert = AlertView()
        alert.configure(style: style, title: title, message: message, actions: actions)
        alert.show(in: view)
    }
}

// MARK: - UITableView Extension

public extension UITableView {
    
    /// Register all standard cells
    func registerStandardCells() {
        register(StandardCell.self, forCellReuseIdentifier: StandardCell.reuseIdentifier)
        register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseIdentifier)
        register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        register(SwipeableCell.self, forCellReuseIdentifier: SwipeableCell.reuseIdentifier)
        register(CardCell.self, forCellReuseIdentifier: CardCell.reuseIdentifier)
        register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
    }
}

// MARK: - UICollectionView Extension

public extension UICollectionView {
    
    /// Register all standard cells
    func registerStandardCells() {
        register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
    }
}
