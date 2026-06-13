import os

path = "/Users/muhittincamdali/Desktop/Claude Projects/GitHub/iOSUIComponents/Sources/iOSUIComponents/Core/iOSUIComponents.swift"

with open(path, 'r') as f: content = f.read()

# Mark primary types as @MainActor
content = content.replace('public struct iOSUIComponents {', '@MainActor\npublic struct iOSUIComponents {')
content = content.replace('public struct DesignSystem {', '@MainActor\npublic struct DesignSystem {')
content = content.replace('public extension Theme {', '@MainActor\npublic extension Theme {')

# Add Sendable to protocols/structs
content = content.replace('public protocol ColorPalette {', 'public protocol ColorPalette: Sendable {')
content = content.replace('public protocol TypographyPalette {', 'public protocol TypographyPalette: Sendable {')
content = content.replace('public struct Theme {', 'public struct Theme: Sendable {')

with open(path, 'w') as f: f.write(content)
print("Applied UI Concurrency fixes")
