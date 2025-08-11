import Foundation
import iOSUIComponents

/// Basic example demonstrating the core functionality of iOSUIComponents
@main
struct BasicExample {
    static func main() {
        print("🚀 iOSUIComponents Basic Example")
        
        // Initialize the framework
        let framework = iOSUIComponents()
        
        // Configure with default settings
        framework.configure()
        
        print("✅ Framework configured successfully")
        
        // Demonstrate basic functionality
        demonstrateBasicFeatures(framework)
    }
    
    static func demonstrateBasicFeatures(_ framework: iOSUIComponents) {
        print("\n📱 Demonstrating basic features...")
        
        // Add your example code here
        print("🎯 Feature 1: Core functionality")
        print("🎯 Feature 2: Configuration")
        print("🎯 Feature 3: Error handling")
        
        print("\n✨ Basic example completed successfully!")
    }
}
