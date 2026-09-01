import SwiftUI

// MARK: - Shadow Convenience

extension View {

    /// Applies a `VRRShadow` token to this view.
    ///
    /// Reads the shadow definition and maps it to SwiftUI's native `.shadow()` modifier.
    /// ```swift
    /// Card()
    ///     .vrrShadow(theme.elevation.sm)
    /// ```
    public func vrrShadow(_ shadow: VRRShadow) -> some View {
        self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}
