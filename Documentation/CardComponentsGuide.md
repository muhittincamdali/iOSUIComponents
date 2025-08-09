# Card Components Guide

<!-- TOC START -->
## Table of Contents
- [Card Components Guide](#card-components-guide)
- [Overview](#overview)
- [Getting Started](#getting-started)
  - [Basic Card Creation](#basic-card-creation)
  - [Card Configuration](#card-configuration)
- [Card Styles](#card-styles)
  - [Default Card](#default-card)
  - [Elevated Card](#elevated-card)
  - [Product Card](#product-card)
  - [Info Card](#info-card)
- [Card Layouts](#card-layouts)
  - [Vertical Layout](#vertical-layout)
  - [Horizontal Layout](#horizontal-layout)
  - [Grid Layout](#grid-layout)
- [Card Interactions](#card-interactions)
  - [Tap Action](#tap-action)
  - [Long Press Action](#long-press-action)
  - [Swipe Actions](#swipe-actions)
- [Card Animations](#card-animations)
  - [Appearance Animation](#appearance-animation)
  - [Tap Animation](#tap-animation)
  - [Highlight Animation](#highlight-animation)
- [Card Accessibility](#card-accessibility)
  - [VoiceOver Support](#voiceover-support)
  - [Dynamic Type Support](#dynamic-type-support)
  - [High Contrast Support](#high-contrast-support)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Card](#swiftui-card)
  - [SwiftUI Usage](#swiftui-usage)
- [Best Practices](#best-practices)
  - [Card Design](#card-design)
  - [Card Layout](#card-layout)
  - [Card Interactions](#card-interactions)
- [Common Patterns](#common-patterns)
  - [Product Card](#product-card)
  - [Information Card](#information-card)
  - [Action Card](#action-card)
- [Error Handling](#error-handling)
  - [Card Errors](#card-errors)
- [Performance Considerations](#performance-considerations)
  - [Card Performance](#card-performance)
- [Migration Guide](#migration-guide)
  - [From UIView Cards](#from-uiview-cards)
  - [From SwiftUI Cards](#from-swiftui-cards)
- [Support](#support)
<!-- TOC END -->


## Overview

The Card Components Guide provides comprehensive information about using card components in iOS UI Components. This guide covers card creation, styling, layouts, interactions, accessibility, and best practices.

## Getting Started

### Basic Card Creation

```swift
// Create a basic card
let basicCard = CustomCard(
    title: "Welcome",
    subtitle: "Get started with our app",
    content: "This is a basic card with title, subtitle, and content.",
    style: .default,
    layout: .vertical
)

// Add to view
view.addSubview(basicCard)

// Handle tap action
basicCard.onTap {
    print("Card tapped!")
}
```

### Card Configuration

```swift
// Configure card
let card = CustomCard(
    title: "Configured Card",
    content: "This card has custom configuration."
)

card.configure { config in
    config.enableShadows = true
    config.enableAnimations = true
    config.enableAccessibility = true
    config.enableCustomLayouts = true
}

// Style the card
card.setBackgroundColor(.systemBackground)
card.setBorderColor(.systemGray4)
card.setBorderWidth(1)
card.setCornerRadius(12)
card.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 2), radius: 4)
```

## Card Styles

### Default Card

```swift
let defaultCard = CustomCard(
    title: "Default Card",
    content: "This is a default styled card.",
    style: .default,
    layout: .vertical
)

defaultCard.configure { config in
    config.backgroundColor = .systemBackground
    config.borderColor = .systemGray4
    config.borderWidth = 1
    config.cornerRadius = 8
}
```

### Elevated Card

```swift
let elevatedCard = CustomCard(
    title: "Elevated Card",
    subtitle: "With enhanced shadow",
    content: "This card has a prominent shadow effect.",
    style: .elevated,
    layout: .vertical
)

elevatedCard.configure { config in
    config.enableShadows = true
    config.shadowColor = .black
    config.shadowOffset = CGSize(width: 0, height: 8)
    config.shadowRadius = 16
    config.shadowOpacity = 0.3
}
```

### Product Card

```swift
let productCard = CustomCard(
    title: "iPhone 15 Pro",
    subtitle: "Latest Apple smartphone",
    content: "Experience the future of mobile technology with the iPhone 15 Pro.",
    image: UIImage(named: "iphone_image"),
    style: .product,
    layout: .vertical
)

productCard.configure { config in
    config.enableShadows = true
    config.enableAnimations = true
    config.enableInteractiveGestures = true
}

// Style product card
productCard.setBackgroundColor(.systemBackground)
productCard.setCornerRadius(16)
productCard.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 4), radius: 8)
```

### Info Card

```swift
let infoCard = CustomCard(
    title: "Information",
    content: "This is an informational card with important details.",
    style: .info,
    layout: .horizontal
)

infoCard.configure { config in
    config.enableAccessibility = true
}

// Style info card
infoCard.setBackgroundColor(.systemBlue.withAlphaComponent(0.1))
infoCard.setBorderColor(.systemBlue)
infoCard.setBorderWidth(2)
infoCard.setCornerRadius(8)
```

## Card Layouts

### Vertical Layout

```swift
let verticalCard = CustomCard(
    title: "Vertical Layout",
    content: "Content arranged vertically.",
    style: .default,
    layout: .vertical
)

verticalCard.configure { config in
    config.imagePosition = .top
    config.textAlignment = .left
    config.spacing = 12
}
```

### Horizontal Layout

```swift
let horizontalCard = CustomCard(
    title: "Horizontal Layout",
    content: "Content arranged horizontally.",
    style: .default,
    layout: .horizontal
)

horizontalCard.configure { config in
    config.imagePosition = .left
    config.textAlignment = .left
    config.spacing = 16
}
```

### Grid Layout

```swift
let gridCard = CustomCard(
    title: "Grid Layout",
    content: "Content arranged in a grid.",
    style: .default,
    layout: .grid
)

gridCard.configure { config in
    config.gridColumns = 2
    config.gridSpacing = 8
}
```

## Card Interactions

### Tap Action

```swift
let card = CustomCard(
    title: "Interactive Card",
    content: "Tap this card to perform an action."
)

// Handle tap
card.onTap {
    print("Card tapped!")
    // Navigate to detail view
    navigateToDetail()
}
```

### Long Press Action

```swift
let card = CustomCard(
    title: "Long Press Card",
    content: "Long press this card for options."
)

// Handle long press
card.onLongPress {
    print("Card long pressed!")
    // Show context menu
    showContextMenu()
}
```

### Swipe Actions

```swift
let card = CustomCard(
    title: "Swipe Card",
    content: "Swipe this card for actions."
)

// Handle swipe actions
card.onSwipe(.left) {
    print("Card swiped left!")
    // Delete card
    deleteCard()
}

card.onSwipe(.right) {
    print("Card swiped right!")
    // Favorite card
    favoriteCard()
}
```

## Card Animations

### Appearance Animation

```swift
let card = CustomCard(
    title: "Animated Card",
    content: "This card animates when it appears."
)

card.configure { config in
    config.enableAnimations = true
    config.appearanceAnimation = .fade
    config.animationDuration = 0.3
}

// Animate appearance
card.animateAppearance()
```

### Tap Animation

```swift
let card = CustomCard(
    title: "Tap Animated Card",
    content: "This card animates when tapped."
)

card.configure { config in
    config.enableAnimations = true
    config.tapAnimation = .scale
    config.animationDuration = 0.2
}

card.onTap {
    card.animateTap()
    // Perform action after animation
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        performAction()
    }
}
```

### Highlight Animation

```swift
let card = CustomCard(
    title: "Highlight Card",
    content: "This card highlights on interaction."
)

card.configure { config in
    config.enableAnimations = true
    config.highlightAnimation = .glow
    config.animationDuration = 0.3
}

card.onTap {
    card.animateHighlight()
}
```

## Card Accessibility

### VoiceOver Support

```swift
let card = CustomCard(
    title: "Accessible Card",
    content: "This card supports VoiceOver."
)

// Configure accessibility
card.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
card.accessibilityLabel = "Product Information Card"
card.accessibilityHint = "Double tap to view product details"
card.accessibilityTraits = .button
```

### Dynamic Type Support

```swift
let card = CustomCard(
    title: "Dynamic Type Card",
    content: "This card supports Dynamic Type."
)

// Support dynamic type
card.configure { config in
    config.enableDynamicType = true
    config.titleTextStyle = .headline
    config.subtitleTextStyle = .subheadline
    config.contentTextStyle = .body
}
```

### High Contrast Support

```swift
let card = CustomCard(
    title: "High Contrast Card",
    content: "This card supports High Contrast mode."
)

// Support high contrast
card.configure { config in
    config.enableHighContrast = true
}
```

## SwiftUI Support

### SwiftUI Card

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

## Best Practices

### Card Design

1. **Clear Hierarchy**: Use clear title, subtitle, and content hierarchy
2. **Consistent Spacing**: Maintain consistent padding and margins
3. **Appropriate Shadows**: Use shadows to create depth and hierarchy
4. **Accessibility**: Always include proper accessibility labels
5. **Interactive Feedback**: Provide clear feedback for interactions

### Card Layout

1. **Logical Flow**: Arrange content in logical order
2. **Visual Balance**: Maintain visual balance in layouts
3. **Responsive Design**: Design for different screen sizes
4. **Content Priority**: Prioritize important content
5. **Consistent Patterns**: Use consistent layout patterns

### Card Interactions

1. **Clear Purpose**: Make interaction purpose clear
2. **Visual Feedback**: Provide immediate visual feedback
3. **Accessibility**: Support all accessibility features
4. **Performance**: Optimize for smooth interactions
5. **User Expectations**: Meet user interaction expectations

## Common Patterns

### Product Card

```swift
let productCard = CustomCard(
    title: "iPhone 15 Pro",
    subtitle: "$999",
    content: "Latest Apple smartphone with advanced features.",
    image: UIImage(named: "iphone_image"),
    style: .product,
    layout: .vertical
)

productCard.configure { config in
    config.enableShadows = true
    config.enableAnimations = true
    config.enableInteractiveGestures = true
}

productCard.onTap {
    // Navigate to product detail
    navigateToProductDetail(productId: "iphone15pro")
}

productCard.onLongPress {
    // Add to wishlist
    addToWishlist(productId: "iphone15pro")
}
```

### Information Card

```swift
let infoCard = CustomCard(
    title: "System Update",
    subtitle: "Available",
    content: "A new system update is available for your device.",
    style: .info,
    layout: .horizontal
)

infoCard.configure { config in
    config.enableAccessibility = true
    config.enableAnimations = true
}

infoCard.onTap {
    // Open system settings
    openSystemSettings()
}
```

### Action Card

```swift
let actionCard = CustomCard(
    title: "Quick Actions",
    content: "Perform common tasks quickly.",
    style: .default,
    layout: .grid
)

actionCard.configure { config in
    config.enableAnimations = true
    config.enableInteractiveGestures = true
}

actionCard.onTap {
    actionCard.animateTap()
    showQuickActions()
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

// Handle card errors
do {
    try card.configure(cardConfig)
} catch CardError.invalidConfiguration {
    print("Invalid card configuration")
} catch {
    print("Card configuration failed: \(error)")
}
```

## Performance Considerations

### Card Performance

```swift
// Optimize card performance
let performanceConfig = CardPerformanceConfiguration()
performanceConfig.enableCaching = true
performanceConfig.enableLazyLoading = true
performanceConfig.enableOptimizedRendering = true

card.configurePerformance(performanceConfig)
```

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

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
