# Contributing to iOS UI Components

Thank you for your interest in contributing to iOS UI Components! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Pull Request Process](#pull-request-process)
- [Release Process](#release-process)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

- Use the GitHub issue tracker
- Include detailed reproduction steps
- Provide system information (iOS version, device, etc.)
- Include screenshots if applicable
- Use the bug report template

### Suggesting Enhancements

- Use the GitHub issue tracker
- Describe the enhancement clearly
- Explain why this enhancement would be useful
- Include mockups or examples if applicable
- Use the enhancement request template

### Contributing Code

- Fork the repository
- Create a feature branch
- Make your changes
- Add tests for new functionality
- Update documentation
- Submit a pull request

### Improving Documentation

- Fix typos and grammar
- Add missing information
- Improve clarity and structure
- Add code examples
- Update outdated information

## Development Setup

### Prerequisites

- Xcode 15.0+
- iOS 15.0+ deployment target
- Swift 5.9+
- macOS 13.0+

### Getting Started

1. **Fork the repository**
   ```bash
   git clone https://github.com/your-username/iOSUIComponents.git
   cd iOSUIComponents
   ```

2. **Install dependencies**
   ```bash
   # Swift Package Manager (automatic)
   # No additional setup required
   ```

3. **Open in Xcode**
   ```bash
   open Package.swift
   ```

4. **Run tests**
   ```bash
   swift test
   ```

### Project Structure

```
iOSUIComponents/
├── Sources/
│   ├── ButtonComponents/
│   ├── CardComponents/
│   ├── InputComponents/
│   ├── NavigationComponents/
│   ├── ListComponents/
│   ├── ModalComponents/
│   └── iOSUIComponents/
├── Documentation/
│   ├── GettingStarted.md
│   ├── ComponentGuide.md
│   ├── DesignSystem.md
│   ├── ThemeGuide.md
│   ├── AccessibilityGuide.md
│   ├── API.md
│   └── Examples/
├── Examples/
│   ├── BasicExample/
│   ├── AdvancedExample/
│   └── CustomExample/
├── Tests/
│   ├── UnitTests/
│   ├── UITests/
│   └── AccessibilityTests/
└── Resources/
    ├── Assets/
    └── Localization/
```

## Coding Standards

### Swift Style Guide

We follow the [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/) and [Google Swift Style Guide](https://google.github.io/swift/).

### Key Principles

- **Clarity**: Code should be self-documenting
- **Consistency**: Follow established patterns
- **Simplicity**: Prefer simple solutions over complex ones
- **Accessibility**: Ensure accessibility compliance
- **Performance**: Consider performance implications

### Naming Conventions

```swift
// Types and protocols
struct PrimaryButton: View { }
protocol ButtonStyleProtocol { }

// Functions and methods
func configureButton() { }
func handleButtonTap() { }

// Variables and constants
let buttonHeight: CGFloat = 44
var isButtonEnabled: Bool = true

// Enums
enum ButtonStyle {
    case primary
    case secondary
    case outline
}
```

### Code Organization

```swift
// MARK: - Imports
import SwiftUI

// MARK: - Protocols
protocol ButtonStyleProtocol {
    func makeBody(configuration: Configuration) -> some View
}

// MARK: - Models
struct ButtonConfiguration {
    let title: String
    let icon: String?
    let style: ButtonStyle
}

// MARK: - Views
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

// MARK: - Extensions
extension PrimaryButton {
    func configureAppearance() {
        // Implementation
    }
}
```

### Documentation

```swift
/// A primary button component with customizable styling.
///
/// This button provides a consistent primary action style
/// with support for icons, loading states, and accessibility.
///
/// ## Usage
/// ```swift
/// PrimaryButton(title: "Save") {
///     // Handle button tap
/// }
/// ```
///
/// - Note: This button automatically handles accessibility.
/// - Warning: Do not use this button for destructive actions.
struct PrimaryButton: View {
    
    /// The text displayed on the button.
    let title: String
    
    /// The action performed when the button is tapped.
    let action: () -> Void
    
    var body: some View {
        // Implementation
    }
}
```

## Testing

### Test Structure

```
Tests/
├── UnitTests/
│   ├── ButtonComponents/
│   ├── CardComponents/
│   ├── InputComponents/
│   ├── NavigationComponents/
│   ├── ListComponents/
│   └── ModalComponents/
├── UITests/
│   ├── ComponentInteraction/
│   ├── ThemeTests/
│   └── AccessibilityTests/
└── PerformanceTests/
    ├── RenderingPerformance/
    └── AnimationPerformance/
```

### Writing Tests

```swift
import XCTest
@testable import ButtonComponents

final class PrimaryButtonTests: XCTestCase {
    
    func testPrimaryButtonInitialization() {
        // Given
        let title = "Test Button"
        
        // When
        let button = PrimaryButton(title: title) {
            // Action
        }
        
        // Then
        XCTAssertNotNil(button)
    }
    
    func testPrimaryButtonAccessibility() {
        // Given
        let title = "Accessible Button"
        
        // When
        let button = PrimaryButton(title: title) {
            // Action
        }
        
        // Then
        // Test accessibility properties
    }
    
    func testPrimaryButtonTheme() {
        // Given
        let title = "Themed Button"
        
        // When
        let button = PrimaryButton(title: title) {
            // Action
        }
        
        // Then
        // Test theme properties
    }
}
```

### Test Coverage

- Aim for at least 80% code coverage
- Test all public APIs
- Test accessibility features
- Test theme variations
- Test edge cases

## Documentation

### Documentation Standards

- Use clear, concise language
- Include code examples
- Provide step-by-step instructions
- Include screenshots when helpful
- Keep documentation up to date

### Documentation Structure

```
Documentation/
├── GettingStarted.md
├── ComponentGuide.md
├── DesignSystem.md
├── ThemeGuide.md
├── AccessibilityGuide.md
├── API.md
├── Examples/
│   ├── BasicExample.md
│   ├── AdvancedExample.md
│   └── CustomExample.md
└── Guides/
    ├── Deployment.md
    ├── Testing.md
    └── Troubleshooting.md
```

## Pull Request Process

### Before Submitting

1. **Ensure tests pass**
   ```bash
   swift test
   ```

2. **Check code style**
   ```bash
   swiftlint lint
   ```

3. **Update documentation**
   - Update README if needed
   - Add inline documentation
   - Update API documentation

4. **Test on different devices**
   - iPhone simulator
   - iPad simulator
   - Different iOS versions

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] UI tests pass
- [ ] Accessibility tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] No breaking changes
- [ ] Accessibility compliance

## Screenshots (if applicable)
Add screenshots here

## Additional Notes
Any additional information
```

### Review Process

1. **Automated checks**
   - CI/CD pipeline
   - Code coverage
   - Style checks

2. **Manual review**
   - Code quality
   - Design consistency
   - Accessibility compliance
   - Performance implications

3. **Testing**
   - Functionality testing
   - UI testing
   - Accessibility testing

## Release Process

### Versioning

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist

- [ ] All tests pass
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version number updated
- [ ] Release notes prepared
- [ ] Tag created
- [ ] Release published

### Creating a Release

1. **Update version**
   ```bash
   # Update version in Package.swift
   # Update CHANGELOG.md
   ```

2. **Create tag**
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

3. **Create GitHub release**
   - Go to GitHub releases
   - Create new release
   - Add release notes
   - Upload assets

## Getting Help

- **Issues**: Use GitHub issues
- **Discussions**: Use GitHub discussions
- **Documentation**: Check the docs folder
- **Examples**: Check the examples folder

## Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- GitHub contributors page

Thank you for contributing to iOS UI Components! 