import SwiftUI

// MARK: - VRR Progress Variant

/// Visual variant for progress indicators.
public enum VRRProgressVariant: Sendable {
    /// Circular spinner (indeterminate).
    case circular
    /// Linear bar (determinate or indeterminate).
    case linear
}

// MARK: - VRRProgressViewStyle

/// A `ProgressViewStyle` that tints Apple's native `ProgressView` with theme colors.
///
/// Apple's ProgressView handles accessibility (announces progress to VoiceOver),
/// animation, and platform adaptation. We just theme it.
///
/// ## Usage
/// ```swift
/// // Indeterminate spinner
/// ProgressView()
///     .progressViewStyle(.vrr)
///
/// // Determinate linear bar
/// ProgressView(value: 0.6)
///     .progressViewStyle(.vrr(.linear))
///
/// // Custom tint
/// ProgressView()
///     .progressViewStyle(.vrr(.circular, tint: .secondary))
/// ```
public struct VRRProgressViewStyle: ProgressViewStyle {

    @Environment(\.vrrTheme) private var theme

    private let variant: VRRProgressVariant
    private let tint: VRRProgressTint

    public init(
        variant: VRRProgressVariant = .circular,
        tint: VRRProgressTint = .primary
    ) {
        self.variant = variant
        self.tint = tint
    }

    public func makeBody(configuration: Configuration) -> some View {
        switch variant {
        case .circular:
            ProgressView(configuration)
                .tint(tintColor)
        case .linear:
            ProgressView(configuration)
                .progressViewStyle(.linear)
                .tint(tintColor)
        }
    }

    private var tintColor: Color {
        switch tint {
        case .primary: return theme.colors.primary
        case .secondary: return theme.colors.secondary
        case .success: return theme.colors.success
        case .custom(let color): return color
        }
    }
}

// MARK: - Progress Tint

/// Controls the color of a VRR progress indicator.
public enum VRRProgressTint: Sendable {
    case primary
    case secondary
    case success
    case custom(Color)
}

// MARK: - Convenience Static Factory

extension ProgressViewStyle where Self == VRRProgressViewStyle {

    /// VRR-themed progress view with primary tint (circular).
    public static var vrr: VRRProgressViewStyle {
        VRRProgressViewStyle()
    }

    /// VRR-themed progress view with specific variant and tint.
    ///
    /// ```swift
    /// ProgressView(value: 0.75)
    ///     .progressViewStyle(.vrr(.linear, tint: .success))
    /// ```
    public static func vrr(
        _ variant: VRRProgressVariant = .circular,
        tint: VRRProgressTint = .primary
    ) -> VRRProgressViewStyle {
        VRRProgressViewStyle(variant: variant, tint: tint)
    }
}
