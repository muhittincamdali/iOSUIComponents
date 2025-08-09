//
//  IntegrationExample.swift
//  iOSUIComponents
//
//  Integration examples for iOS UI Components
//  Demonstrates how to integrate components with other frameworks and APIs
//

import SwiftUI
import iOSUIComponents
import Combine

struct IntegrationExample: View {
    @StateObject private var viewModel = IntegrationViewModel()
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // API Integration Examples
                    apiIntegrationExamples
                    
                    // Database Integration Examples
                    databaseIntegrationExamples
                    
                    // Network Integration Examples
                    networkIntegrationExamples
                    
                    // Third-party Framework Integration
                    thirdPartyIntegrationExamples
                    
                    // State Management Integration
                    stateManagementExamples
                }
                .padding()
            }
            .navigationTitle("Integration Examples")
            .navigationBarTitleDisplayMode(.large)
            .alert("Integration Result", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // MARK: - API Integration Examples
    
    private var apiIntegrationExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("API Integration")
                .font(.title2)
                .fontWeight(.bold)
            
            // User Profile Card with API Data
            if let user = viewModel.currentUser {
                CustomCard(
                    title: user.name,
                    subtitle: user.email,
                    content: "User ID: \(user.id)\nRole: \(user.role)",
                    image: user.avatarURL,
                    style: .profile,
                    layout: .horizontal
                ) {
                    viewModel.loadUserDetails(user.id)
                }
            }
            
            // Loading State
            if viewModel.isLoading {
                CustomCard(
                    title: "Loading...",
                    content: "Fetching user data from API",
                    style: .loading,
                    layout: .vertical
                ) {
                    // Loading card action
                }
            }
            
            // Error State
            if let error = viewModel.error {
                CustomCard(
                    title: "Error",
                    content: error.localizedDescription,
                    style: .error,
                    layout: .vertical
                ) {
                    viewModel.retry()
                }
            }
            
            // Refresh Button
            CustomButton(
                title: "Refresh Data",
                style: .primary,
                size: .medium
            ) {
                viewModel.refreshData()
            }
            .isLoading(viewModel.isLoading)
        }
    }
    
    // MARK: - Database Integration Examples
    
    private var databaseIntegrationExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Database Integration")
                .font(.title2)
                .fontWeight(.bold)
            
            // User List from Database
            ForEach(viewModel.users, id: \.id) { user in
                CustomCard(
                    title: user.name,
                    subtitle: user.email,
                    content: "Last updated: \(user.lastUpdated)",
                    style: .default,
                    layout: .horizontal
                ) {
                    viewModel.selectUser(user)
                }
                .onLongPressGesture {
                    viewModel.deleteUser(user.id)
                }
            }
            
            // Add User Form
            CustomForm(
                fields: [
                    FormField(id: "name", type: .text, label: "Name", isRequired: true),
                    FormField(id: "email", type: .email, label: "Email", isRequired: true),
                    FormField(id: "role", type: .text, label: "Role", isRequired: false)
                ]
            ) { formData in
                viewModel.addUser(formData)
            }
        }
    }
    
    // MARK: - Network Integration Examples
    
    private var networkIntegrationExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Network Integration")
                .font(.title2)
                .fontWeight(.bold)
            
            // Network Status Card
            CustomCard(
                title: "Network Status",
                subtitle: viewModel.networkStatus,
                content: "Connection: \(viewModel.isConnected ? "Online" : "Offline")",
                style: viewModel.isConnected ? .success : .error,
                layout: .vertical
            ) {
                viewModel.checkNetworkStatus()
            }
            
            // Download Progress
            if viewModel.isDownloading {
                CustomCard(
                    title: "Downloading...",
                    subtitle: "\(Int(viewModel.downloadProgress * 100))%",
                    content: "File: \(viewModel.downloadingFileName)",
                    style: .info,
                    layout: .vertical
                ) {
                    viewModel.cancelDownload()
                }
            }
            
            // Upload Button
            CustomButton(
                title: "Upload File",
                style: .primary,
                size: .medium
            ) {
                viewModel.uploadFile()
            }
            .isLoading(viewModel.isUploading)
        }
    }
    
    // MARK: - Third-party Framework Integration
    
    private var thirdPartyIntegrationExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Third-party Integration")
                .font(.title2)
                .fontWeight(.bold)
            
            // Analytics Integration
            CustomButton(
                title: "Track Event",
                style: .secondary,
                size: .medium
            ) {
                viewModel.trackAnalyticsEvent("button_clicked")
            }
            
            // Payment Integration
            CustomButton(
                title: "Process Payment",
                style: .primary,
                size: .large
            ) {
                viewModel.processPayment()
            }
            .isLoading(viewModel.isProcessingPayment)
            
            // Social Media Integration
            CustomButton(
                title: "Share on Social",
                icon: "square.and.arrow.up",
                style: .secondary,
                size: .medium
            ) {
                viewModel.shareOnSocialMedia()
            }
        }
    }
    
    // MARK: - State Management Integration
    
    private var stateManagementExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("State Management")
                .font(.title2)
                .fontWeight(.bold)
            
            // App State Card
            CustomCard(
                title: "App State",
                subtitle: viewModel.appState.rawValue,
                content: "User: \(viewModel.currentUser?.name ?? "Not logged in")\nTheme: \(viewModel.currentTheme)",
                style: .info,
                layout: .vertical
            ) {
                viewModel.toggleAppState()
            }
            
            // Settings Form
            CustomForm(
                fields: [
                    FormField(id: "theme", type: .picker, label: "Theme", isRequired: false),
                    FormField(id: "notifications", type: .toggle, label: "Notifications", isRequired: false),
                    FormField(id: "autoSave", type: .toggle, label: "Auto Save", isRequired: false)
                ]
            ) { formData in
                viewModel.updateSettings(formData)
            }
        }
    }
}

