import SwiftUI

struct ScoreView: View {
    let score: Int
    
    @State private var bump = false

    private var label: some View {
        Label("Score", systemImage: "star.fill")
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.secondary)
    }
    
    private var value: some View {
        Text("\(score)")
            .font(.system(size: 28, weight: .heavy))
            .monospacedDigit()
            .scaleEffect(bump ? 1.15 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: bump)
    }
    
    var body: some View {
        HStack {
            label
            Spacer()
            value
        }
        .scoreCardStyle()
        .onChange(of: score) { _, _ in
            triggerBump()
        }
    }
      
    private func triggerBump() {
        bump = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            bump = false
        }
    }
}


private struct ScoreCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(radius: 6)
            .padding(.horizontal)
    }
}

private extension View {
    func scoreCardStyle() -> some View {
        modifier(ScoreCardStyle())
    }
}

