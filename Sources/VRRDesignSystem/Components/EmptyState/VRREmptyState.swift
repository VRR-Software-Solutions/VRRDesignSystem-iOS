import SwiftUI

// MARK: - VRREmptyState

/// A themed empty/error/no-results state built on Apple's `ContentUnavailableView`.
///
/// Wraps `ContentUnavailableView` (available iOS 17+, macOS 14+) and applies
/// the theme's button style to the action. All native behavior — layout adaptation
/// for iPad/iPhone, Dynamic Type, accessibility — is fully preserved.
///
/// ## Usage
/// ```swift
/// VRREmptyState(
///     systemImage: "magnifyingglass",
///     title: "No Results",
///     description: "Try adjusting your search or filters."
/// )
///
/// VRREmptyState(
///     systemImage: "wifi.slash",
///     title: "No Connection",
///     description: "Please check your internet connection and try again.",
///     actionTitle: "Retry"
/// ) {
///     viewModel.retry()
/// }
/// ```
public struct VRREmptyState: View {

    private let systemImage: String
    private let title: String
    private let description: String?
    private let actionTitle: String?
    private let action: (() -> Void)?

    public init(
        systemImage: String,
        title: String,
        description: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.systemImage = systemImage
        self.title = title
        self.description = description
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        if let actionTitle, let action {
            ContentUnavailableView {
                Label(title, systemImage: systemImage)
            } description: {
                if let description {
                    Text(description)
                }
            } actions: {
                Button(actionTitle, action: action)
                    .buttonStyle(.vrr(.primary, size: .medium))
            }
        } else {
            ContentUnavailableView {
                Label(title, systemImage: systemImage)
            } description: {
                if let description {
                    Text(description)
                }
            }
        }
    }
}
