import SwiftUI

struct StartupSplash: View {
    @State private var scale = 0.78
    @State private var glow = false
    @State private var strike = false

    var body: some View {
        ZStack {
            AppBackground()

            Circle()
                .fill(.cyan.opacity(glow ? 0.28 : 0.08))
                .blur(radius: 95)
                .frame(width: glow ? 470 : 260)

            ZStack {
                ForEach(0..<6, id: \.self) { i in
                    ElectricStrike()
                        .stroke(.cyan.opacity(strike ? 0.55 : 0.08), style: StrokeStyle(lineWidth: 2.2, lineCap: .round, lineJoin: .round))
                        .frame(width: 110, height: 250)
                        .rotationEffect(.degrees(Double(i) * 60 + 15))
                        .offset(y: -40)
                        .scaleEffect(strike ? 1.0 : 0.72)
                        .animation(.easeInOut(duration: 0.45 + Double(i) * 0.04).repeatForever(autoreverses: true), value: strike)
                }
            }
            .blur(radius: 0.2)

            VStack(spacing: 20) {
                AptumLogoImage()
                    .frame(width: 340, height: 122)
                    .scaleEffect(scale)
                    .shadow(color: .cyan.opacity(glow ? 0.58 : 0.18), radius: glow ? 36 : 12)

                Text("Initializing electric drive")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.cyan.opacity(0.9))
            }
        }
        .onAppear {
            withAnimation(.spring(response: 1.05, dampingFraction: 0.74)) { scale = 1.0 }
            withAnimation(.easeInOut(duration: 0.75).repeatForever(autoreverses: true)) { glow = true }
            strike = true
        }
    }
}

struct ElectricStrike: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX + rect.width * 0.06, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.midX - rect.width * 0.20, y: rect.height * 0.28))
        p.addLine(to: CGPoint(x: rect.midX + rect.width * 0.10, y: rect.height * 0.28))
        p.addLine(to: CGPoint(x: rect.midX - rect.width * 0.08, y: rect.height * 0.58))
        p.addLine(to: CGPoint(x: rect.midX + rect.width * 0.25, y: rect.height * 0.58))
        p.addLine(to: CGPoint(x: rect.midX - rect.width * 0.04, y: rect.maxY))
        return p
    }
}
