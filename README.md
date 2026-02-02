```
    ╦╔═╗╔═╗  ╦ ╦╦  ╔═╗╔═╗╔╦╗╔═╗╔═╗╔╗╔╔═╗╔╗╔╔╦╗╔═╗
    ║║ ║╚═╗  ║ ║║  ║  ║ ║║║║╠═╝║ ║║║║║╣ ║║║ ║ ╚═╗
    ╩╚═╝╚═╝  ╚═╝╩  ╚═╝╚═╝╩ ╩╩  ╚═╝╝╚╝╚═╝╝╚╝ ╩ ╚═╝
```

<p align="center">
  <strong>🎨 Production-Ready SwiftUI Components for iOS Development</strong>
</p>

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-5.9+-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift"></a>
  <a href="https://developer.apple.com/ios/"><img src="https://img.shields.io/badge/iOS-15.0+-000000?style=for-the-badge&logo=apple&logoColor=white" alt="iOS"></a>
  <a href="https://developer.apple.com/xcode/swiftui/"><img src="https://img.shields.io/badge/SwiftUI-Ready-blue?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftUI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License"></a>
</p>

<p align="center">
  <a href="https://github.com/muhittincamdali/iOSUIComponents/actions"><img src="https://img.shields.io/github/actions/workflow/status/muhittincamdali/iOSUIComponents/swift.yml?style=flat-square&label=CI" alt="CI"></a>
  <a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-Compatible-orange?style=flat-square" alt="SPM"></a>
  <a href="https://github.com/muhittincamdali/iOSUIComponents/stargazers"><img src="https://img.shields.io/github/stars/muhittincamdali/iOSUIComponents?style=flat-square" alt="Stars"></a>
</p>

---

## 🎯 Overview

A comprehensive collection of **40+ SwiftUI components** designed for real-world iOS applications. Built with performance, accessibility, and customization in mind.

```
╭─────────────────────────────────────────────────────────────╮
│  ✓ Zero Dependencies      ✓ Dark Mode Support               │
│  ✓ Fully Accessible       ✓ Highly Customizable             │
│  ✓ Production Tested      ✓ Swift Package Manager           │
╰─────────────────────────────────────────────────────────────╯
```

---

## 📦 Component Gallery

| Category | Components | Preview |
|:---------|:-----------|:--------|
| **Buttons** | `PrimaryButton` `SecondaryButton` `IconButton` `GradientButton` `FloatingActionButton` `SocialButton` `ToggleButton` | `[▓▓▓▓▓▓▓]` |
| **Cards** | `Card` `ProfileCard` `InfoCard` `ProductCard` `PostCard` | `┌─────┐` |
| **Inputs** | `CustomTextField` `CustomSearchBar` `CustomPicker` `CustomDatePicker` | `[_______]` |
| **Toggles** | `CustomToggle` `CustomSlider` `CustomStepper` | `[●━━━○]` |
| **Navigation** | `TabBar` `NavigationHeader` `BottomSheet` | `┗━━┻━━┛` |
| **Lists** | `ListItem` `SectionList` `SwipeableRow` | `├──────┤` |
| **Modals** | `AlertView` `ActionSheet` `PopoverView` | `╔══════╗` |

---

## 🔘 Button Components

```
┌────────────────────────────────────────────────────────────────┐
│                                                                │
│    ╔═══════════════════════╗    ┌───────────────────────┐     │
│    ║    Primary Button     ║    │   Secondary Button    │     │
│    ╚═══════════════════════╝    └───────────────────────┘     │
│                                                                │
│    ╔══════════╗   ╔══════════╗   ╔══════════╗                 │
│    ║ ♥ Icon   ║   ║ ⟳ Load  ║   ║ + FAB    ║                 │
│    ╚══════════╝   ╚══════════╝   ╚══════════╝                 │
│                                                                │
│    ┌──────────────────────────────────────────────────┐       │
│    │░░░░░░░░░░░ Gradient Button ░░░░░░░░░░░│          │       │
│    └──────────────────────────────────────────────────┘       │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

```swift
import iOSUIComponents

