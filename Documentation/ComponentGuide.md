# 📱 Component Guide

<!-- TOC START -->
## Table of Contents
- [📱 Component Guide](#-component-guide)
- [📋 Table of Contents](#-table-of-contents)
- [🧭 Navigation Components](#-navigation-components)
  - [**Custom Tab Bar**](#custom-tab-bar)
  - [**Custom Navigation Bar**](#custom-navigation-bar)
- [⌨️ Input Components](#-input-components)
  - [**Custom Text Field**](#custom-text-field)
  - [**Custom Toggle**](#custom-toggle)
  - [**Custom Slider**](#custom-slider)
- [📊 Display Components](#-display-components)
  - [**Custom Card**](#custom-card)
  - [**Custom Badge**](#custom-badge)
- [🔄 Feedback Components](#-feedback-components)
  - [**Loading Spinner**](#loading-spinner)
  - [**Toast Message**](#toast-message)
- [📱 Media Components](#-media-components)
  - [**Image Carousel**](#image-carousel)
  - [**Custom Avatar**](#custom-avatar)
- [🎨 Customization](#-customization)
  - [**Theme Support**](#theme-support)
  - [**Animation Support**](#animation-support)
- [📚 Next Steps](#-next-steps)
- [🤝 Support](#-support)
<!-- TOC END -->


Complete guide for using iOS UI Components.

## 📋 Table of Contents

- [Navigation Components](#navigation-components)
- [Input Components](#input-components)
- [Display Components](#display-components)
- [Feedback Components](#feedback-components)
- [Media Components](#media-components)
- [Customization](#customization)

## 🧭 Navigation Components

### **Custom Tab Bar**
```swift
struct CustomTabBar: View {
    let items: [TabItem]
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                TabBarItem(
                    item: item,
                    isSelected: selectedIndex == index
                ) {
                    selectedIndex = index
                }
            }
        }
        .background(AppColors.surface)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(AppColors.border),
            alignment: .top
        )
    }
}

struct TabItem {
    let icon: String
    let title: String
    let badge: String?
}

struct TabBarItem: View {
    let item: TabItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xs) {
                Image(systemName: item.icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? AppColors.primary : AppColors.textSecondary)
                
                Text(item.title)
                    .font(AppFonts.caption)
                    .foregroundColor(isSelected ? AppColors.primary : AppColors.textSecondary)
                
                if let badge = item.badge {
                    Text(badge)
                        .font(AppFonts.captionSmall)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(AppColors.error)
                        .clipShape(Capsule())
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
```

### **Custom Navigation Bar**
```swift
struct CustomNavigationBar: View {
    let title: String
    let leftButton: NavigationButton?
    let rightButton: NavigationButton?
    let onLeftTap: (() -> Void)?
    let onRightTap: (() -> Void)?
    
    var body: some View {
        HStack {
            if let leftButton = leftButton {
                Button(action: { onLeftTap?() }) {
                    Image(systemName: leftButton.icon)
                        .font(.system(size: 20))
                        .foregroundColor(AppColors.primary)
                }
            }
            
            Spacer()
            
            Text(title)
                .font(AppFonts.h3)
                .foregroundColor(AppColors.text)
            
            Spacer()
            
            if let rightButton = rightButton {
                Button(action: { onRightTap?() }) {
                    Image(systemName: rightButton.icon)
                        .font(.system(size: 20))
                        .foregroundColor(AppColors.primary)
                }
            }
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, AppSpacing.sm)
        .background(AppColors.surface)
    }
}

enum NavigationButton {
    case back, menu, search, share, more
    
    var icon: String {
        switch self {
        case .back: return "chevron.left"
        case .menu: return "line.horizontal.3"
        case .search: return "magnifyingglass"
        case .share: return "square.and.arrow.up"
        case .more: return "ellipsis"
        }
    }
}
```

## ⌨️ Input Components

### **Custom Text Field**
```swift
struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let validation: ValidationType?
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    @State private var isEditing = false
    
    init(
        placeholder: String,
        text: Binding<String>,
        validation: ValidationType? = nil,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.validation = validation
        self.keyboardType = keyboardType
        self.textContentType = textContentType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            TextField(placeholder, text: $text)
                .font(AppFonts.body)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.sm)
                .background(AppColors.background)
                .cornerRadius(AppRadius.sm)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.sm)
                        .stroke(isEditing ? AppColors.primary : AppColors.border, lineWidth: 1)
                )
                .onTapGesture {
                    isEditing = true
                }
                .onChange(of: text) { _ in
                    isEditing = false
                }
            
            if let validation = validation, !text.isEmpty {
                ValidationMessage(type: validation, isValid: validate(text, type: validation))
            }
        }
    }
    
    private func validate(_ text: String, type: ValidationType) -> Bool {
        switch type {
        case .email:
            return text.contains("@") && text.contains(".")
        case .phone:
            return text.count >= 10
        case .password:
            return text.count >= 8
        case .url:
            return URL(string: text) != nil
        }
    }
}
```

### **Custom Toggle**
```swift
struct CustomToggle: View {
    @Binding var isOn: Bool
    let title: String
    let subtitle: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(title)
                    .font(AppFonts.body)
                    .foregroundColor(AppColors.text)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(AppFonts.caption)
                        .foregroundColor(AppColors.textSecondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: AppColors.primary))
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, AppSpacing.sm)
    }
}
```

### **Custom Slider**
```swift
struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let title: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            if let title = title {
                Text(title)
                    .font(AppFonts.body)
                    .foregroundColor(AppColors.text)
            }
            
            HStack {
                Text("\(Int(range.lowerBound))")
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.textSecondary)
                
                Slider(value: $value, in: range, step: step)
                    .accentColor(AppColors.primary)
                
                Text("\(Int(range.upperBound))")
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            Text("\(Int(value))")
                .font(AppFonts.bodySmall)
                .foregroundColor(AppColors.primary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
```

## 📊 Display Components

### **Custom Card**
```swift
struct CustomCard: View {
    let title: String
    let subtitle: String?
    let image: String?
    let action: (() -> Void)?
    let style: CardStyle
    
    init(
        title: String,
        subtitle: String? = nil,
        image: String? = nil,
        style: CardStyle = .default,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.style = style
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            if let image = image {
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(AppColors.border)
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(AppRadius.md, corners: [.topLeft, .topRight])
            }
            
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text(title)
                    .font(AppFonts.h4)
                    .foregroundColor(AppColors.text)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(AppFonts.bodySmall)
                        .foregroundColor(AppColors.textSecondary)
                }
            }
            .padding(.horizontal, AppSpacing.md)
            .padding(.bottom, AppSpacing.md)
        }
        .background(style.backgroundColor)
        .cornerRadius(AppRadius.md)
        .shadow(color: style.shadowColor, radius: style.shadowRadius, x: 0, y: style.shadowOffset)
        .onTapGesture {
            action?()
        }
    }
}

enum CardStyle {
    case `default`, elevated, outlined
    
    var backgroundColor: Color {
        switch self {
        case .default, .elevated: return AppColors.surface
        case .outlined: return Color.clear
        }
    }
    
    var shadowColor: Color {
        switch self {
        case .default: return Color.black.opacity(0.05)
        case .elevated: return Color.black.opacity(0.1)
        case .outlined: return Color.clear
        }
    }
    
    var shadowRadius: CGFloat {
        switch self {
        case .default: return 2
        case .elevated: return 4
        case .outlined: return 0
        }
    }
    
    var shadowOffset: CGFloat {
        switch self {
        case .default: return 1
        case .elevated: return 2
        case .outlined: return 0
        }
    }
}
```

### **Custom Badge**
```swift
struct CustomBadge: View {
    let text: String
    let style: BadgeStyle
    
    var body: some View {
        Text(text)
            .font(AppFonts.caption)
            .foregroundColor(style.textColor)
            .padding(.horizontal, AppSpacing.sm)
            .padding(.vertical, AppSpacing.xs)
            .background(style.backgroundColor)
            .cornerRadius(AppRadius.round)
    }
}

enum BadgeStyle {
    case primary, secondary, success, warning, error
    
    var backgroundColor: Color {
        switch self {
        case .primary: return AppColors.primary
        case .secondary: return AppColors.secondary
        case .success: return AppColors.success
        case .warning: return AppColors.warning
        case .error: return AppColors.error
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary, .secondary, .success, .warning, .error: return .white
        }
    }
}
```

## 🔄 Feedback Components

### **Loading Spinner**
```swift
struct LoadingSpinner: View {
    let size: SpinnerSize
    let color: Color
    
    init(size: SpinnerSize = .medium, color: Color = AppColors.primary) {
        self.size = size
        self.color = color
    }
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: color))
            .scaleEffect(size.scale)
    }
}

enum SpinnerSize {
    case small, medium, large
    
    var scale: CGFloat {
        switch self {
        case .small: return 0.8
        case .medium: return 1.0
        case .large: return 1.2
        }
    }
}
```

### **Toast Message**
```swift
struct ToastMessage: View {
    let message: String
    let type: ToastType
    @Binding var isShowing: Bool
    
    var body: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: type.icon)
                .foregroundColor(type.textColor)
            
            Text(message)
                .font(AppFonts.bodySmall)
                .foregroundColor(type.textColor)
            
            Spacer()
            
            Button("Dismiss") {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isShowing = false
                }
            }
            .font(AppFonts.caption)
            .foregroundColor(type.textColor)
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, AppSpacing.sm)
        .background(type.backgroundColor)
        .cornerRadius(AppRadius.md)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

enum ToastType {
    case success, warning, error, info
    
    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "xmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .success: return AppColors.success
        case .warning: return AppColors.warning
        case .error: return AppColors.error
        case .info: return AppColors.primary
        }
    }
    
    var textColor: Color {
        return .white
    }
}
```

## 📱 Media Components

### **Image Carousel**
```swift
struct ImageCarousel: View {
    let images: [String]
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(AppColors.border)
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 200)
    }
}
```

### **Custom Avatar**
```swift
struct CustomAvatar: View {
    let image: String?
    let size: AvatarSize
    let style: AvatarStyle
    
    init(image: String? = nil, size: AvatarSize = .medium, style: AvatarStyle = .circular) {
        self.image = image
        self.size = size
        self.style = style
    }
    
    var body: some View {
        Group {
            if let image = image {
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "person.fill")
                        .foregroundColor(AppColors.textSecondary)
                }
            } else {
                Image(systemName: "person.fill")
                    .foregroundColor(AppColors.textSecondary)
            }
        }
        .frame(width: size.dimension, height: size.dimension)
        .clipShape(style.shape)
        .background(AppColors.background)
    }
}

enum AvatarSize {
    case small, medium, large
    
    var dimension: CGFloat {
        switch self {
        case .small: return 32
        case .medium: return 48
        case .large: return 64
        }
    }
}

enum AvatarStyle {
    case circular, rounded, square
    
    var shape: some Shape {
        switch self {
        case .circular: return Circle()
        case .rounded: return RoundedRectangle(cornerRadius: AppRadius.md)
        case .square: return Rectangle()
        }
    }
}
```

## 🎨 Customization

### **Theme Support**
```swift
struct AppTheme {
    let colors: ColorPalette
    let fonts: FontPalette
    let spacing: SpacingPalette
    
    static let light = AppTheme(
        colors: LightColorPalette(),
        fonts: DefaultFontPalette(),
        spacing: DefaultSpacingPalette()
    )
    
    static let dark = AppTheme(
        colors: DarkColorPalette(),
        fonts: DefaultFontPalette(),
        spacing: DefaultSpacingPalette()
    )
}

protocol ColorPalette {
    var primary: Color { get }
    var secondary: Color { get }
    var background: Color { get }
    var surface: Color { get }
    var text: Color { get }
    var textSecondary: Color { get }
    var border: Color { get }
    var success: Color { get }
    var warning: Color { get }
    var error: Color { get }
}
```

### **Animation Support**
```swift
struct AppAnimations {
    static let spring = Animation.spring(response: 0.5, dampingFraction: 0.8)
    static let easeInOut = Animation.easeInOut(duration: 0.3)
    static let easeOut = Animation.easeOut(duration: 0.2)
    static let easeIn = Animation.easeIn(duration: 0.2)
    static let bounce = Animation.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0)
}
```

## 📚 Next Steps

1. **Read [Getting Started](GettingStarted.md)** for quick setup
2. **Explore [Design System](DesignSystem.md)** for design principles
3. **Check [Customization](Customization.md)** for theming options
4. **Review [API Reference](API.md)** for complete documentation

## 🤝 Support

- **Documentation**: [Complete Documentation](Documentation/)
- **Issues**: [GitHub Issues](https://github.com/iosuicomponents/iOSUIComponents/issues)
- **Discussions**: [GitHub Discussions](https://github.com/iosuicomponents/iOSUIComponents/discussions)

---

**Happy coding with iOS UI Components! 🚀** 