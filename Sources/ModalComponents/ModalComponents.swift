import SwiftUI

// MARK: - Modal Components
public struct CustomAlert: View {
    public let title: String
    public let message: String?
    public let primaryButton: AlertButton
    public let secondaryButton: AlertButton?
    public let isPresented: Binding<Bool>
    
    public init(
        title: String,
        message: String? = nil,
        primaryButton: AlertButton,
        secondaryButton: AlertButton? = nil,
        isPresented: Binding<Bool>
    ) {
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self.isPresented = isPresented
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented.wrappedValue = false
                }
            
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    if let message = message {
                        Text(message)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                
                HStack(spacing: 12) {
                    if let secondaryButton = secondaryButton {
                        Button(action: {
                            secondaryButton.action()
                            isPresented.wrappedValue = false
                        }) {
                            Text(secondaryButton.title)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(secondaryButton.style.textColor)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(secondaryButton.style.backgroundColor)
                                .cornerRadius(10)
                        }
                    }
                    
                    Button(action: {
                        primaryButton.action()
                        isPresented.wrappedValue = false
                    }) {
                        Text(primaryButton.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(primaryButton.style.textColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(primaryButton.style.backgroundColor)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(24)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 40)
        }
        .opacity(isPresented.wrappedValue ? 1 : 0)
        .animation(.easeInOut(duration: 0.2), value: isPresented.wrappedValue)
    }
}

public struct AlertButton {
    public let title: String
    public let style: AlertButtonStyle
    public let action: () -> Void
    
    public init(
        title: String,
        style: AlertButtonStyle = .default,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}

public struct AlertButtonStyle {
    public let backgroundColor: Color
    public let textColor: Color
    
    public init(backgroundColor: Color, textColor: Color) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    public static let `default` = AlertButtonStyle(backgroundColor: .blue, textColor: .white)
    public static let destructive = AlertButtonStyle(backgroundColor: .red, textColor: .white)
    public static let cancel = AlertButtonStyle(backgroundColor: Color(.systemGray5), textColor: .primary)
}

public struct CustomSheet<Content: View>: View {
    public let content: Content
    public let isPresented: Binding<Bool>
    public let style: SheetStyle
    
    public init(
        isPresented: Binding<Bool>,
        style: SheetStyle = .default,
        @ViewBuilder content: () -> Content
    ) {
        self.isPresented = isPresented
        self.style = style
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            if isPresented.wrappedValue {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented.wrappedValue = false
                    }
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        // Handle
                        RoundedRectangle(cornerRadius: 2.5)
                            .fill(Color(.systemGray4))
                            .frame(width: 36, height: 5)
                            .padding(.top, 8)
                            .padding(.bottom, 16)
                        
                        content
                            .padding(.horizontal, 16)
                            .padding(.bottom, 34)
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(style.cornerRadius, corners: [.topLeft, .topRight])
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: -10)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented.wrappedValue)
    }
}

public struct SheetStyle {
    public let cornerRadius: CGFloat
    
    public init(cornerRadius: CGFloat = 16) {
        self.cornerRadius = cornerRadius
    }
    
    public static let `default` = SheetStyle()
    public static let large = SheetStyle(cornerRadius: 20)
    public static let medium = SheetStyle(cornerRadius: 12)
    public static let custom = SheetStyle(cornerRadius: 24)
}

public struct CustomActionSheet: View {
    public let title: String?
    public let message: String?
    public let buttons: [ActionButton]
    public let isPresented: Binding<Bool>
    
    public init(
        title: String? = nil,
        message: String? = nil,
        buttons: [ActionButton],
        isPresented: Binding<Bool>
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.isPresented = isPresented
    }
    
    public var body: some View {
        ZStack {
            if isPresented.wrappedValue {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented.wrappedValue = false
                    }
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        if let title = title {
                            Text(title)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.top, 20)
                                .padding(.bottom, 8)
                        }
                        
                        if let message = message {
                            Text(message)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                        }
                        
                        VStack(spacing: 0) {
                            ForEach(Array(buttons.enumerated()), id: \.offset) { index, button in
                                Button(action: {
                                    button.action()
                                    isPresented.wrappedValue = false
                                }) {
                                    Text(button.title)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(button.style.textColor)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                }
                                .background(Color(.systemBackground))
                                
                                if index < buttons.count - 1 {
                                    Divider()
                                        .padding(.leading, 20)
                                }
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        
                        Button(action: {
                            isPresented.wrappedValue = false
                        }) {
                            Text("Cancel")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 34)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented.wrappedValue)
    }
}

public struct ActionButton {
    public let title: String
    public let style: ActionButtonStyle
    public let action: () -> Void
    
    public init(
        title: String,
        style: ActionButtonStyle = .default,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}

public struct ActionButtonStyle {
    public let textColor: Color
    
    public init(textColor: Color) {
        self.textColor = textColor
    }
    
    public static let `default` = ActionButtonStyle(textColor: .blue)
    public static let destructive = ActionButtonStyle(textColor: .red)
    public static let cancel = ActionButtonStyle(textColor: .red)
}

public struct CustomModal<Content: View>: View {
    public let content: Content
    public let isPresented: Binding<Bool>
    public let style: ModalStyle
    
    public init(
        isPresented: Binding<Bool>,
        style: ModalStyle = .default,
        @ViewBuilder content: () -> Content
    ) {
        self.isPresented = isPresented
        self.style = style
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            if isPresented.wrappedValue {
                Color.black.opacity(style.overlayOpacity)
                    .ignoresSafeArea()
                    .onTapGesture {
                        if style.dismissOnOverlayTap {
                            isPresented.wrappedValue = false
                        }
                    }
                
                content
                    .background(Color(.systemBackground))
                    .cornerRadius(style.cornerRadius)
                    .shadow(color: .black.opacity(0.2), radius: style.shadowRadius, x: 0, y: style.shadowOffset)
                    .padding(.horizontal, style.horizontalPadding)
                    .scaleEffect(isPresented.wrappedValue ? 1 : 0.8)
                    .opacity(isPresented.wrappedValue ? 1 : 0)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented.wrappedValue)
    }
}

public struct ModalStyle {
    public let cornerRadius: CGFloat
    public let shadowRadius: CGFloat
    public let shadowOffset: CGFloat
    public let horizontalPadding: CGFloat
    public let overlayOpacity: Double
    public let dismissOnOverlayTap: Bool
    
    public init(
        cornerRadius: CGFloat = 16,
        shadowRadius: CGFloat = 20,
        shadowOffset: CGFloat = 10,
        horizontalPadding: CGFloat = 40,
        overlayOpacity: Double = 0.3,
        dismissOnOverlayTap: Bool = true
    ) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.horizontalPadding = horizontalPadding
        self.overlayOpacity = overlayOpacity
        self.dismissOnOverlayTap = dismissOnOverlayTap
    }
    
    public static let `default` = ModalStyle()
    public static let large = ModalStyle(cornerRadius: 20, horizontalPadding: 20)
    public static let small = ModalStyle(cornerRadius: 12, horizontalPadding: 60)
}

// MARK: - Extensions
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
} 