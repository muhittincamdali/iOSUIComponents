import SwiftUI

#if canImport(UIKit)
import UIKit

/// A world-class, thread-safe Haptic Engine for sensory UI feedback.
/// 
/// Integrates instantly into SwiftUIComponents to provide premium tactile interactions.
@MainActor
public struct PremiumHaptics {
    
    public enum FeedbackStyle {
        case light
        case medium
        case heavy
        case success
        case warning
        case error
    }
    
    /// Triggers a high-fidelity haptic feedback response.
    public static func play(_ style: FeedbackStyle) {
        switch style {
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}

public extension View {
    /// Attaches a premium haptic feedback to a tap gesture.
    func hapticTapGesture(style: PremiumHaptics.FeedbackStyle = .light, perform action: @escaping () -> Void) -> some View {
        self.onTapGesture {
            PremiumHaptics.play(style)
            action()
        }
    }
}
#else
@MainActor
public struct PremiumHaptics {
    public enum FeedbackStyle {
        case light, medium, heavy, success, warning, error
    }
    public static func play(_ style: FeedbackStyle) {}
}
public extension View {
    func hapticTapGesture(style: PremiumHaptics.FeedbackStyle = .light, perform action: @escaping () -> Void) -> some View {
        self.onTapGesture(perform: action)
    }
}
#endif
