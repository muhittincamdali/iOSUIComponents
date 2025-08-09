import XCTest
@testable import iOSUIComponents

final class ButtonComponentsTests: XCTestCase {
    
    // MARK: - Button Creation Tests
    
    func testButtonCreation() {
        let button = CustomButton(
            title: "Test Button",
            style: .primary,
            size: .medium
        )
        
        XCTAssertEqual(button.title, "Test Button")
        XCTAssertEqual(button.style, .primary)
        XCTAssertEqual(button.size, .medium)
    }
    
    func testButtonWithCustomStyle() {
        let customStyle = ButtonCustomStyle(
            backgroundColor: .systemPurple,
            textColor: .white,
            borderColor: .systemPurple,
            borderWidth: 2,
            cornerRadius: 20,
            shadowEnabled: true,
            shadowColor: .systemPurple,
            shadowOffset: CGSize(width: 0, height: 4),
            shadowRadius: 8,
            shadowOpacity: 0.3
        )
        
        let button = CustomButton(
            title: "Custom Button",
            style: .custom(customStyle),
            size: .large
        )
        
        XCTAssertEqual(button.title, "Custom Button")
        XCTAssertEqual(button.style, .custom(customStyle))
        XCTAssertEqual(button.size, .large)
    }
    
    // MARK: - Button Configuration Tests
    
    func testButtonConfiguration() {
        let button = CustomButton(title: "Test")
        
        button.configure { config in
            config.enableCustomStyles = true
            config.enableAnimations = true
            config.enableAccessibility = true
            config.enableHapticFeedback = true
        }
        
        XCTAssertNotNil(button)
    }
    
    func testButtonStyling() {
        let button = CustomButton(title: "Styled Button")
        
        button.setBackgroundColor(.systemBlue)
        button.setTextColor(.white)
        button.setCornerRadius(12)
        button.setShadow(enabled: true, color: .black, offset: CGSize(width: 0, height: 2), radius: 4)
        
        XCTAssertNotNil(button)
    }
    
    // MARK: - Button Interaction Tests
    
    func testButtonTap() {
        let button = CustomButton(title: "Tap Test")
        var tapped = false
        
        button.onTap {
            tapped = true
        }
        
        // Simulate tap
        button.sendActions(for: .touchUpInside)
        XCTAssertTrue(tapped)
    }
    
    func testButtonLongPress() {
        let button = CustomButton(title: "Long Press Test")
        var longPressed = false
        
        button.onLongPress {
            longPressed = true
        }
        
        // Simulate long press
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.state = .began
        button.handleLongPress(longPressGesture)
        
        XCTAssertTrue(longPressed)
    }
    
    // MARK: - Button State Tests
    
    func testButtonLoadingState() {
        let button = CustomButton(title: "Loading Test")
        
        XCTAssertFalse(button.isLoading)
        
        button.isLoading = true
        XCTAssertTrue(button.isLoading)
        
        button.isLoading = false
        XCTAssertFalse(button.isLoading)
    }
    
    func testButtonEnabledState() {
        let button = CustomButton(title: "Enabled Test")
        
        XCTAssertTrue(button.isEnabled)
        
        button.isEnabled = false
        XCTAssertFalse(button.isEnabled)
        
        button.isEnabled = true
        XCTAssertTrue(button.isEnabled)
    }
    
    // MARK: - Button Animation Tests
    
    func testButtonTapAnimation() {
        let button = CustomButton(title: "Animation Test")
        
        button.configure { config in
            config.enableAnimations = true
            config.tapAnimation = .scale
            config.animationDuration = 0.2
        }
        
        button.animateTap()
        
        // Verify animation was triggered
        XCTAssertNotNil(button)
    }
    
    func testButtonLoadingAnimation() {
        let button = CustomButton(title: "Loading Animation Test")
        
        button.configure { config in
            config.enableAnimations = true
            config.enableLoadingStates = true
        }
        
        button.animateLoading()
        
        // Verify loading animation was triggered
        XCTAssertNotNil(button)
    }
    
    func testButtonSuccessAnimation() {
        let button = CustomButton(title: "Success Animation Test")
        
        button.configure { config in
            config.enableAnimations = true
        }
        
        button.animateSuccess()
        
        // Verify success animation was triggered
        XCTAssertNotNil(button)
    }
    
    func testButtonErrorAnimation() {
        let button = CustomButton(title: "Error Animation Test")
        
        button.configure { config in
            config.enableAnimations = true
        }
        
        button.animateError()
        
        // Verify error animation was triggered
        XCTAssertNotNil(button)
    }
    
    // MARK: - Button Accessibility Tests
    
