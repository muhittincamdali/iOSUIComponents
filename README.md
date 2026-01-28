# iOS UI Components

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-5.9+-F05138?style=flat&logo=swift&logoColor=white" alt="Swift"></a>
  <a href="https://developer.apple.com/ios/"><img src="https://img.shields.io/badge/iOS-15.0+-000000?style=flat&logo=apple&logoColor=white" alt="iOS"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License"></a>
</p>

<p align="center">
  <b>Reusable SwiftUI components for rapid iOS development.</b>
</p>

---

## Components

| Component | Description |
|-----------|-------------|
| **Buttons** | Primary, secondary, icon, loading states |
| **Cards** | Content cards with shadows and borders |
| **Inputs** | Text fields, search bars, OTP inputs |
| **Loaders** | Progress indicators, skeletons, spinners |
| **Alerts** | Toast notifications, banners, dialogs |
| **Navigation** | Tab bars, headers, bottom sheets |

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/iOSUIComponents.git", from: "1.0.0")
]
```

## Quick Start

### Buttons

```swift
import iOSUIComponents

// Primary button
PrimaryButton("Get Started") {
    // Action
}

// Secondary button
SecondaryButton("Learn More") {
    // Action
}

// Icon button
IconButton(systemName: "heart.fill") {
    // Action
}

// Loading button
LoadingButton("Saving...", isLoading: $isLoading) {
    await save()
}
```

### Cards

```swift
// Basic card
Card {
    VStack(alignment: .leading) {
        Text("Card Title")
            .font(.headline)
        Text("Card description")
            .foregroundStyle(.secondary)
    }
}

// Elevated card
Card(elevation: .high) {
    // Content
}

// Image card
ImageCard(image: "photo", title: "Beautiful Sunset")
```

### Text Fields

```swift
// Standard text field
StyledTextField("Email", text: $email)
    .textContentType(.emailAddress)
    .keyboardType(.emailAddress)

// Password field
SecureTextField("Password", text: $password)

// Search bar
SearchBar(text: $searchQuery, placeholder: "Search...")

// OTP input
OTPInput(code: $otpCode, length: 6)
```

### Loading States

```swift
// Spinner
LoadingSpinner()

// Progress bar
ProgressBar(value: 0.7)

// Skeleton loader
SkeletonView()
    .frame(height: 100)

// Shimmer effect
Text("Loading...")
    .shimmer()
```

### Toast Notifications

```swift
@State private var showToast = false

Button("Show Toast") {
    showToast = true
}
.toast(isPresented: $showToast, message: "Saved successfully!", type: .success)

// Toast types: .success, .error, .warning, .info
```

### Bottom Sheet

```swift
@State private var showSheet = false

Button("Open Sheet") {
    showSheet = true
}
.bottomSheet(isPresented: $showSheet) {
    VStack {
        Text("Sheet Content")
        Button("Close") {
            showSheet = false
        }
    }
}
```

### Tab Bar

```swift
CustomTabBar(selection: $selectedTab) {
    TabItem(icon: "house", title: "Home", tag: 0)
    TabItem(icon: "magnifyingglass", title: "Search", tag: 1)
    TabItem(icon: "person", title: "Profile", tag: 2)
}
```

### Avatar

```swift
// Image avatar
Avatar(image: "profile")

// Initials avatar
Avatar(initials: "MC")

// Avatar with badge
Avatar(image: "profile")
    .badge(count: 5)
```

### Rating

```swift
RatingView(rating: $rating, maxRating: 5)
```

### Tag/Chip

```swift
HStack {
    Tag("Swift", color: .orange)
    Tag("iOS", color: .blue)
    Tag("SwiftUI", color: .purple)
}

// Removable tags
RemovableTag("Filter") {
    // Remove action
}
```

## Project Structure

```
iOSUIComponents/
├── Sources/
│   ├── Buttons/
│   ├── Cards/
│   ├── Inputs/
│   ├── Loaders/
│   ├── Feedback/
│   └── Navigation/
├── Examples/
└── Tests/
```

## Requirements

- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE).

## Author

**Muhittin Camdali** — [@muhittincamdali](https://github.com/muhittincamdali)
