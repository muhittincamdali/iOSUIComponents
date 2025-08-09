# 🚀 Getting Started with iOS UI Components

<!-- TOC START -->
## Table of Contents
- [🚀 Getting Started with iOS UI Components](#-getting-started-with-ios-ui-components)
- [📋 Table of Contents](#-table-of-contents)
- [📦 Installation](#-installation)
  - [**Prerequisites**](#prerequisites)
  - [**Swift Package Manager**](#swift-package-manager)
  - [**CocoaPods**](#cocoapods)
- [🎯 Basic Usage](#-basic-usage)
  - [**Import Framework**](#import-framework)
  - [**Custom Button**](#custom-button)
  - [**Custom Card**](#custom-card)
  - [**Custom Text Field**](#custom-text-field)
- [🎨 Customization](#-customization)
  - [**Theme Configuration**](#theme-configuration)
  - [**Component Styling**](#component-styling)
- [📱 Component Examples](#-component-examples)
  - [**Navigation Components**](#navigation-components)
  - [**Input Components**](#input-components)
  - [**Display Components**](#display-components)
- [🔧 Troubleshooting](#-troubleshooting)
  - [**Common Issues**](#common-issues)
    - [**Component Not Rendering**](#component-not-rendering)
    - [**Styling Issues**](#styling-issues)
    - [**Performance Issues**](#performance-issues)
- [📚 Next Steps](#-next-steps)
- [🤝 Support](#-support)
<!-- TOC END -->


Quick start guide for using iOS UI Component Library.

## 📋 Table of Contents

- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Customization](#customization)
- [Component Examples](#component-examples)
- [Troubleshooting](#troubleshooting)

## 📦 Installation

### **Prerequisites**
- Xcode 15.0+
- iOS 15.0+ deployment target
- Swift 5.9+
- SwiftUI framework

### **Swift Package Manager**
```swift
dependencies: [
    .package(url: "https://github.com/iosuicomponents/iOSUIComponents.git", from: "1.0.0")
]
```

### **CocoaPods**
```ruby
pod 'iOSUIComponents', '~> 1.0'
```

## 🎯 Basic Usage

### **Import Framework**
```swift
import iOSUIComponents
```

### **Custom Button**
```swift
CustomButton(
    title: "Get Started",
    style: .primary,
    action: { 
        // Handle button tap
        print("Button tapped!")
    }
)
```

### **Custom Card**
```swift
CustomCard(
    title: "Product Name",
    subtitle: "Product description goes here",
    image: "product-image-url",
    action: {
        // Handle card tap
        print("Card tapped!")
    }
)
```

### **Custom Text Field**
```swift
@State private var email = ""

CustomTextField(
    placeholder: "Enter your email",
    text: $email,
    validation: .email
)
```

## 🎨 Customization

### **Theme Configuration**
```swift
// Configure app colors
struct AppColors {
    static let primary = Color(hex: "#YourBrandColor")
    static let secondary = Color(hex: "#YourSecondaryColor")
    static let accent = Color(hex: "#YourAccentColor")
}

// Configure app fonts
struct AppFonts {
    static let title = Font.custom("YourFont-Bold", size: 24)
    static let body = Font.custom("YourFont-Regular", size: 16)
}
```

### **Component Styling**
```swift
// Custom button styles
CustomButton(
    title: "Primary Action",
    style: .primary,
    size: .large,
    action: { /* handle action */ }
)

// Custom card styles
CustomCard(
    title: "Card Title",
    subtitle: "Card subtitle",
    style: .elevated,
    action: { /* handle action */ }
)
```

## 📱 Component Examples

### **Navigation Components**
```swift
// Custom Tab Bar
CustomTabBar(
    items: [
        TabItem(icon: "house", title: "Home"),
        TabItem(icon: "heart", title: "Favorites"),
        TabItem(icon: "person", title: "Profile")
    ],
    selectedIndex: $selectedTab
)

// Custom Navigation Bar
CustomNavigationBar(
    title: "Screen Title",
    leftButton: .back,
    rightButton: .menu
)
```

### **Input Components**
```swift
// Custom Toggle
@State private var isEnabled = false

CustomToggle(
    isOn: $isEnabled,
    title: "Enable notifications",
    subtitle: "Receive push notifications"
)

// Custom Slider
@State private var value = 50.0

CustomSlider(
    value: $value,
    range: 0...100,
    step: 1
)
```

### **Display Components**
```swift
// Custom Badge
CustomBadge(
    text: "New",
    style: .success
)

// Custom Avatar
CustomAvatar(
    image: "user-avatar",
    size: .large,
    style: .circular
)
```

## 🔧 Troubleshooting

### **Common Issues**

#### **Component Not Rendering**
```swift
// Ensure proper import
import iOSUIComponents

// Check SwiftUI preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Test", style: .primary, action: {})
    }
}
```

#### **Styling Issues**
```swift
// Verify color definitions
struct AppColors {
    static let primary = Color(hex: "#007AFF")
    static let secondary = Color(hex: "#5856D6")
}

// Check font availability
struct AppFonts {
    static let title = Font.system(size: 24, weight: .bold)
    static let body = Font.system(size: 16, weight: .regular)
}
```

#### **Performance Issues**
```swift
// Use lazy loading for lists
LazyVStack {
    ForEach(items) { item in
        CustomCard(title: item.title, subtitle: item.subtitle)
    }
}

// Optimize image loading
AsyncImage(url: URL(string: imageURL)) { image in
    image.resizable()
} placeholder: {
    ProgressView()
}
```

## 📚 Next Steps

1. **Read [Component Guide](ComponentGuide.md)** for detailed usage
2. **Explore [Design System](DesignSystem.md)** for design principles
3. **Check [Customization](Customization.md)** for theming options
4. **Review [API Reference](API.md)** for complete documentation

## 🤝 Support

- **Documentation**: [Complete Documentation](Documentation/)
- **Issues**: [GitHub Issues](https://github.com/iosuicomponents/iOSUIComponents/issues)
- **Discussions**: [GitHub Discussions](https://github.com/iosuicomponents/iOSUIComponents/discussions)

---

**Happy coding with iOS UI Components! 🚀** 