import SwiftUI
import iOSUIComponents

// MARK: - Basic Example App
@main
struct BasicExampleApp: App {
    
    init() {
        setupUIComponents()
        setupAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    // MARK: - Setup Methods
    private func setupUIComponents() {
        // Initialize UI components
        iOSUIComponents.initialize()
    }
    
    private func setupAppearance() {
        // Configure navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}

// MARK: - Content View
struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ButtonDemoView()
                .tabItem {
                    Image(systemName: "button.programmable")
                    Text("Buttons")
                }
                .tag(0)
            
            CardDemoView()
                .tabItem {
                    Image(systemName: "rectangle.on.rectangle")
                    Text("Cards")
                }
                .tag(1)
            
            InputDemoView()
                .tabItem {
                    Image(systemName: "textformat")
                    Text("Inputs")
                }
                .tag(2)
            
            NavigationDemoView()
                .tabItem {
                    Image(systemName: "navigation")
                    Text("Navigation")
                }
                .tag(3)
            
            ListDemoView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Lists")
                }
                .tag(4)
            
            ModalDemoView()
                .tabItem {
                    Image(systemName: "rectangle.3.group")
                    Text("Modals")
                }
                .tag(5)
        }
        .accentColor(.primary)
    }
}

// MARK: - Button Demo View
struct ButtonDemoView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Primary Buttons
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Primary Buttons")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        PrimaryButton(title: "Primary Action") {
                            showAlert("Primary button tapped!")
                        }
                        
                        PrimaryButton(
                            title: "With Icon",
                            icon: "star.fill"
                        ) {
                            showAlert("Primary button with icon tapped!")
                        }
                        
                        PrimaryButton(
                            title: "Loading State",
                            isLoading: true
                        ) {
                            // Loading state
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Secondary Buttons
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Secondary Buttons")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        SecondaryButton(title: "Secondary Action") {
                            showAlert("Secondary button tapped!")
                        }
                        
                        SecondaryButton(
                            title: "With Icon",
                            icon: "heart.fill"
                        ) {
                            showAlert("Secondary button with icon tapped!")
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Icon Buttons
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Icon Buttons")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 16) {
                            IconButton(icon: "heart.fill") {
                                showAlert("Heart button tapped!")
                            }
                            
                            IconButton(icon: "star.fill") {
                                showAlert("Star button tapped!")
                            }
                            
                            IconButton(icon: "bookmark.fill") {
                                showAlert("Bookmark button tapped!")
                            }
                            
                            IconButton(icon: "share") {
                                showAlert("Share button tapped!")
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Floating Action Button
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Floating Action Button")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        FloatingActionButton(icon: "plus") {
                            showAlert("FAB tapped!")
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Toggle Button
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Toggle Button")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        ToggleButton(
                            title: "Toggle State",
                            isOn: .constant(true)
                        ) {
                            showAlert("Toggle button tapped!")
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Gradient Button
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Gradient Button")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        GradientButton(
                            title: "Gradient Action",
                            colors: [.blue, .purple]
                        ) {
                            showAlert("Gradient button tapped!")
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Social Buttons
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Social Buttons")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            SocialButton(
                                title: "Continue with Apple",
                                icon: "applelogo",
                                style: .apple
                            ) {
                                showAlert("Apple button tapped!")
                            }
                            
                            SocialButton(
                                title: "Continue with Google",
                                icon: "globe",
                                style: .google
                            ) {
                                showAlert("Google button tapped!")
                            }
                            
                            SocialButton(
                                title: "Continue with Facebook",
                                icon: "person.2.fill",
                                style: .facebook
                            ) {
                                showAlert("Facebook button tapped!")
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding()
            }
            .navigationTitle("Button Components")
            .alert("Button Action", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func showAlert(_ message: String) {
        alertMessage = message
        showAlert = true
    }
}

// MARK: - Card Demo View
struct CardDemoView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Generic Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Generic Card")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Card {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Card Title")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                Text("This is a generic card that can contain any content. It provides a consistent container with shadow and rounded corners.")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Profile Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Profile Card")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        ProfileCard(
                            name: "John Doe",
                            email: "john.doe@example.com",
                            avatar: "person.circle.fill",
                            bio: "iOS Developer with 5+ years of experience in Swift and SwiftUI."
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Info Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Info Card")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        InfoCard(
                            title: "Project Statistics",
                            subtitle: "Last 30 days",
                            icon: "chart.bar.fill",
                            value: "1,234",
                            unit: "views"
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Product Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Product Card")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        ProductCard(
                            name: "iPhone 15 Pro",
                            description: "The most advanced iPhone ever with A17 Pro chip",
                            price: "$999",
                            image: "iphone",
                            rating: 4.8,
                            reviewCount: 1250
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Post Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Post Card")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        PostCard(
                            author: "Jane Smith",
                            content: "Just finished building an amazing iOS app with SwiftUI! The new features are incredible and the performance is outstanding.",
                            timestamp: Date().addingTimeInterval(-3600),
                            likes: 42,
                            comments: 8,
                            shares: 3
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding()
            }
            .navigationTitle("Card Components")
        }
    }
}

