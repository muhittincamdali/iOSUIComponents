//
//  AdvancedExample.swift
//  iOSUIComponents
//
//  Advanced usage examples for iOS UI Components
//  Demonstrates complex component interactions and advanced features
//

import SwiftUI
import iOSUIComponents

struct AdvancedExample: View {
    @State private var isLoading = false
    @State private var selectedTheme = "default"
    @State private var formData = FormData()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Advanced Button Examples
                    advancedButtonExamples
                    
                    // Advanced Card Examples
                    advancedCardExamples
                    
                    // Advanced Form Examples
                    advancedFormExamples
                    
                    // Advanced Animation Examples
                    advancedAnimationExamples
                    
                    // Advanced Theming Examples
                    advancedThemingExamples
                }
                .padding()
            }
            .navigationTitle("Advanced Examples")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // MARK: - Advanced Button Examples
    
    private var advancedButtonExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Advanced Buttons")
                .font(.title2)
                .fontWeight(.bold)
            
            // Gradient Button
            CustomButton(
                title: "Gradient Button",
                style: .gradient,
                size: .large
            ) {
                print("Gradient button tapped")
            }
            
            // Loading Button
            CustomButton(
                title: "Loading Button",
                style: .primary,
                size: .medium
            ) {
                isLoading.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isLoading = false
                }
            }
            .isLoading(isLoading)
            
            // Icon Button with Badge
            CustomButton(
                title: "Notifications",
                icon: "bell.fill",
                style: .secondary,
                size: .medium
            ) {
                print("Notification button tapped")
            }
            .badge("3")
            
            // Custom Animation Button
            CustomButton(
                title: "Animated Button",
                style: .primary,
                size: .large
            ) {
                withAnimation(.spring()) {
                    // Custom animation logic
                }
            }
            .animation(.spring())
        }
    }
    
    // MARK: - Advanced Card Examples
    
    private var advancedCardExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Advanced Cards")
                .font(.title2)
                .fontWeight(.bold)
            
            // Interactive Product Card
            CustomCard(
                title: "iPhone 15 Pro",
                subtitle: "$999",
                content: "Latest Apple smartphone with advanced features and professional camera system.",
                image: "iphone_image",
                style: .product,
                layout: .vertical
            ) {
                print("Product card tapped")
            }
            .onLongPressGesture {
                print("Product card long pressed")
            }
            
            // Expandable Info Card
            CustomCard(
                title: "Expandable Info",
                content: "This card can be expanded to show more information.",
                style: .info,
                layout: .vertical
            ) {
                print("Info card tapped")
            }
            .isExpandable(true)
            
            // Custom Styled Card
            CustomCard(
                title: "Custom Styled",
                content: "This card uses custom styling and animations.",
                style: .custom,
                layout: .horizontal
            ) {
                print("Custom card tapped")
            }
            .customStyle(CardCustomStyle(
                backgroundColor: .systemPurple,
                textColor: .white,
                cornerRadius: 20,
                shadowEnabled: true
            ))
        }
    }
    
    // MARK: - Advanced Form Examples
    
    private var advancedFormExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Advanced Forms")
                .font(.title2)
                .fontWeight(.bold)
            
            // Multi-step Form
            CustomForm(
                fields: [
                    FormField(id: "name", type: .text, label: "Full Name", isRequired: true),
                    FormField(id: "email", type: .email, label: "Email Address", isRequired: true),
                    FormField(id: "phone", type: .phone, label: "Phone Number", isRequired: false),
                    FormField(id: "password", type: .password, label: "Password", isRequired: true),
                    FormField(id: "confirmPassword", type: .password, label: "Confirm Password", isRequired: true)
                ]
            ) { formData in
                print("Form submitted: \(formData)")
                validateForm(formData)
            }
            .onValidation { isValid in
                print("Form validation: \(isValid)")
            }
            
            // Dynamic Form
            CustomForm(
                fields: generateDynamicFields()
            ) { formData in
                print("Dynamic form submitted: \(formData)")
            }
        }
    }
    
    // MARK: - Advanced Animation Examples
    
    private var advancedAnimationExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Advanced Animations")
                .font(.title2)
                .fontWeight(.bold)
            
            // Spring Animation Button
            CustomButton(
                title: "Spring Animation",
                style: .primary,
                size: .medium
            ) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    // Spring animation logic
                }
            }
            
            // Staggered Animation Cards
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                ForEach(0..<4, id: \.self) { index in
                    CustomCard(
                        title: "Card \(index + 1)",
                        content: "Staggered animation card",
                        style: .default
                    ) {
                        print("Card \(index + 1) tapped")
                    }
                    .animation(.easeInOut(duration: 0.3).delay(Double(index) * 0.1))
                }
            }
        }
    }
    
    // MARK: - Advanced Theming Examples
    
    private var advancedThemingExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Advanced Theming")
                .font(.title2)
                .fontWeight(.bold)
            
            // Theme Selector
            Picker("Theme", selection: $selectedTheme) {
                Text("Default").tag("default")
                Text("Dark").tag("dark")
                Text("Custom").tag("custom")
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedTheme) { newTheme in
                applyTheme(newTheme)
            }
            
            // Custom Theme Preview
            CustomCard(
                title: "Theme Preview",
                content: "This card shows the current theme applied.",
                style: .default
            ) {
                print("Theme preview card tapped")
            }
            .theme(selectedTheme)
        }
    }
    
    // MARK: - Helper Methods
    
    private func generateDynamicFields() -> [FormField] {
        return [
            FormField(id: "dynamic1", type: .text, label: "Dynamic Field 1", isRequired: true),
            FormField(id: "dynamic2", type: .email, label: "Dynamic Field 2", isRequired: false),
            FormField(id: "dynamic3", type: .password, label: "Dynamic Field 3", isRequired: true)
        ]
    }
    
    private func validateForm(_ data: [String: Any]) {
        // Advanced form validation logic
        print("Validating form data: \(data)")
    }
    
    private func applyTheme(_ theme: String) {
        // Advanced theme application logic
        print("Applying theme: \(theme)")
    }
}

// MARK: - Form Data Model

struct FormData {
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}

// MARK: - Preview

struct AdvancedExample_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedExample()
    }
} 