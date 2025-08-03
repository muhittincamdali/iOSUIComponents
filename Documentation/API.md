# 📚 API Reference

Complete API documentation for iOS UI Components.

## 📋 Table of Contents

- [Button Components](#button-components)
- [Card Components](#card-components)
- [Input Components](#input-components)
- [Navigation Components](#navigation-components)
- [Layout Components](#layout-components)
- [Feedback Components](#feedback-components)
- [Utility Components](#utility-components)

## 🔘 Button Components

### **PrimaryButton**
A primary action button with customizable styling.

```swift
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    let isEnabled: Bool
    let isLoading: Bool
    
    init(
        title: String,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    )
}
```

**Properties:**
- `title`: Button text
- `action`: Closure to execute when tapped
- `isEnabled`: Whether button is interactive
- `isLoading`: Shows loading state

**Example:**
```swift
PrimaryButton(
    title: "Save Changes",
    isLoading: false
) {
    // Handle save action
}
```

### **SecondaryButton**
A secondary action button with outline styling.

```swift
struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    let isEnabled: Bool
    let isLoading: Bool
    
    init(
        title: String,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    )
}
```

**Example:**
```swift
SecondaryButton(
    title: "Cancel",
    isEnabled: true
) {
    // Handle cancel action
}
```

### **IconButton**
A button with an icon and optional text.

```swift
struct IconButton: View {
    let icon: String
    let title: String?
    let action: () -> Void
    let isEnabled: Bool
    
    init(
        icon: String,
        title: String? = nil,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    )
}
```

**Example:**
```swift
IconButton(
    icon: "heart.fill",
    title: "Like"
) {
    // Handle like action
}
```

### **FloatingActionButton**
A floating action button for primary actions.

```swift
struct FloatingActionButton: View {
    let icon: String
    let action: () -> Void
    let backgroundColor: Color
    
    init(
        icon: String,
        backgroundColor: Color = .blue,
        action: @escaping () -> Void
    )
}
```

**Example:**
```swift
FloatingActionButton(
    icon: "plus",
    backgroundColor: .orange
) {
    // Handle add action
}
```

## 🃏 Card Components

### **Card**
A basic card component with customizable content.

```swift
struct Card<Content: View>: View {
    let content: Content
    let style: CardStyle
    let padding: EdgeInsets
    
    init(
        style: CardStyle = .default,
        padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        @ViewBuilder content: () -> Content
    )
}
```

**CardStyle Options:**
- `.default`: Standard card with shadow
- `.elevated`: Card with enhanced shadow
- `.outlined`: Card with border only
- `.flat`: Card without shadow or border

**Example:**
```swift
Card(style: .elevated) {
    VStack(alignment: .leading, spacing: 12) {
        Text("Card Title")
            .font(.headline)
        Text("Card content goes here")
            .font(.body)
    }
}
```

### **ProfileCard**
A card designed for user profiles.

```swift
struct ProfileCard: View {
    let avatar: String
    let name: String
    let subtitle: String?
    let action: (() -> Void)?
    
    init(
        avatar: String,
        name: String,
        subtitle: String? = nil,
        action: (() -> Void)? = nil
    )
}
```

**Example:**
```swift
ProfileCard(
    avatar: "user.avatar",
    name: "John Doe",
    subtitle: "Software Engineer"
) {
    // Handle profile tap
}
```

### **InfoCard**
A card for displaying information with icons.

```swift
struct InfoCard: View {
    let icon: String
    let title: String
    let description: String
    let action: (() -> Void)?
    
    init(
        icon: String,
        title: String,
        description: String,
        action: (() -> Void)? = nil
    )
}
```

**Example:**
```swift
InfoCard(
    icon: "info.circle",
    title: "Information",
    description: "This is an informational card"
) {
    // Handle card tap
}
```

## 📝 Input Components

### **CustomTextField**
A customizable text input field.

```swift
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String?
    let validation: TextFieldValidation
    let isSecure: Bool
    
    init(
        text: Binding<String>,
        placeholder: String,
        icon: String? = nil,
        validation: TextFieldValidation = .none,
        isSecure: Bool = false
    )
}
```

**TextFieldValidation Options:**
- `.none`: No validation
- `.email`: Email format validation
- `.password`: Password strength validation
- `.phone`: Phone number validation
- `.custom`: Custom validation rule

**Example:**
```swift
CustomTextField(
    text: $email,
    placeholder: "Enter email",
    icon: "envelope",
    validation: .email
)
```

### **CustomToggle**
A customizable toggle switch.

```swift
struct CustomToggle: View {
    @Binding var isOn: Bool
    let title: String
    let subtitle: String?
    let icon: String?
    
    init(
        isOn: Binding<Bool>,
        title: String,
        subtitle: String? = nil,
        icon: String? = nil
    )
}
```

**Example:**
```swift
CustomToggle(
    isOn: $notificationsEnabled,
    title: "Enable Notifications",
    subtitle: "Receive push notifications"
)
```

### **CustomSlider**
A customizable slider component.

```swift
struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let title: String?
    
    init(
        value: Binding<Double>,
        range: ClosedRange<Double>,
        step: Double = 1.0,
        title: String? = nil
    )
}
```

**Example:**
```swift
CustomSlider(
    value: $brightness,
    range: 0...100,
    step: 1,
    title: "Brightness"
)
```

### **CustomPicker**
A customizable picker component.

```swift
struct CustomPicker<SelectionValue: Hashable>: View {
    @Binding var selection: SelectionValue
    let options: [SelectionValue]
    let title: String?
    let placeholder: String?
    
    init(
        selection: Binding<SelectionValue>,
        options: [SelectionValue],
        title: String? = nil,
        placeholder: String? = nil
    )
}
```

**Example:**
```swift
CustomPicker(
    selection: $selectedCountry,
    options: countries,
    title: "Country",
    placeholder: "Select country"
)
```

## 🧭 Navigation Components

### **CustomNavigationBar**
A customizable navigation bar.

```swift
struct CustomNavigationBar: View {
    let title: String
    let leftButton: NavigationButton?
    let rightButton: NavigationButton?
    let backgroundColor: Color
    
    init(
        title: String,
        leftButton: NavigationButton? = nil,
        rightButton: NavigationButton? = nil,
        backgroundColor: Color = .systemBackground
    )
}
```

**NavigationButton:**
```swift
struct NavigationButton {
    let icon: String
    let action: () -> Void
    let isEnabled: Bool
    
    init(
        icon: String,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    )
}
```

**Example:**
```swift
CustomNavigationBar(
    title: "Profile",
    leftButton: NavigationButton(
        icon: "chevron.left"
    ) {
        // Handle back action
    },
    rightButton: NavigationButton(
        icon: "ellipsis"
    ) {
        // Handle menu action
    }
)
```

### **CustomTabBar**
A customizable tab bar.

```swift
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let tabs: [TabItem]
    
    init(
        selectedTab: Binding<Int>,
        tabs: [TabItem]
    )
}
```

**TabItem:**
```swift
struct TabItem {
    let icon: String
    let title: String
    let badge: String?
    
    init(
        icon: String,
        title: String,
        badge: String? = nil
    )
}
```

**Example:**
```swift
CustomTabBar(
    selectedTab: $selectedTab,
    tabs: [
        TabItem(icon: "house", title: "Home"),
        TabItem(icon: "heart", title: "Favorites", badge: "3"),
        TabItem(icon: "person", title: "Profile")
    ]
)
```

## 📐 Layout Components

### **CustomStack**
A flexible stack layout component.

```swift
struct CustomStack<Content: View>: View {
    let axis: Axis
    let spacing: CGFloat?
    let alignment: Alignment
    let content: Content
    
    init(
        axis: Axis = .vertical,
        spacing: CGFloat? = nil,
        alignment: Alignment = .center,
        @ViewBuilder content: () -> Content
    )
}
```

**Example:**
```swift
CustomStack(
    axis: .horizontal,
    spacing: 16,
    alignment: .center
) {
    IconButton(icon: "star") { }
    Text("Favorites")
    Spacer()
}
```

### **CustomGrid**
A customizable grid layout.

```swift
struct CustomGrid<Content: View>: View {
    let columns: Int
    let spacing: CGFloat
    let content: Content
    
    init(
        columns: Int,
        spacing: CGFloat = 16,
        @ViewBuilder content: () -> Content
    )
}
```

**Example:**
```swift
CustomGrid(columns: 2, spacing: 16) {
    ForEach(items) { item in
        ItemCard(item: item)
    }
}
```

### **CustomLazyGrid**
A lazy-loading grid for large datasets.

```swift
struct CustomLazyGrid<Content: View>: View {
    let columns: [GridItem]
    let spacing: CGFloat
    let content: Content
    
    init(
        columns: [GridItem],
        spacing: CGFloat = 16,
        @ViewBuilder content: () -> Content
    )
}
```

**Example:**
```swift
CustomLazyGrid(
    columns: Array(repeating: GridItem(.flexible()), count: 3),
    spacing: 16
) {
    ForEach(largeDataset) { item in
        ItemView(item: item)
    }
}
```

## 💬 Feedback Components

### **CustomAlert**
A customizable alert dialog.

```swift
struct CustomAlert: View {
    let title: String
    let message: String?
    let primaryButton: AlertButton
    let secondaryButton: AlertButton?
    let isPresented: Binding<Bool>
    
    init(
        title: String,
        message: String? = nil,
        primaryButton: AlertButton,
        secondaryButton: AlertButton? = nil,
        isPresented: Binding<Bool>
    )
}
```

**AlertButton:**
```swift
struct AlertButton {
    let title: String
    let style: AlertButtonStyle
    let action: () -> Void
    
    init(
        title: String,
        style: AlertButtonStyle = .default,
        action: @escaping () -> Void
    )
}
```

**AlertButtonStyle Options:**
- `.default`: Standard button style
- `.destructive`: Red/danger button style
- `.cancel`: Cancel button style

**Example:**
```swift
CustomAlert(
    title: "Delete Item",
    message: "Are you sure you want to delete this item?",
    primaryButton: AlertButton(
        title: "Delete",
        style: .destructive
    ) {
        // Handle delete
    },
    secondaryButton: AlertButton(
        title: "Cancel",
        style: .cancel
    ) {
        // Handle cancel
    },
    isPresented: $showAlert
)
```

### **CustomToast**
A customizable toast notification.

```swift
struct CustomToast: View {
    let message: String
    let type: ToastType
    let duration: TimeInterval
    let isPresented: Binding<Bool>
    
    init(
        message: String,
        type: ToastType = .info,
        duration: TimeInterval = 3.0,
        isPresented: Binding<Bool>
    )
}
```

**ToastType Options:**
- `.success`: Green success toast
- `.error`: Red error toast
- `.warning`: Yellow warning toast
- `.info`: Blue info toast

**Example:**
```swift
CustomToast(
    message: "Changes saved successfully!",
    type: .success,
    isPresented: $showToast
)
```

### **CustomProgressView**
A customizable progress indicator.

```swift
struct CustomProgressView: View {
    let progress: Double
    let style: ProgressViewStyle
    let title: String?
    
    init(
        progress: Double,
        style: ProgressViewStyle = .linear,
        title: String? = nil
    )
}
```

**ProgressViewStyle Options:**
- `.linear`: Horizontal progress bar
- `.circular`: Circular progress indicator
- `.indeterminate`: Spinning indicator

**Example:**
```swift
CustomProgressView(
    progress: 0.75,
    style: .linear,
    title: "Uploading..."
)
```

## 🛠️ Utility Components

### **CustomDivider**
A customizable divider line.

```swift
struct CustomDivider: View {
    let color: Color
    let thickness: CGFloat
    let spacing: CGFloat
    
    init(
        color: Color = .gray.opacity(0.3),
        thickness: CGFloat = 1,
        spacing: CGFloat = 16
    )
}
```

**Example:**
```swift
VStack(spacing: 16) {
    Text("Section 1")
    CustomDivider()
    Text("Section 2")
}
```

### **CustomSpacer**
A flexible spacer component.

```swift
struct CustomSpacer: View {
    let minLength: CGFloat?
    
    init(minLength: CGFloat? = nil)
}
```

**Example:**
```swift
HStack {
    Text("Left")
    CustomSpacer()
    Text("Right")
}
```

### **CustomDivider**
A customizable divider line.

```swift
struct CustomDivider: View {
    let color: Color
    let thickness: CGFloat
    let spacing: CGFloat
    
    init(
        color: Color = .gray.opacity(0.3),
        thickness: CGFloat = 1,
        spacing: CGFloat = 16
    )
}
```

**Example:**
```swift
VStack(spacing: 16) {
    Text("Section 1")
    CustomDivider()
    Text("Section 2")
}
```

## 🎨 Styling

### **ButtonStyle**
Custom button styles for different use cases.

```swift
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View
}

struct OutlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View
}
```

**Example:**
```swift
Button("Custom Button") {
    // Action
}
.buttonStyle(PrimaryButtonStyle())
```

### **ViewModifier**
Custom view modifiers for consistent styling.

```swift
struct CardModifier: ViewModifier {
    let style: CardStyle
    
    func body(content: Content) -> some View
}

struct ShadowModifier: ViewModifier {
    let radius: CGFloat
    let color: Color
    
    func body(content: Content) -> some View
}
```

**Example:**
```swift
Text("Styled Text")
    .modifier(CardModifier(style: .elevated))
    .modifier(ShadowModifier(radius: 4, color: .black.opacity(0.1)))
```

## 📚 Next Steps

1. **Read [Getting Started](GettingStarted.md)** for quick setup
2. **Check [Component Guide](ComponentGuide.md)** for component usage
3. **Explore [Design System](DesignSystem.md)** for design principles
4. **Review [Customization](Customization.md)** for theming options

## 🤝 Support

- **Documentation**: [Complete Documentation](Documentation/)
- **Issues**: [GitHub Issues](https://github.com/iosuicomponents/iOSUIComponents/issues)
- **Discussions**: [GitHub Discussions](https://github.com/iosuicomponents/iOSUIComponents/discussions)

---

**Happy building with iOS UI Components! 🚀** 