// MARK: - Input Demo View
struct InputDemoView: View {
    @State private var textInput = ""
    @State private var emailInput = ""
    @State private var passwordInput = ""
    @State private var searchInput = ""
    @State private var toggleValue = false
    @State private var sliderValue: Double = 50
    @State private var selectedOption = "Option 1"
    
    let options = ["Option 1", "Option 2", "Option 3", "Option 4"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Text Fields
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Text Fields")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        CustomTextField(
                            text: $textInput,
                            placeholder: "Enter your name",
                            icon: "person.fill"
                        )
                        
                        CustomTextField(
                            text: $emailInput,
                            placeholder: "Enter your email",
                            icon: "envelope.fill",
                            validation: .email
                        )
                        
                        CustomTextField(
                            text: $passwordInput,
                            placeholder: "Enter your password",
                            icon: "lock.fill",
                            validation: .password,
                            isSecure: true
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Search Bar
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Search Bar")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        SearchBar(text: $searchInput, placeholder: "Search for anything...")
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Toggle
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Toggle")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        CustomToggle(
                            isOn: $toggleValue,
                            title: "Enable Notifications",
                            subtitle: "Receive push notifications for important updates"
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Slider
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Slider")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        CustomSlider(
                            value: $sliderValue,
                            range: 0...100,
                            title: "Volume",
                            subtitle: "Adjust the volume level"
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Picker
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Picker")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        CustomPicker(
                            selection: $selectedOption,
                            options: options,
                            title: "Select Option",
                            subtitle: "Choose from available options"
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding()
            }
            .navigationTitle("Input Components")
        }
    }
}

// MARK: - Navigation Demo View
struct NavigationDemoView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Custom Navigation Bar
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom Navigation Bar")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        CustomNavigationBar(
                            title: "Demo App",
                            leftButton: NavigationButton(
                                icon: "chevron.left",
                                action: { }
                            ),
                            rightButton: NavigationButton(
                                icon: "gear",
                                action: { }
                            )
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Custom Tab Bar
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom Tab Bar")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        CustomTabBar(
                            selection: $selectedTab,
                            items: [
                                TabItem(icon: "house", title: "Home", badge: nil),
                                TabItem(icon: "heart", title: "Favorites", badge: "3"),
                                TabItem(icon: "person", title: "Profile", badge: nil),
                                TabItem(icon: "gear", title: "Settings", badge: "1")
                            ]
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Breadcrumb Navigation
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Breadcrumb Navigation")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        BreadcrumbNavigation(
                            items: [
                                BreadcrumbItem(title: "Home", action: { }),
                                BreadcrumbItem(title: "Products", action: { }),
                                BreadcrumbItem(title: "Electronics", action: { }),
                                BreadcrumbItem(title: "Smartphones", action: { })
                            ]
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Step Indicator
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Step Indicator")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        StepIndicator(
                            currentStep: 2,
                            totalSteps: 4,
                            steps: [
                                "Account",
                                "Profile",
                                "Preferences",
                                "Complete"
                            ]
                        )
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding()
            }
            .navigationTitle("Navigation Components")
        }
    }
}

