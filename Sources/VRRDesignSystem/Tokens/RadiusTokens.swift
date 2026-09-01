import SwiftUI

// MARK: - VRR Shape Style

/// Controls whether a component renders with a rounded rectangle or a capsule/pill shape.
///
/// Applied per semantic role (see `VRRShapeRole`) rather than globally — this ensures
/// pill-shaped controls (buttons, chips) don't accidentally turn large containers
/// (cards, sheets) into ovals.
public enum VRRShapeStyle: Sendable, Equatable {
    /// Standard rounded rectangle with the specified corner radius.
    case rounded
    /// Capsule / pill shape — ignores corner radius values, uses full rounding.
    case capsule
}

// MARK: - VRR Shape Role

/// The semantic role of a component, used to resolve its shape.
///
/// A capsule brand identity means "make my controls pills" — it should NOT make
/// large containers into ovals. Splitting shape by role keeps that distinction clean.
///
/// - `control`: Small, roughly symmetric interactive elements where a full radius
///   produces a proper pill — buttons, chips, text fields, badges, toasts.
/// - `container`: Large rectangular surfaces where a full radius would look wrong —
///   cards, banners, sheets. These stay rounded even in capsule themes.
public enum VRRShapeRole: Sendable, Equatable {
    /// Interactive controls — buttons, chips, text fields, badges, toasts.
    case control
    /// Surfaces / containers — cards, banners, sheets.
    case container
}

// MARK: - Corner Radius Token Protocol (Interface Segregation)

/// Defines corner radius values and per-role shape behavior for the design system.
///
/// The `shape(for:)` method controls the shape of each semantic role. A capsule
/// brand returns `.capsule` for `.control` and `.rounded` for `.container`, so
/// buttons become pills while cards stay properly rounded.
///
/// ## Override Example (capsule controls, rounded containers)
/// ```swift
/// struct CapsuleControls: VRRRadiusTokens {
///     var sm: CGFloat { 4 }
///     var md: CGFloat { 8 }
///     var lg: CGFloat { 12 }
///     var xl: CGFloat { 20 }
///     var full: CGFloat { 9999 }
///     var usesContinuousCorners: Bool { true }
///
///     func shape(for role: VRRShapeRole) -> VRRShapeStyle {
///         switch role {
///         case .control:   return .capsule   // pill buttons/chips
///         case .container: return .rounded   // normal cards
///         }
///     }
/// }
/// ```
public protocol VRRRadiusTokens: Sendable {

    /// 4pt — subtle (chips, small badges, tags).
    var sm: CGFloat { get }

    /// 8pt — standard (buttons, text fields, small cards).
    var md: CGFloat { get }

    /// 12pt — prominent (cards, grouped content).
    var lg: CGFloat { get }

    /// 20pt — large (sheets, modals, bottom sheets).
    var xl: CGFloat { get }

    /// Full / capsule — pill shapes, circular buttons.
    var full: CGFloat { get }

    /// Whether to use Apple's continuous (superellipse) corner style.
    /// When `true`, components apply `RoundedRectangle(cornerRadius:style: .continuous)`.
    var usesContinuousCorners: Bool { get }

    /// Resolves the shape for a given semantic role.
    ///
    /// Default implementation returns `.rounded` for every role. Override to make
    /// controls (and optionally containers) capsule-shaped.
    func shape(for role: VRRShapeRole) -> VRRShapeStyle
}

// MARK: - Default Shape Behavior

extension VRRRadiusTokens {

    /// By default, every role is `.rounded`. Themes opt in to capsule per role.
    public func shape(for role: VRRShapeRole) -> VRRShapeStyle {
        .rounded
    }
}

// MARK: - Shape Builder Helpers

/// Helpers that every component uses to resolve the correct radius/shape
/// for its semantic role, honoring `usesContinuousCorners`.
extension VRRRadiusTokens {

    /// Resolves the effective corner radius for a given token radius and role.
    ///
    /// Returns `full` (capsule) when the role's shape is `.capsule`, otherwise
    /// returns the provided radius unchanged.
    public func effectiveRadius(_ radius: CGFloat, for role: VRRShapeRole) -> CGFloat {
        shape(for: role) == .capsule ? full : radius
    }

    /// The `RoundedCornerStyle` derived from `usesContinuousCorners`.
    public var cornerStyle: RoundedCornerStyle {
        usesContinuousCorners ? .continuous : .circular
    }
}