// Primary action button with loading state
PrimaryButton(
    title: "Get Started",
    isLoading: isProcessing
) {
    await performAction()
}

// Gradient button for premium features
GradientButton(
    title: "Upgrade to Pro",
    gradient: LinearGradient(
        colors: [.purple, .blue],
        startPoint: .leading,
        endPoint: .trailing
    )
) {
    showUpgrade = true
}

// Floating action button
FloatingActionButton(icon: "plus", backgroundColor: .blue) {
    createNewItem()
}
```

---

## 🃏 Card Components

```
┌─────────────────────────────────────────┐
│ ┌─────────────────────────────────────┐ │
│ │  ┌───┐                              │ │
│ │  │ 👤│  John Smith                  │ │
│ │  └───┘  Senior Developer        >   │ │
│ │                                     │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │  ╔═══════════════════════════════╗  │ │
│ │  ║      Product Image            ║  │ │
│ │  ╚═══════════════════════════════╝  │ │
│ │                                     │ │
│ │  iPhone 15 Pro                      │ │
│ │  $999.00  ~~$1099~~     ★ 4.9      │ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

```swift
// Profile card with action
ProfileCard(
    avatar: "person.circle.fill",
    name: "Jane Doe",
    subtitle: "iOS Developer",
    action: { showProfile = true }
)

// Product card for e-commerce
ProductCard(
    imageURL: "https://example.com/product.jpg",
    title: "Premium Headphones",
    price: "$299.00",
    originalPrice: "$349.00",
    rating: 4.8
) {
    addToCart()
}

// Custom styled card
Card(style: .elevated) {
    VStack(alignment: .leading, spacing: 12) {
        Text("Welcome Back!")
            .font(.title2)
        Text("Your dashboard is ready.")
            .foregroundStyle(.secondary)
    }
}
```

---

## ⌨️ Input Components

```
┌────────────────────────────────────────────────────────────┐
│                                                            │
│   Email Address                                            │
│   ┌──────────────────────────────────────────────────┐    │
│   │  📧  john@example.com                       ✓    │    │
│   └──────────────────────────────────────────────────┘    │
│   ✓ Valid email format                                    │
│                                                            │
│   Password                                                 │
│   ┌──────────────────────────────────────────────────┐    │
│   │  🔒  ••••••••••••                           👁   │    │
│   └──────────────────────────────────────────────────┘    │
│   ✓ Strong password                                       │
│                                                            │
│   ┌──────────────────────────────────────────────────┐    │
│   │  🔍  Search products...                     ✕    │    │
│   └──────────────────────────────────────────────────┘    │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

```swift
// Text field with email validation
CustomTextField(
    placeholder: "Enter your email",
    text: $email,
    validation: .email
)

// Password field with strength indicator
CustomTextField(
    placeholder: "Create password",
    text: $password,
    validation: .password
)

// Search bar with callbacks
CustomSearchBar(
    text: $searchQuery,
    placeholder: "Search...",
    onSearch: { performSearch() },
    onCancel: { clearResults() }
)
```

---

## 🎚️ Control Components

```
┌────────────────────────────────────────────────────────────┐
│                                                            │
│   ┌────────────────────────────────────────────────────┐  │
│   │  🔔  Push Notifications                      [ON]  │  │
│   │     Get notified about updates                     │  │
│   └────────────────────────────────────────────────────┘  │
│                                                            │
│   Volume                                                   │
│   ┌────────────────────────────────────────────────────┐  │
│   │  0 ├────────●────────────────────────────────┤ 100 │  │
│   │                        35                          │  │
│   └────────────────────────────────────────────────────┘  │
│                                                            │
│   Quantity                                                 │
│   ┌────────────────────────────────────────────────────┐  │
│   │       (-)            5            (+)              │  │
│   └────────────────────────────────────────────────────┘  │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

