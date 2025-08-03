import SwiftUI

// MARK: - Modal Components
public struct CustomAlert: View {
    public let title: String
    public let message: String
    public let buttons: [AlertButton]
    @Binding public var isPresented: Bool
    
    public init(
        title: String,
        message: String,
        buttons: [AlertButton],
        isPresented: Binding<Bool>
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self._isPresented = isPresented
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text(message)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                HStack(spacing: 12) {
                    ForEach(buttons, id: \.title) { button in
                        Button(action: {
                            button.action?()
                            isPresented = false
                        }) {
                            Text(button.title)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(button.style.textColor)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(button.style.backgroundColor)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 40)
        }
        .transition(.opacity.combined(with: .scale))
    }
}

public struct AlertButton {
    public let title: String
    public let style: AlertButtonStyle
    public let action: (() -> Void)?
    
    public init(
        title: String,
        style: AlertButtonStyle = .default,
        action: (() -> Void)? = nil
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
    public static let cancel = AlertButtonStyle(backgroundColor: Color.gray.opacity(0.2), textColor: .primary)
}

public struct CustomSheet: View {
    public let title: String?
    public let content: AnyView
    @Binding public var isPresented: Bool
    
    public init(
        title: String? = nil,
        content: AnyView,
        isPresented: Binding<Bool>
    ) {
        self.title = title
        self.content = content
        self._isPresented = isPresented
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 36, height: 5)
                        .padding(.top, 8)
                    
                    if let title = title {
                        Text(title)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    
                    content
                        .padding(.bottom, 34)
                }
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: -10)
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

public struct CustomActionSheet: View {
    public let title: String?
    public let message: String?
    public let actions: [ActionSheetAction]
    public let cancelAction: ActionSheetAction?
    @Binding public var isPresented: Bool
    
    public init(
        title: String? = nil,
        message: String? = nil,
        actions: [ActionSheetAction],
        cancelAction: ActionSheetAction? = nil,
        isPresented: Binding<Bool>
    ) {
        self.title = title
        self.message = message
        self.actions = actions
        self.cancelAction = cancelAction
        self._isPresented = isPresented
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 36, height: 5)
                        .padding(.top, 8)
                    
                    if let title = title {
                        Text(title)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    
                    if let message = message {
                        Text(message)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(spacing: 0) {
                        ForEach(actions, id: \.title) { action in
                            Button(action: {
                                action.action?()
                                isPresented = false
                            }) {
                                Text(action.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(action.style.textColor)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(action.style.backgroundColor)
                            }
                            .background(Color.white)
                            .cornerRadius(16)
                            
                            if action != actions.last {
                                Divider()
                                    .padding(.horizontal, 16)
                            }
                        }
                        
                        if let cancelAction = cancelAction {
                            Divider()
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            
                            Button(action: {
                                cancelAction.action?()
                                isPresented = false
                            }) {
                                Text(cancelAction.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(cancelAction.style.textColor)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(cancelAction.style.backgroundColor)
                            }
                            .background(Color.white)
                            .cornerRadius(16)
                        }
                    }
                    .padding(.bottom, 34)
                }
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: -10)
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

public struct ActionSheetAction {
    public let title: String
    public let style: ActionSheetActionStyle
    public let action: (() -> Void)?
    
    public init(
        title: String,
        style: ActionSheetActionStyle = .default,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}

public struct ActionSheetActionStyle {
    public let backgroundColor: Color
    public let textColor: Color
    
    public init(backgroundColor: Color, textColor: Color) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    public static let `default` = ActionSheetActionStyle(backgroundColor: .clear, textColor: .blue)
    public static let destructive = ActionSheetActionStyle(backgroundColor: .clear, textColor: .red)
    public static let cancel = ActionSheetActionStyle(backgroundColor: .clear, textColor: .secondary)
}

public struct CustomModal: View {
    public let content: AnyView
    @Binding public var isPresented: Bool
    
    public init(
        content: AnyView,
        isPresented: Binding<Bool>
    ) {
        self.content = content
        self._isPresented = isPresented
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            content
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                .scaleEffect(isPresented ? 1.0 : 0.8)
                .opacity(isPresented ? 1.0 : 0.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
        }
        .transition(.opacity.combined(with: .scale))
    }
}

// MARK: - Modal Extensions
public extension View {
    func customModalStyle() -> some View {
        self
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
    }
} 