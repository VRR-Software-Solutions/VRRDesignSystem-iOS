import SwiftUI

// MARK: - Typography Token Protocol (Interface Segregation)

/// Defines the complete typography scale for the design system.
///
/// Mirrors Apple's native type hierarchy from `Font`. By default, the system
/// uses San Francisco (SF Pro) through the standard `Font` API. Consuming apps
/// can override with custom typefaces while preserving the semantic scale.
///
/// All fonts follow Apple's Dynamic Type scale, ensuring accessibility compliance
/// out of the box when using the default implementation.
///
/// ## Override Example
/// ```swift
/// struct MyAppTypography: VRRTypographyTokens {
///     var largeTitle: Font { .custom("Avenir-Heavy", size: 34, relativeTo: .largeTitle) }
///     var title1: Font { .custom("Avenir-Medium", size: 28, relativeTo: .title) }
///     // ...
/// }
/// ```
public protocol VRRTypographyTokens: Sendable {

    // MARK: - Display & Title Scale

    /// Extra large title — hero sections, onboarding.
    /// Apple default: SF Pro, 34pt regular.
    var largeTitle: Font { get }

    /// Title 1 — primary screen/section headings.
    /// Apple default: SF Pro, 28pt regular.
    var title1: Font { get }

    /// Title 2 — secondary headings.
    /// Apple default: SF Pro, 22pt regular.
    var title2: Font { get }

    /// Title 3 — tertiary headings, card titles.
    /// Apple default: SF Pro, 20pt regular.
    var title3: Font { get }

    // MARK: - Body Scale

    /// Headline — emphasized body-level, navigation bar titles.
    /// Apple default: SF Pro, 17pt semibold.
    var headline: Font { get }

    /// Body — default reading text, primary content.
    /// Apple default: SF Pro, 17pt regular.
    var body: Font { get }

    /// Callout — slightly smaller body, sidebar content.
    /// Apple default: SF Pro, 16pt regular.
    var callout: Font { get }

    /// Subheadline — list subtitles, secondary descriptions.
    /// Apple default: SF Pro, 15pt regular.
    var subheadline: Font { get }

    // MARK: - Caption Scale

    /// Footnote — timestamps, tertiary info.
    /// Apple default: SF Pro, 13pt regular.
    var footnote: Font { get }

    /// Caption 1 — small labels, tab bar labels.
    /// Apple default: SF Pro, 12pt regular.
    var caption1: Font { get }

    /// Caption 2 — smallest text, legal fine print.
    /// Apple default: SF Pro, 11pt regular.
    var caption2: Font { get }
}
