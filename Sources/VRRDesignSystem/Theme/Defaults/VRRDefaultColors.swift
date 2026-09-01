import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Default Color Tokens

/// Apple-native default colors using the system semantic palette.
///
/// These map directly to Apple's adaptive colors that automatically
/// respond to Dark Mode, Increased Contrast, and accessibility settings.
/// Consuming apps override this to inject their brand palette.
public struct VRRDefaultColors: VRRColorTokens, Sendable {

    public init() {}

    // MARK: - Brand Colors

    public var primary: Color { .blue }
    public var secondary: Color { .indigo }
    public var tertiary: Color { .purple }

    // MARK: - Semantic State Colors

    public var error: Color { .red }
    public var warning: Color { .orange }
    public var success: Color { .green }
    public var info: Color { .cyan }

    // MARK: - Surface Colors

    public var background: Color {
        #if canImport(UIKit)
        Color(uiColor: .systemBackground)
        #else
        Color(nsColor: .windowBackgroundColor)
        #endif
    }

    public var surface: Color {
        #if canImport(UIKit)
        Color(uiColor: .secondarySystemBackground)
        #else
        Color(nsColor: .controlBackgroundColor)
        #endif
    }

    public var surfaceSecondary: Color {
        #if canImport(UIKit)
        Color(uiColor: .tertiarySystemBackground)
        #else
        Color(nsColor: .underPageBackgroundColor)
        #endif
    }

    // MARK: - On-Color Tokens

    public var onPrimary: Color { .white }
    public var onSecondary: Color { .white }
    public var onTertiary: Color { .white }

    public var onBackground: Color {
        #if canImport(UIKit)
        Color(uiColor: .label)
        #else
        Color(nsColor: .labelColor)
        #endif
    }

    public var onSurface: Color {
        #if canImport(UIKit)
        Color(uiColor: .label)
        #else
        Color(nsColor: .labelColor)
        #endif
    }

    public var onError: Color { .white }

    // MARK: - Text Colors

    public var textPrimary: Color {
        #if canImport(UIKit)
        Color(uiColor: .label)
        #else
        Color(nsColor: .labelColor)
        #endif
    }

    public var textSecondary: Color {
        #if canImport(UIKit)
        Color(uiColor: .secondaryLabel)
        #else
        Color(nsColor: .secondaryLabelColor)
        #endif
    }

    public var textTertiary: Color {
        #if canImport(UIKit)
        Color(uiColor: .tertiaryLabel)
        #else
        Color(nsColor: .tertiaryLabelColor)
        #endif
    }

    public var textDisabled: Color {
        #if canImport(UIKit)
        Color(uiColor: .quaternaryLabel)
        #else
        Color(nsColor: .quaternaryLabelColor)
        #endif
    }

    // MARK: - Border & Separator

    public var border: Color {
        #if canImport(UIKit)
        Color(uiColor: .separator)
        #else
        Color(nsColor: .separatorColor)
        #endif
    }

    public var borderFocused: Color { .blue }

    public var separator: Color {
        #if canImport(UIKit)
        Color(uiColor: .separator)
        #else
        Color(nsColor: .separatorColor)
        #endif
    }

    // MARK: - Tint & Overlay

    public var tint: Color { .blue }
    public var scrim: Color { Color.black.opacity(0.3) }
}
