import SwiftUI

// MARK: - VRRDivider

/// A themed divider that uses the theme's separator color.
///
/// Apple's built-in `Divider()` uses a system color that can't be customized.
/// This component respects the theme's `colors.separator` token and allows
/// configurable thickness and insets.
///
/// ## Usage
/// ```swift
/// VRRDivider()
///
/// VRRDivider(thickness: 2)
///
/// VRRDivider(leadingInset: 16) // indented like a list separator
///
/// // Vertical
/// VRRDivider(axis: .vertical)
/// ```
public struct VRRDivider: View {

    @Environment(\.vrrTheme) private var theme

    private let axis: Axis
    private let thickness: CGFloat?
    private let leadingInset: CGFloat
    private let trailingInset: CGFloat
    private let color: Color?

    public init(
        axis: Axis = .horizontal,
        thickness: CGFloat? = nil,
        leadingInset: CGFloat = 0,
        trailingInset: CGFloat = 0,
        color: Color? = nil
    ) {
        self.axis = axis
        self.thickness = thickness
        self.leadingInset = leadingInset
        self.trailingInset = trailingInset
        self.color = color
    }

    public var body: some View {
        switch axis {
        case .horizontal:
            horizontalDivider
        case .vertical:
            verticalDivider
        }
    }

    private var horizontalDivider: some View {
        Rectangle()
            .fill(resolvedColor)
            .frame(height: resolvedThickness)
            .padding(.leading, leadingInset)
            .padding(.trailing, trailingInset)
    }

    private var verticalDivider: some View {
        Rectangle()
            .fill(resolvedColor)
            .frame(width: resolvedThickness)
            .padding(.top, leadingInset)
            .padding(.bottom, trailingInset)
    }

    private var resolvedColor: Color {
        color ?? theme.colors.separator
    }

    private var resolvedThickness: CGFloat {
        thickness ?? 0.5 // Apple's standard hairline separator
    }
}
