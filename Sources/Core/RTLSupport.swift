import UIKit

// MARK: - RTL Support
/// Comprehensive Right-to-Left language support for UIKit components
public final class RTLSupport {
    
    /// Check if current language direction is RTL
    public static var isRTL: Bool {
        UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    /// Get effective layout direction for a view
    public static func effectiveLayoutDirection(for view: UIView) -> UIUserInterfaceLayoutDirection {
        view.effectiveUserInterfaceLayoutDirection
    }
    
    /// Flip a horizontal constraint constant based on RTL
    public static func flipIfNeeded(_ value: CGFloat) -> CGFloat {
        return isRTL ? -value : value
    }
    
    /// Get leading edge inset
    public static func leadingInset(_ value: CGFloat) -> CGFloat {
        return value
    }
    
    /// Get trailing edge inset
    public static func trailingInset(_ value: CGFloat) -> CGFloat {
        return value
    }
    
    /// Mirror image for RTL if needed
    public static func mirrorImage(_ image: UIImage?) -> UIImage? {
        guard isRTL, let image = image else { return image }
        return image.withHorizontallyFlippedOrientation()
    }
    
    /// Get text alignment for current direction
    public static var naturalTextAlignment: NSTextAlignment {
        return isRTL ? .right : .left
    }
    
    /// Get reversed text alignment for current direction
    public static var oppositeTextAlignment: NSTextAlignment {
        return isRTL ? .left : .right
    }
}

// MARK: - UIView RTL Extensions
public extension UIView {
    
    /// Set semantic content attribute for RTL support
    func configureForRTL() {
        semanticContentAttribute = .forceLeftToRight
    }
    
    /// Force natural layout direction
    func forceNaturalDirection() {
        semanticContentAttribute = .unspecified
    }
    
    /// Check if view should mirror for RTL
    var shouldMirrorForRTL: Bool {
        return effectiveUserInterfaceLayoutDirection == .rightToLeft
    }
    
    /// Add subview with RTL-aware positioning
    func addSubviewRTLAware(_ subview: UIView, leading: CGFloat, trailing: CGFloat) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailing)
        ])
    }
}

// MARK: - NSLayoutConstraint RTL Extensions
public extension NSLayoutConstraint {
    
    /// Create RTL-aware horizontal spacing constraint
    static func rtlAwareLeading(
        item: UIView,
        attribute: NSLayoutConstraint.Attribute = .leading,
        toItem: UIView,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: item,
            attribute: attribute,
            relatedBy: .equal,
            toItem: toItem,
            attribute: RTLSupport.isRTL ? .trailing : .leading,
            multiplier: 1,
            constant: constant
        )
    }
    
    /// Create RTL-aware trailing constraint
    static func rtlAwareTrailing(
        item: UIView,
        attribute: NSLayoutConstraint.Attribute = .trailing,
        toItem: UIView,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: item,
            attribute: attribute,
            relatedBy: .equal,
            toItem: toItem,
            attribute: RTLSupport.isRTL ? .leading : .trailing,
            multiplier: 1,
            constant: constant
        )
    }
}

// MARK: - UIStackView RTL Extension
public extension UIStackView {
    
    /// Configure stack view for proper RTL behavior
    func configureForRTL() {
        semanticContentAttribute = .unspecified
        
        // Flip arrangement if horizontal
        if axis == .horizontal && RTLSupport.isRTL {
            let reversed = arrangedSubviews.reversed()
            arrangedSubviews.forEach { $0.removeFromSuperview() }
            reversed.forEach { addArrangedSubview($0) }
        }
    }
}

// MARK: - UICollectionViewFlowLayout RTL Extension
public extension UICollectionViewFlowLayout {
    
    /// Configure flow layout for RTL support
    func configureForRTL() {
        if RTLSupport.isRTL && scrollDirection == .horizontal {
            // Flip scroll direction content
            collectionView?.semanticContentAttribute = .forceRightToLeft
        }
    }
}

// MARK: - UITableView RTL Extension
public extension UITableView {
    
    /// Configure table view for RTL support
    func configureForRTL() {
        semanticContentAttribute = .unspecified
        
        // Configure cell layout margins for RTL
        if RTLSupport.isRTL {
            cellLayoutMarginsFollowReadableWidth = true
        }
    }
}

// MARK: - UILabel RTL Extension
public extension UILabel {
    
    /// Configure label for natural RTL text alignment
    func configureForRTL() {
        textAlignment = RTLSupport.naturalTextAlignment
    }
    
    /// Set text with RTL-aware formatting
    func setRTLAwareText(_ text: String, alignment: NSTextAlignment? = nil) {
        self.text = text
        self.textAlignment = alignment ?? RTLSupport.naturalTextAlignment
    }
}

// MARK: - UITextField RTL Extension
public extension UITextField {
    
    /// Configure text field for RTL input
    func configureForRTL() {
        textAlignment = RTLSupport.naturalTextAlignment
        
        // Configure clear button position
        if RTLSupport.isRTL {
            clearButtonMode = .whileEditing
        }
    }
}

// MARK: - UIButton RTL Extension
public extension UIButton {
    
    /// Configure button for RTL layout (flip image and title positions)
    func configureForRTL(imageOnLeading: Bool = true) {
        semanticContentAttribute = .unspecified
        
        if RTLSupport.isRTL {
            // Swap image and title positions for RTL
            if imageOnLeading {
                semanticContentAttribute = .forceRightToLeft
            }
        }
    }
    
    /// Set image with RTL-aware positioning
    func setRTLAwareImage(_ image: UIImage?, for state: UIControl.State) {
        let finalImage = RTLSupport.mirrorImage(image)
        setImage(finalImage, for: state)
    }
}

// MARK: - UIEdgeInsets RTL Extension
public extension UIEdgeInsets {
    
    /// Create RTL-aware edge insets
    static func rtlAware(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> UIEdgeInsets {
        if RTLSupport.isRTL {
            return UIEdgeInsets(top: top, left: trailing, bottom: bottom, right: leading)
        }
        return UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
    }
    
    /// Flip insets for RTL
    func flippedForRTL() -> UIEdgeInsets {
        if RTLSupport.isRTL {
            return UIEdgeInsets(top: top, left: right, bottom: bottom, right: left)
        }
        return self
    }
}

// MARK: - CGAffineTransform RTL Extension
public extension CGAffineTransform {
    
    /// Create horizontal flip transform for RTL
    static var rtlFlip: CGAffineTransform {
        return RTLSupport.isRTL ? CGAffineTransform(scaleX: -1, y: 1) : .identity
    }
}
