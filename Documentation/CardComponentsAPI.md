# Card Components API

## Overview

The Card Components API provides beautiful and customizable card components for iOS applications. This API supports both SwiftUI and UIKit, offering enterprise-grade card solutions with various layouts, animations, and interactive features.

## Core Components

### CustomCard

The main card component that provides extensive customization options.

```swift
public class CustomCard: UIView {
    // MARK: - Properties
    public var title: String
    public var subtitle: String?
    public var content: String?
    public var image: UIImage?
    public var style: CardStyle
    public var layout: CardLayout
    public var isInteractive: Bool
    public var isHighlighted: Bool
    
    // MARK: - Initialization
    public init(title: String, subtitle: String? = nil, content: String? = nil, image: UIImage? = nil, style: CardStyle = .default, layout: CardLayout = .vertical)
    
    // MARK: - Configuration
    public func configure(_ configuration: CardConfiguration)
    public func setTitle(_ title: String)
    public func setSubtitle(_ subtitle: String?)
    public func setContent(_ content: String?)
    public func setImage(_ image: UIImage?)
    
    // MARK: - Events
    public func onTap(_ action: @escaping () -> Void)
    public func onLongPress(_ action: @escaping () -> Void)
    public func onSwipe(_ direction: SwipeDirection, action: @escaping () -> Void)
    
    // MARK: - Styling
    public func setBackgroundColor(_ color: UIColor)
    public func setBorderColor(_ color: UIColor)
    public func setBorderWidth(_ width: CGFloat)
    public func setCornerRadius(_ radius: CGFloat)
    public func setShadow(enabled: Bool, color: UIColor?, offset: CGSize?, radius: CGFloat?)
    public func setPadding(_ padding: UIEdgeInsets)
    
    // MARK: - Animation
    public func animateAppearance()
    public func animateTap()
    public func animateHighlight()
    public func animateSwipe(_ direction: SwipeDirection)
}
```

### CardStyle

Enumeration defining different card styles.

```swift
public enum CardStyle {
    case `default`
    case elevated
    case outlined
    case filled
    case product
    case info
    case warning
    case error
    case success
    case custom(CardCustomStyle)
}

public struct CardCustomStyle {
    public let backgroundColor: UIColor
    public let borderColor: UIColor?
    public let borderWidth: CGFloat
    public let cornerRadius: CGFloat
    public let shadowEnabled: Bool
    public let shadowColor: UIColor?
    public let shadowOffset: CGSize
    public let shadowRadius: CGFloat
    public let shadowOpacity: Float
}
```

### CardLayout

Enumeration defining different card layouts.

```swift
public enum CardLayout {
    case vertical
    case horizontal
    case grid
    case list
    case custom(CardCustomLayout)
}

public struct CardCustomLayout {
    public let imagePosition: ImagePosition
    public let textAlignment: NSTextAlignment
    public let spacing: CGFloat
    public let padding: UIEdgeInsets
}

public enum ImagePosition {
    case top
    case bottom
    case left
    case right
    case center
}
```

## Configuration

### CardConfiguration

Configuration object for card setup.

```swift
public struct CardConfiguration {
    public var enableShadows: Bool
    public var enableAnimations: Bool
    public var enableAccessibility: Bool
    public var enableCustomLayouts: Bool
    public var enableInteractiveGestures: Bool
    public var enableHapticFeedback: Bool
    public var enableImageLoading: Bool
    public var enableBadgeSupport: Bool
    
    public init()
}
```

## Usage Examples

### Basic Card

```swift
// Create a basic card
let basicCard = CustomCard(
    title: "Welcome",
    subtitle: "Get started with our app",
    content: "This is a basic card with title, subtitle, and content.",
    style: .default,
    layout: .vertical
)

// Configure card
basicCard.configure { config in
    config.enableShadows = true
    config.enableAnimations = true
}

// Add tap action
basicCard.onTap {
    print("Card tapped!")
}

// Style the card
basicCard.setBackgroundColor(.systemBackground)
basicCard.setBorderColor(.systemGray4)
basicCard.setBorderWidth(1)
basicCard.setCornerRadius(12)
basicCard.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 2), radius: 4)
```

### Product Card

```swift
// Create a product card
let productCard = CustomCard(
    title: "iPhone 15 Pro",
    subtitle: "Latest Apple smartphone",
    content: "Experience the future of mobile technology with the iPhone 15 Pro.",
    image: UIImage(named: "iphone_image"),
    style: .product,
    layout: .vertical
)

// Configure product card
productCard.configure { config in
    config.enableShadows = true
    config.enableAnimations = true
    config.enableInteractiveGestures = true
}

// Style product card
productCard.setBackgroundColor(.systemBackground)
productCard.setCornerRadius(16)
productCard.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 4), radius: 8)

// Add interactions
productCard.onTap {
    print("Product selected: iPhone 15 Pro")
}

productCard.onLongPress {
    print("Product details requested")
}
```

### Info Card

```swift
// Create an info card
let infoCard = CustomCard(
    title: "Information",
    content: "This is an informational card with important details.",
    style: .info,
    layout: .horizontal
)

// Configure info card
infoCard.configure { config in
    config.enableAccessibility = true
}

// Style info card
infoCard.setBackgroundColor(.systemBlue.withAlphaComponent(0.1))
infoCard.setBorderColor(.systemBlue)
infoCard.setBorderWidth(2)
infoCard.setCornerRadius(8)
```

