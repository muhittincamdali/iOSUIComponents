import XCTest
@testable import iOSUIComponents

final class iOSUIComponentsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Design System Tests
    
    func testDesignSystemColors() {
        // Given & When & Then
        XCTAssertNotNil(DesignSystem.Colors.primary)
        XCTAssertNotNil(DesignSystem.Colors.secondary)
        XCTAssertNotNil(DesignSystem.Colors.accent)
        XCTAssertNotNil(DesignSystem.Colors.background)
        XCTAssertNotNil(DesignSystem.Colors.surface)
        XCTAssertNotNil(DesignSystem.Colors.text)
        XCTAssertNotNil(DesignSystem.Colors.textSecondary)
        XCTAssertNotNil(DesignSystem.Colors.border)
        XCTAssertNotNil(DesignSystem.Colors.divider)
        XCTAssertNotNil(DesignSystem.Colors.success)
        XCTAssertNotNil(DesignSystem.Colors.warning)
        XCTAssertNotNil(DesignSystem.Colors.error)
        XCTAssertNotNil(DesignSystem.Colors.info)
        XCTAssertNotNil(DesignSystem.Colors.online)
        XCTAssertNotNil(DesignSystem.Colors.offline)
        XCTAssertNotNil(DesignSystem.Colors.busy)
        XCTAssertNotNil(DesignSystem.Colors.away)
    }
    
    func testDesignSystemTypography() {
        // Given & When & Then
        XCTAssertEqual(DesignSystem.Typography.displayLarge, 57)
        XCTAssertEqual(DesignSystem.Typography.displayMedium, 45)
        XCTAssertEqual(DesignSystem.Typography.displaySmall, 36)
        XCTAssertEqual(DesignSystem.Typography.headlineLarge, 32)
        XCTAssertEqual(DesignSystem.Typography.headlineMedium, 28)
        XCTAssertEqual(DesignSystem.Typography.headlineSmall, 24)
        XCTAssertEqual(DesignSystem.Typography.titleLarge, 22)
        XCTAssertEqual(DesignSystem.Typography.titleMedium, 16)
        XCTAssertEqual(DesignSystem.Typography.titleSmall, 14)
        XCTAssertEqual(DesignSystem.Typography.bodyLarge, 16)
        XCTAssertEqual(DesignSystem.Typography.bodyMedium, 14)
        XCTAssertEqual(DesignSystem.Typography.bodySmall, 12)
        XCTAssertEqual(DesignSystem.Typography.labelLarge, 14)
        XCTAssertEqual(DesignSystem.Typography.labelMedium, 12)
        XCTAssertEqual(DesignSystem.Typography.labelSmall, 11)
        
        // Font Weights
        XCTAssertEqual(DesignSystem.Typography.light, .light)
        XCTAssertEqual(DesignSystem.Typography.regular, .regular)
        XCTAssertEqual(DesignSystem.Typography.medium, .medium)
        XCTAssertEqual(DesignSystem.Typography.semibold, .semibold)
        XCTAssertEqual(DesignSystem.Typography.bold, .bold)
        XCTAssertEqual(DesignSystem.Typography.heavy, .heavy)
        
        // Line Heights
        XCTAssertEqual(DesignSystem.Typography.lineHeightTight, 1.2)
        XCTAssertEqual(DesignSystem.Typography.lineHeightNormal, 1.4)
        XCTAssertEqual(DesignSystem.Typography.lineHeightRelaxed, 1.6)
        XCTAssertEqual(DesignSystem.Typography.lineHeightLoose, 1.8)
    }
    
    func testDesignSystemSpacing() {
        // Given & When & Then
        XCTAssertEqual(DesignSystem.Spacing.xs, 4)
        XCTAssertEqual(DesignSystem.Spacing.sm, 8)
        XCTAssertEqual(DesignSystem.Spacing.md, 16)
        XCTAssertEqual(DesignSystem.Spacing.lg, 24)
        XCTAssertEqual(DesignSystem.Spacing.xl, 32)
        XCTAssertEqual(DesignSystem.Spacing.xxl, 48)
        XCTAssertEqual(DesignSystem.Spacing.xxxl, 64)
        
        // Component Spacing
        XCTAssertEqual(DesignSystem.Spacing.buttonPadding, 16)
        XCTAssertEqual(DesignSystem.Spacing.cardPadding, 16)
        XCTAssertEqual(DesignSystem.Spacing.listItemSpacing, 8)
        XCTAssertEqual(DesignSystem.Spacing.sectionSpacing, 24)
        XCTAssertEqual(DesignSystem.Spacing.screenPadding, 16)
        XCTAssertEqual(DesignSystem.Spacing.modalPadding, 24)
    }
    
    func testDesignSystemBorderRadius() {
        // Given & When & Then
        XCTAssertEqual(DesignSystem.BorderRadius.none, 0)
        XCTAssertEqual(DesignSystem.BorderRadius.xs, 2)
        XCTAssertEqual(DesignSystem.BorderRadius.sm, 4)
        XCTAssertEqual(DesignSystem.BorderRadius.md, 8)
        XCTAssertEqual(DesignSystem.BorderRadius.lg, 12)
        XCTAssertEqual(DesignSystem.BorderRadius.xl, 16)
        XCTAssertEqual(DesignSystem.BorderRadius.xxl, 24)
        XCTAssertEqual(DesignSystem.BorderRadius.full, 999)
        
        // Component Radius
        XCTAssertEqual(DesignSystem.BorderRadius.button, 8)
        XCTAssertEqual(DesignSystem.BorderRadius.card, 12)
        XCTAssertEqual(DesignSystem.BorderRadius.input, 8)
        XCTAssertEqual(DesignSystem.BorderRadius.avatar, 50)
        XCTAssertEqual(DesignSystem.BorderRadius.badge, 12)
        XCTAssertEqual(DesignSystem.BorderRadius.modal, 16)
    }
    
    func testDesignSystemShadows() {
        // Given & When & Then
        XCTAssertEqual(DesignSystem.Shadows.none.radius, 0)
        XCTAssertEqual(DesignSystem.Shadows.sm.radius, 1)
        XCTAssertEqual(DesignSystem.Shadows.md.radius, 4)
        XCTAssertEqual(DesignSystem.Shadows.lg.radius, 8)
        XCTAssertEqual(DesignSystem.Shadows.xl.radius, 16)
        XCTAssertEqual(DesignSystem.Shadows.xxl.radius, 24)
        
        // Component Shadows
        XCTAssertEqual(DesignSystem.Shadows.button.radius, 4)
        XCTAssertEqual(DesignSystem.Shadows.card.radius, 8)
        XCTAssertEqual(DesignSystem.Shadows.modal.radius, 16)
        XCTAssertEqual(DesignSystem.Shadows.dropdown.radius, 4)
        XCTAssertEqual(DesignSystem.Shadows.tooltip.radius, 1)
    }
    
    // MARK: - Color Tests
    
    func testColorHexInitialization() {
        // Given & When & Then
        let validColor = Color(hex: "#FF0000")
        XCTAssertNotNil(validColor)
        
        let invalidColor = Color(hex: "invalid")
        XCTAssertNotNil(invalidColor) // Should return default color
        
        let shortHexColor = Color(hex: "#F00")
        XCTAssertNotNil(shortHexColor)
        
        let longHexColor = Color(hex: "#FF0000FF")
        XCTAssertNotNil(longHexColor)
    }
    
    // MARK: - Theme Tests
    
    func testLightTheme() {
        // Given & When
        let theme = Theme.light
        
        // Then
        XCTAssertNotNil(theme.colors)
        XCTAssertNotNil(theme.typography)
        XCTAssertNotNil(theme.spacing)
    }
    
    func testDarkTheme() {
        // Given & When
        let theme = Theme.dark
        
        // Then
        XCTAssertNotNil(theme.colors)
        XCTAssertNotNil(theme.typography)
        XCTAssertNotNil(theme.spacing)
    }
    
    // MARK: - Color Palette Tests
    
    func testLightColorPalette() {
        // Given & When
        let palette = LightColorPalette()
        
        // Then
        XCTAssertNotNil(palette.primary)
        XCTAssertNotNil(palette.secondary)
        XCTAssertNotNil(palette.accent)
        XCTAssertNotNil(palette.background)
        XCTAssertNotNil(palette.surface)
        XCTAssertNotNil(palette.text)
        XCTAssertNotNil(palette.textSecondary)
        XCTAssertNotNil(palette.border)
        XCTAssertNotNil(palette.success)
        XCTAssertNotNil(palette.warning)
        XCTAssertNotNil(palette.error)
    }
    
    func testDarkColorPalette() {
        // Given & When
        let palette = DarkColorPalette()
        
        // Then
        XCTAssertNotNil(palette.primary)
        XCTAssertNotNil(palette.secondary)
        XCTAssertNotNil(palette.accent)
        XCTAssertNotNil(palette.background)
        XCTAssertNotNil(palette.surface)
        XCTAssertNotNil(palette.text)
        XCTAssertNotNil(palette.textSecondary)
        XCTAssertNotNil(palette.border)
        XCTAssertNotNil(palette.success)
        XCTAssertNotNil(palette.warning)
        XCTAssertNotNil(palette.error)
    }
    
    // MARK: - Typography Palette Tests
    
    func testDefaultTypographyPalette() {
        // Given & When
        let palette = DefaultTypographyPalette()
        
        // Then
        XCTAssertNotNil(palette.displayLarge)
        XCTAssertNotNil(palette.displayMedium)
        XCTAssertNotNil(palette.displaySmall)
        XCTAssertNotNil(palette.headlineLarge)
        XCTAssertNotNil(palette.headlineMedium)
        XCTAssertNotNil(palette.headlineSmall)
        XCTAssertNotNil(palette.titleLarge)
        XCTAssertNotNil(palette.titleMedium)
        XCTAssertNotNil(palette.titleSmall)
        XCTAssertNotNil(palette.bodyLarge)
        XCTAssertNotNil(palette.bodyMedium)
        XCTAssertNotNil(palette.bodySmall)
        XCTAssertNotNil(palette.labelLarge)
        XCTAssertNotNil(palette.labelMedium)
        XCTAssertNotNil(palette.labelSmall)
    }
    
    // MARK: - Spacing Palette Tests
    
    func testDefaultSpacingPalette() {
        // Given & When
        let palette = DefaultSpacingPalette()
        
        // Then
        XCTAssertEqual(palette.xs, DesignSystem.Spacing.xs)
        XCTAssertEqual(palette.sm, DesignSystem.Spacing.sm)
        XCTAssertEqual(palette.md, DesignSystem.Spacing.md)
        XCTAssertEqual(palette.lg, DesignSystem.Spacing.lg)
        XCTAssertEqual(palette.xl, DesignSystem.Spacing.xl)
        XCTAssertEqual(palette.xxl, DesignSystem.Spacing.xxl)
        XCTAssertEqual(palette.xxxl, DesignSystem.Spacing.xxxl)
    }
    
    // MARK: - Shadow Tests
    
    func testShadowInitialization() {
        // Given
        let radius: CGFloat = 4
        let x: CGFloat = 0
        let y: CGFloat = 2
        let opacity: Double = 0.1
        
        // When
        let shadow = Shadow(radius: radius, x: x, y: y, opacity: opacity)
        
        // Then
        XCTAssertEqual(shadow.radius, radius)
        XCTAssertEqual(shadow.x, x)
        XCTAssertEqual(shadow.y, y)
        XCTAssertEqual(shadow.opacity, opacity)
    }
    
    // MARK: - iOS UI Components Tests
    
    func testiOSUIComponentsVersion() {
        // Given & When & Then
        XCTAssertEqual(iOSUIComponents.version, "1.0.0")
    }
    
    func testiOSUIComponentsInitialization() {
        // Given & When & Then
        // This test verifies that initialization doesn't crash
        iOSUIComponents.initialize()
    }
    
    // MARK: - Button Component Tests
    
    func testPrimaryButton() {
        // Given & When & Then
        let button = PrimaryButton(title: "Test Button") {
            // Action
        }
        XCTAssertNotNil(button)
    }
    
    func testSecondaryButton() {
        // Given & When & Then
        let button = SecondaryButton(title: "Test Button") {
            // Action
        }
        XCTAssertNotNil(button)
    }
    
    func testIconButton() {
        // Given & When & Then
        let button = IconButton(icon: "star.fill") {
            // Action
        }
        XCTAssertNotNil(button)
    }
    
    func testFloatingActionButton() {
        // Given & When & Then
        let button = FloatingActionButton(icon: "plus") {
            // Action
        }
        XCTAssertNotNil(button)
    }
    
    func testToggleButton() {
        // Given & When & Then
        let button = ToggleButton(title: "Toggle", isOn: .constant(true)) {
            // Action
        }
        XCTAssertNotNil(button)
    }
    
    func testGradientButton() {
        // Given & When & Then
        let button = GradientButton(title: "Gradient", colors: [.blue, .purple]) {
            // Action
        }
        XCTAssertNotNil(button)
    }
    
    func testSocialButton() {
        // Given & When & Then
        let button = SocialButton(title: "Apple", icon: "applelogo", style: .apple) {
            // Action
        }
        XCTAssertNotNil(button)
    }
    
    // MARK: - Card Component Tests
    
    func testCard() {
        // Given & When & Then
        let card = Card {
            Text("Card Content")
        }
        XCTAssertNotNil(card)
    }
    
    func testProfileCard() {
        // Given & When & Then
        let card = ProfileCard(
            name: "John Doe",
            email: "john@example.com",
            avatar: "person.circle.fill",
            bio: "iOS Developer"
        )
        XCTAssertNotNil(card)
    }
    
    func testInfoCard() {
        // Given & When & Then
        let card = InfoCard(
            title: "Statistics",
            subtitle: "Last 30 days",
            icon: "chart.bar.fill",
            value: "1,234",
            unit: "views"
        )
        XCTAssertNotNil(card)
    }
    
    func testProductCard() {
        // Given & When & Then
        let card = ProductCard(
            name: "iPhone 15 Pro",
            description: "The most advanced iPhone ever",
            price: "$999",
            image: "iphone",
            rating: 4.8,
            reviewCount: 1250
        )
        XCTAssertNotNil(card)
    }
    
    func testPostCard() {
        // Given & When & Then
        let card = PostCard(
            author: "Jane Smith",
            content: "Just finished building an amazing iOS app!",
            timestamp: Date(),
            likes: 42,
            comments: 8,
            shares: 3
        )
        XCTAssertNotNil(card)
    }
    
    // MARK: - Input Component Tests
    
    func testCustomTextField() {
        // Given & When & Then
        let textField = CustomTextField(
            text: .constant(""),
            placeholder: "Enter text",
            icon: "envelope.fill"
        )
        XCTAssertNotNil(textField)
    }
    
    func testCustomToggle() {
        // Given & When & Then
        let toggle = CustomToggle(
            isOn: .constant(true),
            title: "Notifications",
            subtitle: "Receive push notifications"
        )
        XCTAssertNotNil(toggle)
    }
    
    func testCustomSlider() {
        // Given & When & Then
        let slider = CustomSlider(
            value: .constant(50),
            range: 0...100,
            title: "Volume",
            subtitle: "Adjust the volume level"
        )
        XCTAssertNotNil(slider)
    }
    
    func testSearchBar() {
        // Given & When & Then
        let searchBar = SearchBar(
            text: .constant(""),
            placeholder: "Search..."
        )
        XCTAssertNotNil(searchBar)
    }
    
    func testCustomPicker() {
        // Given & When & Then
        let picker = CustomPicker(
            selection: .constant("Option 1"),
            options: ["Option 1", "Option 2", "Option 3"],
            title: "Select Option",
            subtitle: "Choose from available options"
        )
        XCTAssertNotNil(picker)
    }
    
    // MARK: - Navigation Component Tests
    
    func testCustomNavigationBar() {
        // Given & When & Then
        let navigationBar = CustomNavigationBar(
            title: "Screen Title",
            leftButton: NavigationButton(icon: "chevron.left") { },
            rightButton: NavigationButton(icon: "gear") { }
        )
        XCTAssertNotNil(navigationBar)
    }
    
    func testCustomTabBar() {
        // Given & When & Then
        let tabBar = CustomTabBar(
            selection: .constant(0),
            items: [
                TabItem(icon: "house", title: "Home"),
                TabItem(icon: "person", title: "Profile")
            ]
        )
        XCTAssertNotNil(tabBar)
    }
    
    func testBreadcrumbNavigation() {
        // Given & When & Then
        let breadcrumb = BreadcrumbNavigation(
            items: [
                BreadcrumbItem(title: "Home") { },
                BreadcrumbItem(title: "Products") { },
                BreadcrumbItem(title: "Electronics") { }
            ]
        )
        XCTAssertNotNil(breadcrumb)
    }
    
    func testStepIndicator() {
        // Given & When & Then
        let stepIndicator = StepIndicator(
            currentStep: 2,
            totalSteps: 4,
            steps: ["Step 1", "Step 2", "Step 3", "Step 4"]
        )
        XCTAssertNotNil(stepIndicator)
    }
    
    // MARK: - List Component Tests
    
    func testCustomList() {
        // Given & When & Then
        let list = CustomList {
            ForEach(0..<5) { index in
                Text("Item \(index)")
            }
        }
        XCTAssertNotNil(list)
    }
    
    func testUserRowView() {
        // Given & When & Then
        let user = User(id: "1", name: "John Doe", email: "john@example.com", avatar: "person.circle.fill")
        let rowView = UserRowView(user: user)
        XCTAssertNotNil(rowView)
    }
    
    func testSettingsRowView() {
        // Given & When & Then
        let rowView = SettingsRowView(
            icon: "bell",
            title: "Notifications",
            subtitle: "Manage your notifications",
            accessory: .switch
        ) {
            // Action
        }
        XCTAssertNotNil(rowView)
    }
    
    func testProductRowView() {
        // Given & When & Then
        let product = Product(id: "1", name: "iPhone 15 Pro", price: "$999", image: "iphone")
        let rowView = ProductRowView(product: product)
        XCTAssertNotNil(rowView)
    }
    
    // MARK: - Modal Component Tests
    
    func testCustomAlert() {
        // Given & When & Then
        let alert = CustomAlert(
            title: "Alert Title",
            message: "Alert message",
            primaryButton: AlertButton(title: "OK", style: .primary) { },
            secondaryButton: AlertButton(title: "Cancel", style: .secondary) { }
        )
        XCTAssertNotNil(alert)
    }
    
    func testCustomSheet() {
        // Given & When & Then
        let sheet = CustomSheet {
            VStack {
                Text("Sheet Content")
                Button("Dismiss") { }
            }
        }
        XCTAssertNotNil(sheet)
    }
    
    func testCustomActionSheet() {
        // Given & When & Then
        let actionSheet = CustomActionSheet(
            title: "Choose Action",
            message: "Select an action to perform",
            actions: [
                ActionButton(title: "Take Photo", icon: "camera", style: .default) { },
                ActionButton(title: "Cancel", icon: "xmark", style: .cancel) { }
            ]
        )
        XCTAssertNotNil(actionSheet)
    }
    
    func testCustomModal() {
        // Given & When & Then
        let modal = CustomModal {
            VStack {
                Text("Modal Content")
                Button("Close") { }
            }
        }
        XCTAssertNotNil(modal)
    }
}

// MARK: - Test Models

struct User: Identifiable {
    let id: String
    let name: String
    let email: String
    let avatar: String
}

struct Product: Identifiable {
    let id: String
    let name: String
    let price: String
    let image: String
} 