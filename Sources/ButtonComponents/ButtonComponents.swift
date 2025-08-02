import SwiftUI

// MARK: - Button Components
public struct PrimaryButton: View {
    public let title: String
    public let action: () -> Void
    public let isEnabled: Bool
    public let isLoading: Bool
    
    public init(
        title: String,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        self.isEnabled = isEnabled
        self.isLoading = isLoading
    }
    
    public var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(isEnabled ? Color.blue : Color.gray)
            .cornerRadius(10)
        }
        .disabled(!isEnabled || isLoading)
    }
}

public struct SecondaryButton: View {
    public let title: String
    public let action: () -> Void
    public let isEnabled: Bool
    
    public init(
        title: String,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        self.isEnabled = isEnabled
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(isEnabled ? .blue : .gray)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isEnabled ? Color.blue : Color.gray, lineWidth: 2)
                )
        }
        .disabled(!isEnabled)
    }
}

public struct IconButton: View {
    public let icon: String
    public let title: String?
    public let action: () -> Void
    public let isEnabled: Bool
    
    public init(
        icon: String,
        title: String? = nil,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.action = action
        self.isEnabled = isEnabled
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title3)
                
                if let title = title {
                    Text(title)
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
            .foregroundColor(isEnabled ? .primary : .secondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
        .disabled(!isEnabled)
    }
}

public struct FloatingActionButton: View {
    public let icon: String
    public let action: () -> Void
    public let backgroundColor: Color
    
    public init(
        icon: String,
        backgroundColor: Color = .blue,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(backgroundColor)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }
}

public struct ToggleButton: View {
    @Binding public var isOn: Bool
    public let title: String
    public let icon: String?
    
    public init(
        isOn: Binding<Bool>,
        title: String,
        icon: String? = nil
    ) {
        self._isOn = isOn
        self.title = title
        self.icon = icon
    }
    
    public var body: some View {
        Button(action: {
            isOn.toggle()
        }) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.title3)
                }
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundColor(isOn ? .blue : .gray)
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

public struct GradientButton: View {
    public let title: String
    public let gradient: LinearGradient
    public let action: () -> Void
    public let isEnabled: Bool
    
    public init(
        title: String,
        gradient: LinearGradient = LinearGradient(
            colors: [.blue, .purple],
            startPoint: .leading,
            endPoint: .trailing
        ),
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.gradient = gradient
        self.action = action
        self.isEnabled = isEnabled
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(isEnabled ? gradient : LinearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
        }
        .disabled(!isEnabled)
    }
}

public struct SocialButton: View {
    public let title: String
    public let icon: String
    public let backgroundColor: Color
    public let action: () -> Void
    
    public init(
        title: String,
        icon: String,
        backgroundColor: Color,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(backgroundColor)
            .cornerRadius(10)
        }
    }
}

// MARK: - Button Styles
public struct RoundedButtonStyle: ButtonStyle {
    public let backgroundColor: Color
    public let foregroundColor: Color
    public let cornerRadius: CGFloat
    
    public init(
        backgroundColor: Color = .blue,
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 10
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

public struct OutlinedButtonStyle: ButtonStyle {
    public let borderColor: Color
    public let foregroundColor: Color
    public let cornerRadius: CGFloat
    
    public init(
        borderColor: Color = .blue,
        foregroundColor: Color = .blue,
        cornerRadius: CGFloat = 10
    ) {
        self.borderColor = borderColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Button Extensions
public extension View {
    func primaryButtonStyle() -> some View {
        self.buttonStyle(RoundedButtonStyle())
    }
    
    func secondaryButtonStyle() -> some View {
        self.buttonStyle(OutlinedButtonStyle())
    }
    
    func gradientButtonStyle(gradient: LinearGradient) -> some View {
        self.buttonStyle(RoundedButtonStyle(backgroundColor: .clear))
            .background(gradient)
    }
} 