// MARK: - Integration ViewModel

class IntegrationViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var networkStatus = "Checking..."
    @Published var isConnected = true
    @Published var isDownloading = false
    @Published var downloadProgress: Double = 0.0
    @Published var downloadingFileName = ""
    @Published var isUploading = false
    @Published var isProcessingPayment = false
    @Published var appState: AppState = .active
    @Published var currentTheme = "Light"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriptions()
        loadInitialData()
    }
    
    // MARK: - API Integration
    
    func loadUserDetails(_ userId: String) {
        isLoading = true
        error = nil
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentUser = User(
                id: userId,
                name: "John Doe",
                email: "john@example.com",
                role: "Developer",
                avatarURL: "https://example.com/avatar.jpg",
                lastUpdated: Date()
            )
            self.isLoading = false
        }
    }
    
    func refreshData() {
        loadInitialData()
    }
    
    func retry() {
        error = nil
        loadInitialData()
    }
    
    // MARK: - Database Integration
    
    func addUser(_ formData: [String: Any]) {
        guard let name = formData["name"] as? String,
              let email = formData["email"] as? String else {
            return
        }
        
        let newUser = User(
            id: UUID().uuidString,
            name: name,
            email: email,
            role: formData["role"] as? String ?? "User",
            avatarURL: nil,
            lastUpdated: Date()
        )
        
        users.append(newUser)
    }
    
    func selectUser(_ user: User) {
        currentUser = user
    }
    
    func deleteUser(_ userId: String) {
        users.removeAll { $0.id == userId }
    }
    
    // MARK: - Network Integration
    
    func checkNetworkStatus() {
        // Simulate network check
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isConnected = Bool.random()
            self.networkStatus = self.isConnected ? "Connected" : "Disconnected"
        }
    }
    
    func uploadFile() {
        isUploading = true
        
        // Simulate upload
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isUploading = false
        }
    }
    
    func cancelDownload() {
        isDownloading = false
        downloadProgress = 0.0
    }
    
    // MARK: - Third-party Integration
    
    func trackAnalyticsEvent(_ event: String) {
        // Simulate analytics tracking
        print("Analytics event tracked: \(event)")
    }
    
    func processPayment() {
        isProcessingPayment = true
        
        // Simulate payment processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isProcessingPayment = false
        }
    }
    
    func shareOnSocialMedia() {
        // Simulate social media sharing
        print("Sharing on social media")
    }
    
    // MARK: - State Management
    
    func toggleAppState() {
        appState = appState == .active ? .background : .active
    }
    
    func updateSettings(_ formData: [String: Any]) {
        if let theme = formData["theme"] as? String {
            currentTheme = theme
        }
    }
    
    // MARK: - Private Methods
    
    private func setupSubscriptions() {
        // Setup Combine subscriptions for reactive updates
    }
    
    private func loadInitialData() {
        isLoading = true
        
        // Simulate data loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.users = [
                User(id: "1", name: "Alice Johnson", email: "alice@example.com", role: "Admin", avatarURL: nil, lastUpdated: Date()),
                User(id: "2", name: "Bob Smith", email: "bob@example.com", role: "User", avatarURL: nil, lastUpdated: Date()),
                User(id: "3", name: "Carol Davis", email: "carol@example.com", role: "Manager", avatarURL: nil, lastUpdated: Date())
            ]
            self.isLoading = false
        }
    }
}

// MARK: - Models

struct User {
    let id: String
    let name: String
    let email: String
    let role: String
    let avatarURL: String?
    let lastUpdated: Date
}

enum AppState: String, CaseIterable {
    case active = "Active"
    case background = "Background"
    case inactive = "Inactive"
}

// MARK: - Preview

struct IntegrationExample_Previews: PreviewProvider {
    static var previews: some View {
        IntegrationExample()
    }
} 