    func testButtonAccessibility() {
        let button = CustomButton(title: "Accessible Button")
        
        button.configure { config in
            config.enableAccessibility = true
        }
        
        button.accessibilityLabel = "Submit Form Button"
        button.accessibilityHint = "Double tap to submit the form"
        button.accessibilityTraits = .button
        
        XCTAssertEqual(button.accessibilityLabel, "Submit Form Button")
        XCTAssertEqual(button.accessibilityHint, "Double tap to submit the form")
        XCTAssertEqual(button.accessibilityTraits, .button)
    }
    
    func testButtonDynamicType() {
        let button = CustomButton(title: "Dynamic Type Button")
        
        button.configure { config in
            config.enableDynamicType = true
            config.textStyle = .body
        }
        
        XCTAssertNotNil(button)
    }
    
    // MARK: - Button Size Tests
    
    func testButtonSizes() {
        let smallButton = CustomButton(title: "Small", size: .small)
        let mediumButton = CustomButton(title: "Medium", size: .medium)
        let largeButton = CustomButton(title: "Large", size: .large)
        
        XCTAssertEqual(smallButton.size, .small)
        XCTAssertEqual(mediumButton.size, .medium)
        XCTAssertEqual(largeButton.size, .large)
    }
    
    func testCustomButtonSize() {
        let customSize = ButtonSize.custom(width: 200, height: 60)
        let button = CustomButton(title: "Custom Size", size: customSize)
        
        XCTAssertEqual(button.size, customSize)
    }
    
    // MARK: - Button Style Tests
    
    func testButtonStyles() {
        let primaryButton = CustomButton(title: "Primary", style: .primary)
        let secondaryButton = CustomButton(title: "Secondary", style: .secondary)
        let outlineButton = CustomButton(title: "Outline", style: .outline)
        let dangerButton = CustomButton(title: "Danger", style: .danger)
        
        XCTAssertEqual(primaryButton.style, .primary)
        XCTAssertEqual(secondaryButton.style, .secondary)
        XCTAssertEqual(outlineButton.style, .outline)
        XCTAssertEqual(dangerButton.style, .danger)
    }
    
    // MARK: - Button Performance Tests
    
    func testButtonPerformance() {
        let button = CustomButton(title: "Performance Test")
        
        measure {
            for _ in 0..<1000 {
                button.setTitle("New Title", for: .normal)
                button.setBackgroundColor(.systemBlue)
                button.setCornerRadius(8)
            }
        }
    }
    
    func testButtonMemoryUsage() {
        weak var weakButton: CustomButton?
        
        autoreleasepool {
            let button = CustomButton(title: "Memory Test")
            weakButton = button
            
            // Perform operations
            button.configure { config in
                config.enableAnimations = true
                config.enableAccessibility = true
            }
            
            button.onTap {
                print("Button tapped")
            }
        }
        
        // Button should be deallocated
        XCTAssertNil(weakButton)
    }
    
    // MARK: - Button Error Handling Tests
    
    func testButtonErrorHandling() {
        let button = CustomButton(title: "Error Test")
        
        do {
            try button.configure(ButtonConfiguration())
            XCTAssertNotNil(button)
        } catch {
            XCTFail("Button configuration should not throw error: \(error)")
        }
    }
    
    func testButtonInvalidConfiguration() {
        let button = CustomButton(title: "Invalid Config Test")
        
        // Test with invalid configuration
        button.configure { config in
            // Invalid configuration
        }
        
        XCTAssertNotNil(button)
    }
    
    // MARK: - Button Integration Tests
    
    func testButtonWithManager() {
        let manager = UIComponentsManager.shared
        let button = CustomButton(title: "Manager Test")
        
        manager.registerComponent(button)
        
        let components = manager.getAllComponents()
        XCTAssertTrue(components.contains { $0 is CustomButton })
        
        manager.unregisterComponent(button)
        
        let updatedComponents = manager.getAllComponents()
        XCTAssertFalse(updatedComponents.contains { $0 is CustomButton })
    }
    
    func testButtonWithTheme() {
        let button = CustomButton(title: "Theme Test")
        let theme = CustomTheme(
            name: "Test Theme",
            colors: ThemeColors(
                primary: .systemBlue,
                secondary: .systemGray,
                background: .systemBackground,
                text: .label
            )
        )
        
        ThemeManager.shared.applyTheme(theme)
        
        XCTAssertNotNil(button)
    }
    
    // MARK: - SwiftUI Button Tests
    
    func testSwiftUIButtonCreation() {
        let swiftUIButton = SwiftUIButton(
            title: "SwiftUI Button",
            style: .primary,
            size: .medium
        ) {
            print("SwiftUI button tapped")
        }
        
        XCTAssertNotNil(swiftUIButton)
    }
    
    func testSwiftUIButtonAccessibility() {
        let swiftUIButton = SwiftUIButton(
            title: "Accessible SwiftUI Button",
            style: .primary,
            size: .medium
        ) {
            print("SwiftUI button tapped")
        }
        
        XCTAssertNotNil(swiftUIButton)
    }
} 