import SwiftUI

// MARK: - Theme-Aware Corner Radius

extension View {

    /// Clips this view with a shape that respects the theme's per-role shape style.
    ///
    /// When the given role's shape is `.capsule`, ignores the radius value and uses
    /// full rounding. When `.rounded`, applies the provided radius with the theme's
    /// continuous/circular corner style.
    ///
    /// Defaults to the `.container` role, which is the safe choice for arbitrary views
    /// (a full radius on a large view would produce an oval).
    ///
    /// ```swift
    /// @Environment(\.vrrTheme) var theme
    ///
    /// // A container surface (stays rounded under capsule themes)
    /// MyCard()
    ///     .vrrCornerRadius(theme.radius.lg, theme: theme)
    ///
    /// // A control that should become a pill under capsule themes
    /// MyControl()
    ///     .vrrCornerRadius(theme.radius.md, theme: theme, role: .control)
    /// ```
    public func vrrCornerRadius(
        _ radius: CGFloat,
        theme: any VRRTheme,
        role: VRRShapeRole = .container
    ) -> some View {
        let effectiveRadius = theme.radius.effectiveRadius(radius, for: role)
        return self.clipShape(
            RoundedRectangle(cornerRadius: effectiveRadius, style: theme.radius.cornerStyle)
        )
    }
}
