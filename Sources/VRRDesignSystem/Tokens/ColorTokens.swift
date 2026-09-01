import SwiftUI

// MARK: - Color Token Protocol (Interface Segregation)

/// Defines the complete semantic color contract for the design system.
///
/// Consuming apps conform to this protocol to provide their brand palette.
/// All colors are semantic — they describe *purpose*, not *appearance*.
/// This enables automatic Dark Mode support when backed by adaptive `Color` values.
///
/// ## Override Example
/// ```swift
/// struct MyAppColors: VRRColorTokens {
///     var primary: Color { Color("BrandBlue") }
///     var onPrimary: Color { .white }
///     // ... provide all tokens
/// }
/// ```
public protocol VRRColorTokens: Sendable {

    // MARK: - Brand Colors

    /// Primary brand color — key actions, active navigation, emphasis.
    var primary: Color { get }

    /// Secondary brand color — supporting actions, secondary buttons.
    var secondary: Color { get }

    /// Tertiary accent — subtle highlights, decorative elements.
    var tertiary: Color { get }

    // MARK: - Semantic State Colors

    /// Destructive / error state.
    var error: Color { get }

    /// Warning / caution state.
    var warning: Color { get }

    /// Success / confirmation state.
    var success: Color { get }

    /// Informational / neutral state.
    var info: Color { get }

    // MARK: - Surface Colors

    /// App canvas / root background.
    var background: Color { get }

    /// Primary elevated surface (cards, sheets).
    var surface: Color { get }

    /// Secondary surface for grouped/nested containers.
    var surfaceSecondary: Color { get }

    // MARK: - On-Color Tokens (foreground on filled backgrounds)

    /// Foreground on `primary` surfaces.
    var onPrimary: Color { get }

    /// Foreground on `secondary` surfaces.
    var onSecondary: Color { get }

    /// Foreground on `tertiary` surfaces.
    var onTertiary: Color { get }

    /// Foreground on `background`.
    var onBackground: Color { get }

    /// Foreground on `surface`.
    var onSurface: Color { get }

    /// Foreground on `error` surfaces.
    var onError: Color { get }

    // MARK: - Text Colors

    /// Primary text — body copy, headings.
    var textPrimary: Color { get }

    /// Secondary text — captions, subtitles.
    var textSecondary: Color { get }

    /// Tertiary text — placeholders, de-emphasized.
    var textTertiary: Color { get }

    /// Disabled text.
    var textDisabled: Color { get }

    // MARK: - Border & Separator

    /// Default border/stroke for inputs, dividers.
    var border: Color { get }

    /// Focused/active border.
    var borderFocused: Color { get }

    /// System separator (thin dividers in lists).
    var separator: Color { get }

    // MARK: - Tint & Overlay

    /// Standard tint for interactive elements (links, switches).
    var tint: Color { get }

    /// Scrim overlay for modals and sheets.
    var scrim: Color { get }
}
