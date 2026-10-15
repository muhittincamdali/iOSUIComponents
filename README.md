<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftUI-Components/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/SwiftUI-Components/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/SwiftUI-Components/main/.github/brand/banner-light.svg" alt="SwiftUI Components: Ready-made SwiftUI views for iOS and macOS: buttons, cards, charts, forms and more."></picture></p>

<p align="center"><a href="README.md">English</a> · <a href="#türkçe">Türkçe</a></p>

# iOSUIComponents has moved

This project now lives in [SwiftUI-Components](https://github.com/muhittincamdali/SwiftUI-Components).
This repository is archived and will not receive updates.

SwiftUI Components is a single package of SwiftUI views for iOS 17+ and macOS 14+. The views
from this repository's area are in these modules:

- [Buttons](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/Buttons)
- [Cards](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/Cards)
- [Loading](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/Loading)
- [EmptyStates](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/EmptyStates)
- [Overlays](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/Overlays)

The code was reworked while it was merged, so type names and initializers differ from this
repository's `iOSUIComponents` target. The package contains SwiftUI views only; the UIKit
classes of this repository were not carried over. Read the modules and the
[documentation](https://muhittincamdali.github.io/SwiftUI-Components/documentation/swiftuicomponents/)
before you migrate.

## Install the new package

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/SwiftUI-Components.git", from: "2.1.0")
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "SwiftUIComponents", package: "SwiftUI-Components")
    ])
]
```

Requires iOS 17+ or macOS 14+ and Swift 6.2+.

## Türkçe

**Bu proje artık [SwiftUI-Components](https://github.com/muhittincamdali/SwiftUI-Components) içinde.**
Bu depo arşivlendi ve güncellenmeyecek.

SwiftUI Components, iOS 17+ ve macOS 14+ için tek bir SwiftUI görünüm paketidir. Bu deponun
alanındaki görünümler şu modüllerde:
[Buttons](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/Buttons),
[Cards](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/Cards),
[Loading](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/Loading),
[EmptyStates](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/EmptyStates),
[Overlays](https://github.com/muhittincamdali/SwiftUI-Components/tree/main/Sources/SwiftUIComponents/Overlays).

Kod taşınırken yeniden düzenlendi; tür adları ve başlatıcılar bu depodaki `iOSUIComponents`
hedefinden farklıdır. Paket yalnızca SwiftUI görünümleri içerir; bu depodaki UIKit sınıfları
taşınmadı. Geçiş yapmadan önce modülleri ve
[belgeleri](https://muhittincamdali.github.io/SwiftUI-Components/documentation/swiftuicomponents/) okuyun.

Kurulum için yukarıdaki Swift Package Manager satırlarını kullanın. iOS 17+ veya macOS 14+ ve
Swift 6.2+ gerekir.