// MARK: - List Demo View
struct ListDemoView: View {
    let users = [
        User(id: "1", name: "John Doe", email: "john@example.com", avatar: "person.circle.fill"),
        User(id: "2", name: "Jane Smith", email: "jane@example.com", avatar: "person.circle.fill"),
        User(id: "3", name: "Bob Johnson", email: "bob@example.com", avatar: "person.circle.fill")
    ]
    
    let products = [
        Product(id: "1", name: "iPhone 15 Pro", price: "$999", image: "iphone"),
        Product(id: "2", name: "MacBook Pro", price: "$1999", image: "laptopcomputer"),
        Product(id: "3", name: "iPad Pro", price: "$799", image: "ipad")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Custom List
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom List")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        CustomList {
                            ForEach(users) { user in
                                UserRowView(user: user)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // User Row Views
                    VStack(alignment: .leading, spacing: 12) {
                        Text("User Row Views")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 0) {
                            ForEach(users) { user in
                                UserRowView(user: user)
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .padding()
                    
                    // Settings Row Views
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Settings Row Views")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 0) {
                            SettingsRowView(
                                icon: "bell",
                                title: "Notifications",
                                subtitle: "Manage your notifications",
                                accessory: .switch
                            ) {
                                // Handle notifications
                            }
                            
                            SettingsRowView(
                                icon: "lock",
                                title: "Privacy",
                                subtitle: "Control your privacy settings",
                                accessory: .chevron
                            ) {
                                // Handle privacy
                            }
                            
                            SettingsRowView(
                                icon: "gear",
                                title: "Settings",
                                subtitle: "App configuration",
                                accessory: .chevron
                            ) {
                                // Handle settings
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .padding()
                    
                    // Product Row Views
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Product Row Views")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 0) {
                            ForEach(products) { product in
                                ProductRowView(product: product)
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("List Components")
        }
    }
}

// MARK: - Modal Demo View
struct ModalDemoView: View {
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var showActionSheet = false
    @State private var showModal = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Custom Alert
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom Alert")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        PrimaryButton(title: "Show Alert") {
                            showAlert = true
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Custom Sheet
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom Sheet")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        PrimaryButton(title: "Show Sheet") {
                            showSheet = true
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Custom Action Sheet
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom Action Sheet")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        PrimaryButton(title: "Show Action Sheet") {
                            showActionSheet = true
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Custom Modal
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom Modal")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        PrimaryButton(title: "Show Modal") {
                            showModal = true
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding()
            }
            .navigationTitle("Modal Components")
            .customAlert(
                isPresented: $showAlert,
                title: "Sample Alert",
                message: "This is a custom alert with primary and secondary actions.",
                primaryButton: AlertButton(title: "OK", style: .primary) {
                    showAlert = false
                },
                secondaryButton: AlertButton(title: "Cancel", style: .secondary) {
                    showAlert = false
                }
            )
            .customSheet(isPresented: $showSheet) {
                VStack(spacing: 20) {
                    Text("Custom Sheet")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("This is a custom bottom sheet with your content.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    
                    PrimaryButton(title: "Dismiss") {
                        showSheet = false
                    }
                }
                .padding()
            }
            .customActionSheet(isPresented: $showActionSheet) {
                CustomActionSheet(
                    title: "Choose Action",
                    message: "Select an action to perform",
                    actions: [
                        ActionButton(title: "Take Photo", icon: "camera", style: .default) {
                            showActionSheet = false
                        },
                        ActionButton(title: "Choose from Library", icon: "photo", style: .default) {
                            showActionSheet = false
                        },
                        ActionButton(title: "Cancel", icon: "xmark", style: .cancel) {
                            showActionSheet = false
                        }
                    ]
                )
            }
            .customModal(isPresented: $showModal) {
                VStack(spacing: 20) {
                    Text("Custom Modal")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("This is a custom modal with full screen presentation.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 16) {
                        SecondaryButton(title: "Cancel") {
                            showModal = false
                        }
                        
                        PrimaryButton(title: "Confirm") {
                            showModal = false
                        }
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Mock Models
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