import SwiftUI

// MARK: - VRR Toast Role

/// Semantic role for toast messages.
public enum VRRToastRole: Sendable {
    case info
    case success
    case warning
    case error
}

// MARK: - VRR Toast Data

/// The content model for a toast notification.
public struct VRRToastData: Sendable, Equatable {
    public let message: String
    public let role: VRRToastRole
    public let icon: String? // SF Symbol name
    public let duration: Double

    public init(
        message: String,
        role: VRRToastRole = .info,
        icon: String? = nil,
        duration: Double = 3.0
    ) {
        self.message = message
        self.role = role
        self.icon = icon
        self.duration = duration
    }

    public static func == (lhs: VRRToastData, rhs: VRRToastData) -> Bool {
        lhs.message == rhs.message && lhs.duration == rhs.duration
    }
}

// MARK: - VRR Toast ViewModifier

/// Displays a temporary floating toast notification.
///
/// Appears at the top of the screen, auto-dismisses after the specified duration.
/// Uses the `.control` shape role — capsule themes render toasts as pills.
///
/// ## Usage
/// ```swift
/// struct ContentView: View {
///     @State private var toast: VRRToastData?
///
///     var body: some View {
///         VStack {
///             Button("Save") {
///                 toast = VRRToastData(message: "Saved!", role: .success)
///             }
///         }
///         .vrrToast($toast)
///     }
/// }
/// ```
private struct VRRToastModifier: ViewModifier {

    @Environment(\.vrrTheme) private var theme

    @Binding var toast: VRRToastData?
    @State private var isShowing = false

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if isShowing, let toast {
                    toastView(toast)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.horizontal, theme.spacing.md)
                        .padding(.top, theme.spacing.sm)
                }
            }
            .onChange(of: toast) { _, newValue in
                if newValue != nil {
                    withAnimation(theme.animation.emphasized) {
                        isShowing = true
                    }
                    scheduleHide()
                }
            }
    }

    private func toastView(_ data: VRRToastData) -> some View {
        HStack(spacing: theme.spacing.xs) {
            Image(systemName: iconName(for: data))
                .font(theme.typography.body)
                .foregroundStyle(roleColor(for: data.role))

            Text(data.message)
                .font(theme.typography.subheadline)
                .foregroundStyle(theme.colors.textPrimary)
                .lineLimit(2)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, theme.spacing.sm)
        .background(
            theme.colors.surface,
            in: toastShape
        )
        .shadow(
            color: theme.elevation.md.color,
            radius: theme.elevation.md.radius,
            x: theme.elevation.md.x,
            y: theme.elevation.md.y
        )
    }

    private var toastShape: some Shape {
        RoundedRectangle(
            cornerRadius: theme.radius.effectiveRadius(theme.radius.lg, for: .control),
            style: theme.radius.cornerStyle
        )
    }

    private var horizontalPadding: CGFloat {
        theme.radius.shape(for: .control) == .capsule ? theme.spacing.lg : theme.spacing.md
    }

    private func scheduleHide() {
        let duration = toast?.duration ?? 3.0
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(duration))
            withAnimation(theme.animation.standard) {
                isShowing = false
            }
            // Clear binding after animation completes
            try? await Task.sleep(for: .seconds(0.4))
            toast = nil
        }
    }

    private func iconName(for data: VRRToastData) -> String {
        if let icon = data.icon { return icon }
        switch data.role {
        case .info: return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "xmark.circle.fill"
        }
    }

    private func roleColor(for role: VRRToastRole) -> Color {
        switch role {
        case .info: return theme.colors.info
        case .success: return theme.colors.success
        case .warning: return theme.colors.warning
        case .error: return theme.colors.error
        }
    }
}

// MARK: - View Extension

extension View {

    /// Attaches a toast notification overlay to this view.
    ///
    /// Set the binding to a `VRRToastData` value to show the toast.
    /// It auto-dismisses after the specified duration.
    ///
    /// ```swift
    /// .vrrToast($toastData)
    /// ```
    public func vrrToast(_ toast: Binding<VRRToastData?>) -> some View {
        modifier(VRRToastModifier(toast: toast))
    }
}
