import SwiftUI

/// iOSUIComponents: Dynamic Micro-Interaction Engine.
/// 
/// A set of high-performance modifiers that add "squash and stretch" 
/// physics to any SwiftUI view for an elite, playful interaction feel.
public struct MicroInteractionModifier: ViewModifier {
    @State private var scale: CGFloat = 1.0
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) { scale = 0.95 } }
                    .onEnded { _ in withAnimation(.spring(response: 0.4, dampingFraction: 0.4)) { scale = 1.0 } }
            )
    }
}

public extension View {
    /// Applies a premium 'Squash' micro-interaction.
    func microInteract() -> some View {
        self.modifier(MicroInteractionModifier())
    }
}