```swift
// Toggle with icon and subtitle
CustomToggle(
    isOn: $notificationsEnabled,
    title: "Push Notifications",
    subtitle: "Get notified about updates",
    icon: "bell.fill"
)

// Slider with labels
CustomSlider(
    value: $volume,
    range: 0...100,
    title: "Volume",
    showValue: true
)

// Stepper for quantity selection
CustomStepper(
    value: $quantity,
    range: 1...10,
    title: "Quantity"
)
```

---

## 🎨 Theming & Customization

### Card Styles

```swift
// Available pre-built styles
Card(style: .default)   // Standard shadow
Card(style: .elevated)  // Pronounced shadow
Card(style: .outlined)  // Border only
Card(style: .flat)      // No shadow

// Custom style
let customStyle = CardStyle(
    backgroundColor: .blue.opacity(0.1),
    cornerRadius: 16,
    shadowColor: .blue.opacity(0.2),
    shadowRadius: 8
)
Card(style: customStyle) { content }
```

### Button Styles

```swift
// Using button style modifiers
Button("Continue") { }
    .buttonStyle(RoundedButtonStyle(
        backgroundColor: .indigo,
        foregroundColor: .white,
        cornerRadius: 12
    ))

// Outlined style
Button("Learn More") { }
    .buttonStyle(OutlinedButtonStyle(
        borderColor: .blue,
        foregroundColor: .blue
    ))
```

### Theme Configuration

```swift
// Global color scheme
struct AppTheme {
    static let primary = Color.blue
    static let secondary = Color.gray
    static let accent = Color.purple
    static let success = Color.green
    static let error = Color.red
}

// Apply to components
PrimaryButton(title: "Submit") { }
    .tint(AppTheme.primary)
```

---

## ♿ Accessibility

All components are built with accessibility in mind:

```
┌─────────────────────────────────────────────────────────────┐
│  Accessibility Features                                     │
├─────────────────────────────────────────────────────────────┤
│  ✓ VoiceOver labels and hints                              │
│  ✓ Dynamic Type support                                    │
│  ✓ Sufficient color contrast                               │
│  ✓ Touch targets ≥ 44pt                                    │
│  ✓ Reduce Motion support                                   │
│  ✓ Semantic button roles                                   │
└─────────────────────────────────────────────────────────────┘
```

```swift
// Components automatically include accessibility
PrimaryButton(title: "Add to Cart") { }
// VoiceOver: "Add to Cart, button"

// Validation messages are announced
CustomTextField(text: $email, validation: .email)
// VoiceOver: "Valid email format" or "Invalid email format"

// Custom accessibility
Card {
    content
}
.accessibilityElement(children: .combine)
.accessibilityLabel("Product details card")
```

---

## 📲 Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/muhittincamdali/iOSUIComponents.git",
        from: "1.0.0"
    )
]
```

Or in Xcode: **File → Add Package Dependencies** → paste the URL.

### Import

```swift
import iOSUIComponents
```

---

## 📁 Project Structure

```
iOSUIComponents/
├── Sources/
│   ├── ButtonComponents/    # Button variants & styles
│   ├── CardComponents/      # Card layouts
│   ├── InputComponents/     # Text fields, pickers
│   ├── ListComponents/      # List items, sections
│   ├── ModalComponents/     # Alerts, sheets
│   ├── NavigationComponents/# Tab bars, headers
│   └── Core/               # Shared utilities
├── Examples/
│   ├── BasicExample/       # Getting started
│   └── AdvancedExample/    # Complex layouts
├── Tests/
│   └── iOSUIComponentsTests/
└── Documentation/
```

---

## 📋 Requirements

| Requirement | Version |
|-------------|---------|
| iOS | 15.0+ |
| Xcode | 15.0+ |
| Swift | 5.9+ |

---

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

---

## 👨‍💻 Author

**Muhittin Camdali** — [@muhittincamdali](https://github.com/muhittincamdali)

---

<p align="center">
  <sub>If you find this helpful, consider giving it a ⭐</sub>
</p>