### Elevated Card

```swift
// Create an elevated card
let elevatedCard = CustomCard(
    title: "Elevated Card",
    subtitle: "With enhanced shadow",
    content: "This card has a prominent shadow effect.",
    style: .elevated,
    layout: .vertical
)

// Configure elevated card
elevatedCard.configure { config in
    config.enableShadows = true
    config.enableAnimations = true
}

// Style elevated card
elevatedCard.setBackgroundColor(.systemBackground)
elevatedCard.setCornerRadius(16)
elevatedCard.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 8), radius: 16)
```

## Accessibility

### VoiceOver Support

```swift
// Configure accessibility
productCard.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
productCard.accessibilityLabel = "iPhone 15 Pro Product Card"
productCard.accessibilityHint = "Double tap to view product details"
productCard.accessibilityTraits = .button
```

### Dynamic Type Support

```swift
// Support dynamic type
productCard.configure { config in
    config.enableDynamicType = true
    config.titleTextStyle = .headline
    config.subtitleTextStyle = .subheadline
    config.contentTextStyle = .body
}
```

## Animation

### Built-in Animations

```swift
// Appearance animation
productCard.animateAppearance()

// Tap animation
productCard.animateTap()

// Highlight animation
productCard.animateHighlight()

// Swipe animation
productCard.animateSwipe(.left)
```

### Custom Animations

```swift
// Custom animation
productCard.animate(
    duration: 0.3,
    delay: 0,
    options: [.curveEaseInOut],
    animations: {
        productCard.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
    },
    completion: { _ in
        UIView.animate(withDuration: 0.1) {
            productCard.transform = .identity
        }
    }
)
```

## SwiftUI Support

### SwiftUI Card Component

```swift
public struct SwiftUICard: View {
    public let title: String
    public let subtitle: String?
    public let content: String?
    public let image: Image?
    public let style: CardStyle
    public let layout: CardLayout
    public let onTap: () -> Void
    
    public init(
        title: String,
        subtitle: String? = nil,
        content: String? = nil,
        image: Image? = nil,
        style: CardStyle = .default,
        layout: CardLayout = .vertical,
        onTap: @escaping () -> Void
    )
    
    public var body: some View
}
```

### SwiftUI Usage

```swift
struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            SwiftUICard(
                title: "SwiftUI Card",
                subtitle: "Modern card component",
                content: "This is a SwiftUI card with beautiful styling.",
                style: .elevated,
                layout: .vertical
            ) {
                print("SwiftUI card tapped")
            }
            
            SwiftUICard(
                title: "Product Card",
                subtitle: "iPhone 15 Pro",
                content: "Latest smartphone with advanced features.",
                image: Image("iphone_image"),
                style: .product,
                layout: .horizontal
            ) {
                print("Product card tapped")
            }
        }
        .padding()
    }
}
```

## Error Handling

### Card Errors

```swift
public enum CardError: Error {
    case invalidConfiguration
    case animationFailed
    case accessibilitySetupFailed
    case imageLoadingFailed
    case styleNotFound
    case layoutNotFound
}

// Handle errors
do {
    try productCard.configure(cardConfig)
} catch CardError.invalidConfiguration {
    print("Invalid card configuration")
} catch {
    print("Card configuration failed: \(error)")
}
```

## Performance Considerations

### Memory Management

- Cards are automatically deallocated when not in use
- Images are cached efficiently
- Animation memory is properly managed

### Rendering Performance

- Hardware acceleration for animations
- Efficient drawing with Core Graphics
- Optimized layout calculations

## Best Practices

### Card Design

1. **Clear Hierarchy**: Use clear title, subtitle, and content hierarchy
2. **Consistent Spacing**: Maintain consistent padding and margins
3. **Appropriate Shadows**: Use shadows to create depth and hierarchy
4. **Accessibility**: Always include proper accessibility labels
5. **Interactive Feedback**: Provide clear feedback for interactions

### Code Organization

1. **Configuration**: Use configuration objects for complex setups
2. **Reusability**: Create reusable card styles
3. **Testing**: Test all card states and interactions
4. **Documentation**: Document custom card implementations

## Migration Guide

### From UIView Cards

```swift
// Old UIView approach
let oldCard = UIView()
oldCard.backgroundColor = .white
oldCard.layer.cornerRadius = 8
oldCard.layer.shadowColor = UIColor.black.cgColor
oldCard.layer.shadowOffset = CGSize(width: 0, height: 2)
oldCard.layer.shadowRadius = 4

// New CustomCard approach
let newCard = CustomCard(
    title: "New Card",
    style: .elevated,
    layout: .vertical
)
```

### From SwiftUI Cards

```swift
// Old SwiftUI approach
VStack {
    Text("Old Card")
    Text("Content")
}
.padding()
.background(Color.white)
.cornerRadius(8)
.shadow(radius: 4)

// New SwiftUICard approach
SwiftUICard(
    title: "New Card",
    content: "Content",
    style: .elevated,
    layout: .vertical
) {
    // action
}
```

## Version History

### Version 1.0.0
- Initial release with basic card functionality
- Support for common card styles
- Basic animation support

### Version 1.1.0
- Added custom style support
- Enhanced accessibility features
- Improved animation system

### Version 1.2.0
- Added interactive gestures
- Enhanced SwiftUI integration
- Performance optimizations

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
