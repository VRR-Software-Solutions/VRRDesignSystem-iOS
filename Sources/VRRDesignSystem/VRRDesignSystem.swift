// VRRDesignSystem
// A token-driven, SOLID-architected SwiftUI design system
// for iOS 18+ and macOS 15+.
//
// Architecture:
// ┌─────────────────────────────────────────────────┐
// │  VRRTheme (Composition Protocol)                │
// │  ┌───────────┐ ┌──────────────┐ ┌───────────┐  │
// │  │  Colors   │ │ Typography   │ │  Spacing  │  │
// │  └───────────┘ └──────────────┘ └───────────┘  │
// │  ┌───────────┐ ┌──────────────┐ ┌───────────┐  │
// │  │  Radius   │ │  Elevation   │ │ Animation │  │
// │  └───────────┘ └──────────────┘ └───────────┘  │
// │  ┌───────────┐                                  │
// │  │  Opacity  │                                  │
// │  └───────────┘                                  │
// └─────────────────────────────────────────────────┘
//
// Each token domain is a standalone protocol (Interface Segregation).
// VRRTheme composes them into a single injectable dependency.
// The Environment key allows SwiftUI injection at any level.
//
// Usage:
//   ContentView()
//       .vrrTheme(MyAppTheme())
//

@_exported import SwiftUI
