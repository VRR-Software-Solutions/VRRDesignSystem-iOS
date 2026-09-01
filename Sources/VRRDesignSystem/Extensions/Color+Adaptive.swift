import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Adaptive Color Initializer

extension Color {

    /// Creates an adaptive color that automatically switches between light and dark variants.
    ///
    /// Leverages `UIColor` on iOS/iPadOS and `NSColor` on macOS to respond
    /// to the system appearance. This is the recommended way to define
    /// brand colors that need to adapt to Dark Mode.
    ///
    /// ```swift
    /// let brandBlue = Color(
    ///     light: Color(red: 0.0, green: 0.47, blue: 1.0),
    ///     dark: Color(red: 0.4, green: 0.69, blue: 1.0)
    /// )
    /// ```
    ///
    /// - Parameters:
    ///   - light: The color to use in light appearance.
    ///   - dark: The color to use in dark appearance.
    public init(light: Color, dark: Color) {
        #if canImport(UIKit)
        self.init(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(dark)
                : UIColor(light)
        })
        #elseif canImport(AppKit)
        self.init(nsColor: NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                ? NSColor(dark)
                : NSColor(light)
        })
        #endif
    }
}
