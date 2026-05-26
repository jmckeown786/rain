import SwiftUI

enum BrandPalette {
    static let ink = Color(hex: 0x03072C)
    static let midnight = Color(hex: 0x071052)
    static let panel = Color(hex: 0x0B1763)
    static let panelSoft = Color(hex: 0x102A8E)
    static let rainBlue = Color(hex: 0x326BFF)
    static let glowBlue = Color(hex: 0xDCEAFF)
    static let cyan = Color(hex: 0x7BB8FF)
    static let gold = Color(hex: 0xEAD37A)
    static let mint = Color(hex: 0x9FC9FF)
    static let coral = Color(hex: 0xF18B7D)
    static let clay = Color(hex: 0xB99065)
    static let white = Color.white
    static let text = Color(hex: 0xF7FAFF)
    static let textSoft = Color(hex: 0xC6D8F7)
    static let textMuted = Color(hex: 0x8298C9)
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

extension LinearGradient {
    static let rainSurface = LinearGradient(
        colors: [BrandPalette.panel.opacity(0.96), BrandPalette.panelSoft.opacity(0.72)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let rainAction = LinearGradient(
        colors: [BrandPalette.glowBlue, Color(hex: 0x8FBCFF)],
        startPoint: .leading,
        endPoint: .trailing
    )
}
