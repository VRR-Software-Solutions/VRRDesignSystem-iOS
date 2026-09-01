import SwiftUI

// MARK: - VRR Text Style

/// Semantic text roles that map to theme typography + color tokens.
///
/// Instead of manually combining `.font()` and `.foregroundStyle()`,
/// apply a single semantic modifier that reads from the theme.
public enum VRRTextStyle: Sendable {
    /// Large title — hero, onboarding.
    case largeTitle
    /// Title 1 — primary headings.
    case title1
    /// Title 2 — secondary headings.
    case title2
    /// Title 3 — card titles, section headers.
    case title3
    /// Headline — emphasized body text.
    case headline
    /// Body — default reading text.
    case body
    /// Callout — slightly smaller body.
    case callout
    /// Subheadline — subtitles, list descriptions.
    case subheadline
    /// Footnote — timestamps, metadata.
    case footnote
    /// Caption — small labels.
    case caption
    /// Caption 2 — smallest text.
    case caption2
}

// MARK: - ViewModifier

/// Applies theme-driven font + foreground color based on a semantic text style.
private struct VRRTextModifier: ViewModifier {

    @Environment(\.vrrTheme) private var theme

    let style: VRRTextStyle
    let color: VRRTextColor

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(foregroundColor)
    }

    private var font: Font {
        switch style {
        case .largeTitle: return theme.typography.largeTitle
        case .title1: return theme.typography.title1
        case .title2: return theme.typography.title2
        case .title3: return theme.typography.title3
        case .headline: return theme.typography.headline
        case .body: return theme.typography.body
        case .callout: return theme.typography.callout
        case .subheadline: return theme.typography.subheadline
        case .footnote: return theme.typography.footnote
        case .caption: return theme.typography.caption1
        case .caption2: return theme.typography.caption2
        }
    }

    private var foregroundColor: Color {
        switch color {
        case .primary: return theme.colors.textPrimary
        case .secondary: return theme.colors.textSecondary
        case .tertiary: return theme.colors.textTertiary
        case .disabled: return theme.colors.textDisabled
        case .onPrimary: return theme.colors.onPrimary
        case .error: return theme.colors.error
        case .success: return theme.colors.success
        case .custom(let c): return c
        }
    }
}

// MARK: - VRR Text Color

/// Semantic text color role.
public enum VRRTextColor: Sendable {
    case primary
    case secondary
    case tertiary
    case disabled
    case onPrimary
    case error
    case success
    case custom(Color)
}

// MARK: - View Extension

extension View {

    /// Applies a semantic VRR text style with theme-driven font and color.
    ///
    /// ```swift
    /// Text("Welcome Back")
    ///     .vrrText(.largeTitle)
    ///
    /// Text("Last updated 5 min ago")
    ///     .vrrText(.caption, color: .secondary)
    ///
    /// Text("Error occurred")
    ///     .vrrText(.body, color: .error)
    /// ```
    public func vrrText(_ style: VRRTextStyle, color: VRRTextColor = .primary) -> some View {
        modifier(VRRTextModifier(style: style, color: color))
    }
}
