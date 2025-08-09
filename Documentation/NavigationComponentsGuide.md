# Navigation Components Guide

<!-- TOC START -->
## Table of Contents
- [Navigation Components Guide](#navigation-components-guide)
- [Overview](#overview)
- [Getting Started](#getting-started)
  - [Basic Navigation Bar](#basic-navigation-bar)
  - [Navigation Bar Configuration](#navigation-bar-configuration)
- [Navigation Bar Styles](#navigation-bar-styles)
  - [Default Navigation Bar](#default-navigation-bar)
  - [Transparent Navigation Bar](#transparent-navigation-bar)
  - [Custom Navigation Bar](#custom-navigation-bar)
- [Navigation Bar Buttons](#navigation-bar-buttons)
  - [Left Button](#left-button)
  - [Right Button](#right-button)
  - [Multiple Right Buttons](#multiple-right-buttons)
- [Tab Bar Components](#tab-bar-components)
  - [Basic Tab Bar](#basic-tab-bar)
  - [Custom Tab Bar](#custom-tab-bar)
- [Navigation Interactions](#navigation-interactions)
  - [Navigation Bar Interactions](#navigation-bar-interactions)
  - [Tab Bar Interactions](#tab-bar-interactions)
- [Navigation Animations](#navigation-animations)
  - [Navigation Bar Animations](#navigation-bar-animations)
  - [Tab Bar Animations](#tab-bar-animations)
- [Navigation Accessibility](#navigation-accessibility)
  - [VoiceOver Support](#voiceover-support)
  - [Tab Bar Accessibility](#tab-bar-accessibility)
- [SwiftUI Support](#swiftui-support)
  - [SwiftUI Navigation Bar](#swiftui-navigation-bar)
  - [SwiftUI Tab Bar](#swiftui-tab-bar)
  - [SwiftUI Usage](#swiftui-usage)
- [Best Practices](#best-practices)
  - [Navigation Design](#navigation-design)
  - [Navigation Patterns](#navigation-patterns)
  - [Navigation Interactions](#navigation-interactions)
- [Common Patterns](#common-patterns)
  - [Main Navigation](#main-navigation)
  - [Tab Navigation](#tab-navigation)
  - [Detail Navigation](#detail-navigation)
- [Error Handling](#error-handling)
  - [Navigation Errors](#navigation-errors)
- [Performance Considerations](#performance-considerations)
  - [Navigation Performance](#navigation-performance)
- [Migration Guide](#migration-guide)
  - [From UINavigationBar](#from-uinavigationbar)
  - [From UITabBar](#from-uitabbar)
- [Support](#support)
<!-- TOC END -->


## Overview

The Navigation Components Guide provides comprehensive information about using navigation components in iOS UI Components. This guide covers navigation bars, tab bars, side menus, and other navigation patterns.

## Getting Started

### Basic Navigation Bar

```swift
// Create a basic navigation bar
let navigationBar = CustomNavigationBar(
    title: "Home",
    style: .default
)

// Configure navigation bar
navigationBar.configure { config in
    config.enableCustomButtons = true
    config.enableAccessibility = true
}

// Add to view
view.addSubview(navigationBar)
```

### Navigation Bar Configuration

```swift
// Configure navigation bar
let navigationBar = CustomNavigationBar(
    title: "Configured Navigation",
    style: .default
)

navigationBar.configure { config in
    config.enableCustomButtons = true
    config.enableTransparency = true
    config.enableBlurEffect = true
    config.enableAccessibility = true
}

// Style the navigation bar
navigationBar.setBackgroundColor(.systemBackground)
navigationBar.setTitleColor(.label)
navigationBar.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 1), radius: 2)
```

## Navigation Bar Styles

### Default Navigation Bar

```swift
let defaultNavBar = CustomNavigationBar(
    title: "Default Navigation",
    style: .default
)

defaultNavBar.configure { config in
    config.backgroundColor = .systemBackground
    config.titleColor = .label
    config.borderColor = .systemGray4
}
```

### Transparent Navigation Bar

```swift
let transparentNavBar = CustomNavigationBar(
    title: "Transparent Navigation",
    style: .transparent
)

transparentNavBar.configure { config in
    config.enableTransparency = true
    config.enableBlurEffect = true
}

// Set transparency
transparentNavBar.setTransparent(true)
transparentNavBar.setBlurred(true)
```

### Custom Navigation Bar

```swift
let customNavBar = CustomNavigationBar(
    title: "Custom Navigation",
    style: .custom
)

customNavBar.configure { config in
    config.backgroundColor = .systemBlue
    config.titleColor = .white
    config.enableCustomStyling = true
}
```

## Navigation Bar Buttons

### Left Button

```swift
let navigationBar = CustomNavigationBar(
    title: "Navigation with Left Button"
)

// Add left button
let backButton = CustomButton(
    title: "Back",
    style: .secondary,
    size: .small
)

navigationBar.setLeftButton(backButton)

// Handle left button tap
backButton.onTap {
    navigationController?.popViewController(animated: true)
}
```

### Right Button

```swift
let navigationBar = CustomNavigationBar(
    title: "Navigation with Right Button"
)

// Add right button
let menuButton = CustomButton(
    title: "Menu",
    style: .secondary,
    size: .small
)

navigationBar.setRightButton(menuButton)

// Handle right button tap
menuButton.onTap {
    showMenu()
}
```

### Multiple Right Buttons

```swift
let navigationBar = CustomNavigationBar(
    title: "Navigation with Multiple Buttons"
)

// Add multiple right buttons
let searchButton = CustomButton(
    title: "Search",
    style: .secondary,
    size: .small
)

let settingsButton = CustomButton(
    title: "Settings",
    style: .secondary,
    size: .small
)

navigationBar.setRightButtons([searchButton, settingsButton])
```

## Tab Bar Components

### Basic Tab Bar

```swift
// Create tab bar items
let homeItem = TabBarItem(
    title: "Home",
    image: UIImage(systemName: "house")!,
    selectedImage: UIImage(systemName: "house.fill")!
)

let searchItem = TabBarItem(
    title: "Search",
    image: UIImage(systemName: "magnifyingglass")!,
    selectedImage: UIImage(systemName: "magnifyingglass")!
)

let profileItem = TabBarItem(
    title: "Profile",
    image: UIImage(systemName: "person")!,
    selectedImage: UIImage(systemName: "person.fill")!,
    badge: "3"
)

// Create tab bar
let tabBar = CustomTabBar(
    items: [homeItem, searchItem, profileItem],
    style: .default
)

// Configure tab bar
tabBar.configure { config in
    config.enableAnimations = true
    config.enableAccessibility = true
    config.enableBadgeSupport = true
}

// Handle tab selection
tabBar.onTabSelected { index in
    print("Selected tab: \(index)")
    switchToTab(index)
}
```

### Custom Tab Bar

```swift
let customTabBar = CustomTabBar(
    items: [homeItem, searchItem, profileItem],
    style: .custom
)

customTabBar.configure { config in
    config.enableCustomStyling = true
    config.backgroundColor = .systemBackground
    config.selectedItemColor = .systemBlue
    config.unselectedItemColor = .systemGray
}
```

## Navigation Interactions

### Navigation Bar Interactions

```swift
let navigationBar = CustomNavigationBar(
    title: "Interactive Navigation"
)

// Handle navigation bar interactions
navigationBar.onTitleTap {
    print("Navigation title tapped")
    scrollToTop()
}

navigationBar.onBackgroundTap {
    print("Navigation background tapped")
}
```

### Tab Bar Interactions

```swift
let tabBar = CustomTabBar(
    items: [homeItem, searchItem, profileItem]
)

// Handle tab interactions
tabBar.onTabSelected { index in
    print("Tab selected: \(index)")
    switchToTab(index)
}

tabBar.onTabLongPress { index in
    print("Tab long pressed: \(index)")
    showTabOptions(index)
}
```

## Navigation Animations

### Navigation Bar Animations

```swift
let navigationBar = CustomNavigationBar(
    title: "Animated Navigation"
)

navigationBar.configure { config in
    config.enableAnimations = true
    config.animationDuration = 0.3
}

// Animate title change
navigationBar.animateTitleChange("New Title")

// Animate button appearance
navigationBar.animateButtonAppearance()
```

### Tab Bar Animations

```swift
let tabBar = CustomTabBar(
    items: [homeItem, searchItem, profileItem]
)

tabBar.configure { config in
    config.enableAnimations = true
    config.selectionAnimation = .slide
    config.animationDuration = 0.3
}

// Animate tab selection
tabBar.animateTabSelection(1)
```

## Navigation Accessibility

### VoiceOver Support

```swift
let navigationBar = CustomNavigationBar(
    title: "Accessible Navigation"
)

// Configure accessibility
navigationBar.configure { config in
    config.enableAccessibility = true
}

// Set accessibility properties
navigationBar.accessibilityLabel = "Main Navigation Bar"
navigationBar.accessibilityHint = "Navigate through the app"
```

### Tab Bar Accessibility

```swift
let tabBar = CustomTabBar(
    items: [homeItem, searchItem, profileItem]
)

// Configure accessibility
tabBar.configure { config in
    config.enableAccessibility = true
}

// Set accessibility for tab items
for (index, item) in tabBar.items.enumerated() {
    tabBar.setAccessibilityLabel("\(item.title) Tab", for: index)
    tabBar.setAccessibilityHint("Double tap to select \(item.title)", for: index)
}
```

## SwiftUI Support

### SwiftUI Navigation Bar

```swift
public struct SwiftUINavigationBar: View {
    public let title: String
    public let leftButton: SwiftUIButton?
    public let rightButton: SwiftUIButton?
    public let style: NavigationBarStyle
    public let onLeftButtonTap: (() -> Void)?
    public let onRightButtonTap: (() -> Void)?
    
    public init(
        title: String,
        style: NavigationBarStyle = .default,
        leftButton: SwiftUIButton? = nil,
        rightButton: SwiftUIButton? = nil,
        onLeftButtonTap: (() -> Void)? = nil,
        onRightButtonTap: (() -> Void)? = nil
    )
    
    public var body: some View
}
```

### SwiftUI Tab Bar

```swift
public struct SwiftUITabBar: View {
    public let items: [TabBarItem]
    public let selectedIndex: Binding<Int>
    public let style: TabBarStyle
    public let onTabSelected: (Int) -> Void
    
    public init(
        items: [TabBarItem],
        selectedIndex: Binding<Int>,
        style: TabBarStyle = .default,
        onTabSelected: @escaping (Int) -> Void
    )
    
    public var body: some View
}
```

### SwiftUI Usage

```swift
struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            SwiftUINavigationBar(
                title: "SwiftUI Navigation",
                leftButton: SwiftUIButton(title: "Back") {
                    print("Back tapped")
                },
                rightButton: SwiftUIButton(title: "Menu") {
                    print("Menu tapped")
                }
            )
            
            SwiftUITabBar(
                items: [homeItem, searchItem, profileItem],
                selectedIndex: $selectedTab,
                onTabSelected: { index in
                    selectedTab = index
                }
            )
        }
    }
}
```

## Best Practices

### Navigation Design

1. **Clear Hierarchy**: Use clear navigation hierarchy
2. **Consistent Styling**: Maintain consistent navigation styling
3. **Accessibility**: Always include proper accessibility labels
4. **User Feedback**: Provide clear feedback for navigation actions
5. **Performance**: Optimize navigation transitions

### Navigation Patterns

1. **Standard Patterns**: Follow iOS navigation patterns
2. **User Expectations**: Meet user navigation expectations
3. **Context Awareness**: Provide context-aware navigation
4. **Error Handling**: Handle navigation errors gracefully
5. **State Management**: Manage navigation state properly

### Navigation Interactions

1. **Responsive**: Respond quickly to navigation actions
2. **Predictable**: Behave consistently across the app
3. **Accessible**: Support all accessibility features
4. **Smooth**: Provide smooth navigation transitions
5. **Intuitive**: Make navigation intuitive for users

## Common Patterns

### Main Navigation

```swift
let mainNavigationBar = CustomNavigationBar(
    title: "My App"
)

let homeButton = CustomButton(
    title: "Home",
    style: .secondary,
    size: .small
)

let menuButton = CustomButton(
    title: "Menu",
    style: .secondary,
    size: .small
)

mainNavigationBar.setLeftButton(homeButton)
mainNavigationBar.setRightButton(menuButton)

homeButton.onTap {
    navigateToHome()
}

menuButton.onTap {
    showMainMenu()
}
```

### Tab Navigation

```swift
let tabBar = CustomTabBar(
    items: [
        TabBarItem(title: "Home", image: UIImage(systemName: "house")!),
        TabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass")!),
        TabBarItem(title: "Profile", image: UIImage(systemName: "person")!)
    ]
)

tabBar.onTabSelected { index in
    switch index {
    case 0:
        showHomeView()
    case 1:
        showSearchView()
    case 2:
        showProfileView()
    default:
        break
    }
}
```

### Detail Navigation

```swift
let detailNavigationBar = CustomNavigationBar(
    title: "Product Details"
)

let backButton = CustomButton(
    title: "Back",
    style: .secondary,
    size: .small
)

let shareButton = CustomButton(
    title: "Share",
    style: .secondary,
    size: .small
)

detailNavigationBar.setLeftButton(backButton)
detailNavigationBar.setRightButton(shareButton)

backButton.onTap {
    navigationController?.popViewController(animated: true)
}

shareButton.onTap {
    shareProduct()
}
```

## Error Handling

### Navigation Errors

```swift
public enum NavigationError: Error {
    case invalidConfiguration
    case buttonCreationFailed
    case accessibilitySetupFailed
    case styleNotFound
    case itemNotFound
}

// Handle navigation errors
do {
    try navigationBar.configure(navConfig)
} catch NavigationError.invalidConfiguration {
    print("Invalid navigation configuration")
} catch {
    print("Navigation configuration failed: \(error)")
}
```

## Performance Considerations

### Navigation Performance

```swift
// Optimize navigation performance
let performanceConfig = NavigationPerformanceConfiguration()
performanceConfig.enableCaching = true
performanceConfig.enableLazyLoading = true
performanceConfig.enableOptimizedRendering = true

navigationBar.configurePerformance(performanceConfig)
```

## Migration Guide

### From UINavigationBar

```swift
// Old UINavigationBar approach
let oldNavBar = UINavigationBar()
oldNavBar.barTintColor = .systemBlue
oldNavBar.tintColor = .white

// New CustomNavigationBar approach
let newNavBar = CustomNavigationBar(
    title: "New Navigation",
    style: .default
)
```

### From UITabBar

```swift
// Old UITabBar approach
let oldTabBar = UITabBar()
oldTabBar.items = [tabBarItem1, tabBarItem2, tabBarItem3]

// New CustomTabBar approach
let newTabBar = CustomTabBar(
    items: [item1, item2, item3],
    style: .default
)
```

## Support

For questions, issues, or contributions, please visit:
- [GitHub Issues](https://github.com/muhittincamdali/iOSUIComponents/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
