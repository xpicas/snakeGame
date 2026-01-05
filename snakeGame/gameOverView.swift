import SwiftUI

struct gameOverView: View {
    let score: Int

    var body: some View {
        ZStack {
            // Overlay fosc real
            Color.black.opacity(0.55)
            
            // Flash vermell subtil (impacte visual)
            Color.red.opacity(0.18)
                .transition(.opacity)

            // Card central amb contrast garantit
            VStack(spacing: 12) {
                Text("GAME OVER")
                    .font(.system(size: 44, weight: .heavy))
                    .foregroundColor(.white)
                    .shadow(radius: 12)

                Text("Score: \(score)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white.opacity(0.95))
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 22)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
            )
        }
        // Retall del conjunt perquè encaixi amb el board
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
