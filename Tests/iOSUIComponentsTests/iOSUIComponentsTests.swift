import XCTest
@testable import iOSUIComponents

final class iOSUIComponentsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        iOSUIComponents.initialize()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Design System Tests
    func testDesignSystemColors() {
        // Test primary colors
        XCTAssertNotNil(DesignSystem.Colors.primary)
        XCTAssertNotNil(DesignSystem.Colors.secondary)
        XCTAssertNotNil(DesignSystem.Colors.accent)
        
        // Test semantic colors
        XCTAssertNotNil(DesignSystem.Colors.success)
        XCTAssertNotNil(DesignSystem.Colors.warning)
        XCTAssertNotNil(DesignSystem.Colors.error)
        
        // Test neutral colors
        XCTAssertNotNil(DesignSystem.Colors.background)
        XCTAssertNotNil(DesignSystem.Colors.surface)
        XCTAssertNotNil(DesignSystem.Colors.text)
    }
    
    func testDesignSystemTypography() {
        // Test heading fonts
        XCTAssertNotNil(DesignSystem.Typography.h1)
        XCTAssertNotNil(DesignSystem.Typography.h2)
        XCTAssertNotNil(DesignSystem.Typography.h3)
        
        // Test body fonts
        XCTAssertNotNil(DesignSystem.Typography.bodyLarge)
        XCTAssertNotNil(DesignSystem.Typography.body)
        XCTAssertNotNil(DesignSystem.Typography.bodySmall)
        
        // Test caption fonts
        XCTAssertNotNil(DesignSystem.Typography.caption)
        XCTAssertNotNil(DesignSystem.Typography.captionSmall)
        
        // Test button fonts
        XCTAssertNotNil(DesignSystem.Typography.button)
        XCTAssertNotNil(DesignSystem.Typography.buttonSmall)
    }
    
    func testDesignSystemSpacing() {
        XCTAssertEqual(DesignSystem.Spacing.xs, 4)
        XCTAssertEqual(DesignSystem.Spacing.sm, 8)
        XCTAssertEqual(DesignSystem.Spacing.md, 16)
        XCTAssertEqual(DesignSystem.Spacing.lg, 24)
        XCTAssertEqual(DesignSystem.Spacing.xl, 32)
        XCTAssertEqual(DesignSystem.Spacing.xxl, 48)
    }
    
    func testDesignSystemBorderRadius() {
        XCTAssertEqual(DesignSystem.BorderRadius.xs, 4)
        XCTAssertEqual(DesignSystem.BorderRadius.sm, 8)
        XCTAssertEqual(DesignSystem.BorderRadius.md, 12)
        XCTAssertEqual(DesignSystem.BorderRadius.lg, 16)
        XCTAssertEqual(DesignSystem.BorderRadius.xl, 20)
        XCTAssertEqual(DesignSystem.BorderRadius.xxl, 24)
        XCTAssertEqual(DesignSystem.BorderRadius.round, 50)
    }
    
    func testDesignSystemShadows() {
        // Test shadow properties
        XCTAssertNotNil(DesignSystem.Shadows.small)
        XCTAssertNotNil(DesignSystem.Shadows.medium)
        XCTAssertNotNil(DesignSystem.Shadows.large)
        XCTAssertNotNil(DesignSystem.Shadows.extraLarge)
        
        // Test shadow values
        XCTAssertEqual(DesignSystem.Shadows.small.radius, 2)
        XCTAssertEqual(DesignSystem.Shadows.medium.radius, 4)
        XCTAssertEqual(DesignSystem.Shadows.large.radius, 8)
        XCTAssertEqual(DesignSystem.Shadows.extraLarge.radius, 16)
    }
    
    // MARK: - Color Extension Tests
    func testColorHexInitialization() {
        // Test valid hex colors
        let redColor = Color(hex: "#FF0000")
        let greenColor = Color(hex: "#00FF00")
        let blueColor = Color(hex: "#0000FF")
        
        XCTAssertNotNil(redColor)
        XCTAssertNotNil(greenColor)
        XCTAssertNotNil(blueColor)
        
        // Test short hex colors
        let shortRed = Color(hex: "#F00")
        let shortGreen = Color(hex: "#0F0")
        let shortBlue = Color(hex: "#00F")
        
        XCTAssertNotNil(shortRed)
        XCTAssertNotNil(shortGreen)
        XCTAssertNotNil(shortBlue)
        
        // Test invalid hex colors
        let invalidColor = Color(hex: "invalid")
        XCTAssertNotNil(invalidColor) // Should not crash
    }
    
    // MARK: - Theme Tests
    func testLightTheme() {
        let lightTheme = Theme.light
        
        XCTAssertNotNil(lightTheme.colors.primary)
        XCTAssertNotNil(lightTheme.colors.secondary)
        XCTAssertNotNil(lightTheme.colors.accent)
        XCTAssertNotNil(lightTheme.colors.background)
        XCTAssertNotNil(lightTheme.colors.surface)
        XCTAssertNotNil(lightTheme.colors.text)
        XCTAssertNotNil(lightTheme.colors.textSecondary)
        
        XCTAssertNotNil(lightTheme.typography.h1)
        XCTAssertNotNil(lightTheme.typography.h2)
        XCTAssertNotNil(lightTheme.typography.h3)
        XCTAssertNotNil(lightTheme.typography.body)
        XCTAssertNotNil(lightTheme.typography.caption)
        XCTAssertNotNil(lightTheme.typography.button)
        
        XCTAssertEqual(lightTheme.spacing.xs, 4)
        XCTAssertEqual(lightTheme.spacing.sm, 8)
        XCTAssertEqual(lightTheme.spacing.md, 16)
        XCTAssertEqual(lightTheme.spacing.lg, 24)
        XCTAssertEqual(lightTheme.spacing.xl, 32)
    }
    
    func testDarkTheme() {
        let darkTheme = Theme.dark
        
        XCTAssertNotNil(darkTheme.colors.primary)
        XCTAssertNotNil(darkTheme.colors.secondary)
        XCTAssertNotNil(darkTheme.colors.accent)
        XCTAssertNotNil(darkTheme.colors.background)
        XCTAssertNotNil(darkTheme.colors.surface)
        XCTAssertNotNil(darkTheme.colors.text)
        XCTAssertNotNil(darkTheme.colors.textSecondary)
        
        XCTAssertNotNil(darkTheme.typography.h1)
        XCTAssertNotNil(darkTheme.typography.h2)
        XCTAssertNotNil(darkTheme.typography.h3)
        XCTAssertNotNil(darkTheme.typography.body)
        XCTAssertNotNil(darkTheme.typography.caption)
        XCTAssertNotNil(darkTheme.typography.button)
        
        XCTAssertEqual(darkTheme.spacing.xs, 4)
        XCTAssertEqual(darkTheme.spacing.sm, 8)
        XCTAssertEqual(darkTheme.spacing.md, 16)
        XCTAssertEqual(darkTheme.spacing.lg, 24)
        XCTAssertEqual(darkTheme.spacing.xl, 32)
    }
    
    // MARK: - Shadow Tests
    func testShadowInitialization() {
        let shadow = Shadow(
            color: .black.opacity(0.1),
            radius: 4,
            x: 0,
            y: 2
        )
        
        XCTAssertEqual(shadow.radius, 4)
        XCTAssertEqual(shadow.x, 0)
        XCTAssertEqual(shadow.y, 2)
        XCTAssertNotNil(shadow.color)
    }
    
    // MARK: - Component Tests
    func testPrimaryButton() {
        let button = PrimaryButton(
            title: "Test Button",
            isEnabled: true,
            isLoading: false
        ) {
            // Test action
        }
        
        XCTAssertEqual(button.title, "Test Button")
        XCTAssertTrue(button.isEnabled)
        XCTAssertFalse(button.isLoading)
    }
    
    func testSecondaryButton() {
        let button = SecondaryButton(
            title: "Test Button",
            isEnabled: true
        ) {
            // Test action
        }
        
        XCTAssertEqual(button.title, "Test Button")
        XCTAssertTrue(button.isEnabled)
    }
    
    func testIconButton() {
        let button = IconButton(
            icon: "star.fill",
            title: "Favorite",
            isEnabled: true
        ) {
            // Test action
        }
        
        XCTAssertEqual(button.icon, "star.fill")
        XCTAssertEqual(button.title, "Favorite")
        XCTAssertTrue(button.isEnabled)
    }
    
    func testFloatingActionButton() {
        let button = FloatingActionButton(
            icon: "plus",
            backgroundColor: .blue
        ) {
            // Test action
        }
        
        XCTAssertEqual(button.icon, "plus")
        XCTAssertEqual(button.backgroundColor, .blue)
    }
    
    func testToggleButton() {
        @State var isOn = false
        let button = ToggleButton(
            isOn: $isOn,
            title: "Notifications",
            icon: "bell"
        )
        
        XCTAssertEqual(button.title, "Notifications")
        XCTAssertEqual(button.icon, "bell")
    }
    
    func testGradientButton() {
        let gradient = LinearGradient(
            colors: [.blue, .purple],
            startPoint: .leading,
            endPoint: .trailing
        )
        
        let button = GradientButton(
            title: "Gradient Button",
            gradient: gradient,
            isEnabled: true
        ) {
            // Test action
        }
        
        XCTAssertEqual(button.title, "Gradient Button")
        XCTAssertTrue(button.isEnabled)
    }
    
    func testSocialButton() {
        let button = SocialButton(
            title: "Sign in with Apple",
            icon: "applelogo",
            backgroundColor: .black
        ) {
            // Test action
        }
        
        XCTAssertEqual(button.title, "Sign in with Apple")
        XCTAssertEqual(button.icon, "applelogo")
        XCTAssertEqual(button.backgroundColor, .black)
    }
    
    // MARK: - Card Tests
    func testCard() {
        let card = Card {
            Text("Card Content")
        }
        
        XCTAssertNotNil(card)
    }
    
    func testProfileCard() {
        let card = ProfileCard(
            avatar: "person.circle.fill",
            name: "John Doe",
            subtitle: "Software Engineer"
        ) {
            // Test action
        }
        
        XCTAssertEqual(card.avatar, "person.circle.fill")
        XCTAssertEqual(card.name, "John Doe")
        XCTAssertEqual(card.subtitle, "Software Engineer")
    }
    
    func testInfoCard() {
        let card = InfoCard(
            icon: "info.circle",
            title: "Information",
            description: "This is an informational card"
        ) {
            // Test action
        }
        
        XCTAssertEqual(card.icon, "info.circle")
        XCTAssertEqual(card.title, "Information")
        XCTAssertEqual(card.description, "This is an informational card")
    }
    
    func testProductCard() {
        let card = ProductCard(
            imageURL: "https://example.com/image.jpg",
            title: "Product Name",
            price: "$99.99",
            originalPrice: "$129.99",
            rating: 4.5
        ) {
            // Test action
        }
        
        XCTAssertEqual(card.imageURL, "https://example.com/image.jpg")
        XCTAssertEqual(card.title, "Product Name")
        XCTAssertEqual(card.price, "$99.99")
        XCTAssertEqual(card.originalPrice, "$129.99")
        XCTAssertEqual(card.rating, 4.5)
    }
    
    // MARK: - Input Tests
    func testCustomTextField() {
        @State var text = ""
        let textField = CustomTextField(
            text: $text,
            placeholder: "Enter text",
            icon: "pencil",
            validation: .none,
            isSecure: false
        )
        
        XCTAssertEqual(textField.placeholder, "Enter text")
        XCTAssertEqual(textField.icon, "pencil")
        XCTAssertEqual(textField.validation, .none)
        XCTAssertFalse(textField.isSecure)
    }
    
    func testCustomToggle() {
        @State var isOn = false
        let toggle = CustomToggle(
            isOn: $isOn,
            title: "Enable Notifications",
            subtitle: "Receive push notifications",
            icon: "bell"
        )
        
        XCTAssertEqual(toggle.title, "Enable Notifications")
        XCTAssertEqual(toggle.subtitle, "Receive push notifications")
        XCTAssertEqual(toggle.icon, "bell")
    }
    
    func testCustomSlider() {
        @State var value = 50.0
        let slider = CustomSlider(
            value: $value,
            range: 0...100,
            step: 1,
            title: "Brightness"
        )
        
        XCTAssertEqual(slider.range, 0...100)
        XCTAssertEqual(slider.step, 1)
        XCTAssertEqual(slider.title, "Brightness")
    }
    
    func testSearchBar() {
        @State var text = ""
        let searchBar = SearchBar(
            text: $text,
            placeholder: "Search...",
            onSearch: {
                // Test search action
            }
        )
        
        XCTAssertEqual(searchBar.placeholder, "Search...")
    }
    
    // MARK: - Navigation Tests
    func testCustomNavigationBar() {
        let navigationBar = CustomNavigationBar(
            title: "Profile",
            leftButton: NavigationButton(
                icon: "chevron.left"
            ) {
                // Test back action
            },
            rightButton: NavigationButton(
                icon: "ellipsis"
            ) {
                // Test menu action
            }
        )
        
        XCTAssertEqual(navigationBar.title, "Profile")
        XCTAssertNotNil(navigationBar.leftButton)
        XCTAssertNotNil(navigationBar.rightButton)
    }
    
    func testCustomTabBar() {
        @State var selectedTab = 0
        let tabs = [
            TabItem(icon: "house", title: "Home"),
            TabItem(icon: "heart", title: "Favorites", badge: "3"),
            TabItem(icon: "person", title: "Profile")
        ]
        
        let tabBar = CustomTabBar(
            selectedTab: $selectedTab,
            tabs: tabs
        )
        
        XCTAssertEqual(tabBar.tabs.count, 3)
        XCTAssertEqual(tabBar.tabs[0].icon, "house")
        XCTAssertEqual(tabBar.tabs[0].title, "Home")
        XCTAssertEqual(tabBar.tabs[1].badge, "3")
    }
    
    func testBreadcrumbNavigation() {
        let items = [
            BreadcrumbItem(title: "Home", id: "home"),
            BreadcrumbItem(title: "Products", id: "products"),
            BreadcrumbItem(title: "Details", id: "details")
        ]
        
        let breadcrumb = BreadcrumbNavigation(
            items: items
        ) { item in
            // Test item tap
        }
        
        XCTAssertEqual(breadcrumb.items.count, 3)
        XCTAssertEqual(breadcrumb.items[0].title, "Home")
        XCTAssertEqual(breadcrumb.items[0].id, "home")
    }
    
    func testStepIndicator() {
        let stepIndicator = StepIndicator(
            currentStep: 2,
            totalSteps: 4,
            stepTitles: ["Step 1", "Step 2", "Step 3", "Step 4"]
        )
        
        XCTAssertEqual(stepIndicator.currentStep, 2)
        XCTAssertEqual(stepIndicator.totalSteps, 4)
        XCTAssertEqual(stepIndicator.stepTitles.count, 4)
    }
    
    // MARK: - List Tests
    func testCustomList() {
        let list = CustomList {
            Text("List Item 1")
            Text("List Item 2")
            Text("List Item 3")
        }
        
        XCTAssertNotNil(list)
    }
    
    func testUserRowView() {
        let user = User(
            id: "1",
            name: "John Doe",
            email: "john@example.com",
            avatarURL: URL(string: "https://example.com/avatar.jpg")
        )
        
        let userRow = UserRowView(
            user: user,
            showAvatar: true,
            showSubtitle: true
        ) {
            // Test action
        }
        
        XCTAssertEqual(userRow.user.id, "1")
        XCTAssertEqual(userRow.user.name, "John Doe")
        XCTAssertEqual(userRow.user.email, "john@example.com")
        XCTAssertTrue(userRow.showAvatar)
        XCTAssertTrue(userRow.showSubtitle)
    }
    
    func testSettingsRowView() {
        let settingsRow = SettingsRowView(
            icon: "bell",
            title: "Notifications",
            subtitle: "Manage notification settings",
            accessory: .chevron
        ) {
            // Test action
        }
        
        XCTAssertEqual(settingsRow.icon, "bell")
        XCTAssertEqual(settingsRow.title, "Notifications")
        XCTAssertEqual(settingsRow.subtitle, "Manage notification settings")
        XCTAssertEqual(settingsRow.accessory, .chevron)
    }
    
    func testProductRowView() {
        let product = Product(
            id: "1",
            name: "Product Name",
            description: "Product description",
            price: "$99.99",
            originalPrice: "$129.99",
            imageURL: URL(string: "https://example.com/image.jpg"),
            rating: 4.5
        )
        
        let productRow = ProductRowView(
            product: product,
            showImage: true,
            showPrice: true
        ) {
            // Test action
        }
        
        XCTAssertEqual(productRow.product.id, "1")
        XCTAssertEqual(productRow.product.name, "Product Name")
        XCTAssertEqual(productRow.product.price, "$99.99")
        XCTAssertTrue(productRow.showImage)
        XCTAssertTrue(productRow.showPrice)
    }
    
    // MARK: - Modal Tests
    func testCustomAlert() {
        @State var isPresented = false
        let alert = CustomAlert(
            title: "Delete Item",
            message: "Are you sure you want to delete this item?",
            primaryButton: AlertButton(
                title: "Delete",
                style: .destructive
            ) {
                // Test delete action
            },
            secondaryButton: AlertButton(
                title: "Cancel",
                style: .cancel
            ) {
                // Test cancel action
            },
            isPresented: $isPresented
        )
        
        XCTAssertEqual(alert.title, "Delete Item")
        XCTAssertEqual(alert.message, "Are you sure you want to delete this item?")
        XCTAssertNotNil(alert.primaryButton)
        XCTAssertNotNil(alert.secondaryButton)
    }
    
    func testCustomSheet() {
        @State var isPresented = false
        let sheet = CustomSheet(
            isPresented: $isPresented,
            style: .large
        ) {
            Text("Sheet Content")
        }
        
        XCTAssertNotNil(sheet)
    }
    
    func testCustomActionSheet() {
        @State var isPresented = false
        let actionSheet = CustomActionSheet(
            title: "Choose Option",
            message: "Select an action to perform",
            buttons: [
                ActionButton(title: "Edit") {
                    // Test edit action
                },
                ActionButton(title: "Delete", style: .destructive) {
                    // Test delete action
                }
            ],
            isPresented: $isPresented
        )
        
        XCTAssertEqual(actionSheet.title, "Choose Option")
        XCTAssertEqual(actionSheet.message, "Select an action to perform")
        XCTAssertEqual(actionSheet.buttons.count, 2)
    }
    
    func testCustomModal() {
        @State var isPresented = false
        let modal = CustomModal(
            isPresented: $isPresented,
            style: .default
        ) {
            Text("Modal Content")
        }
        
        XCTAssertNotNil(modal)
    }
} 