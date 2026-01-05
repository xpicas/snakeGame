import SwiftUI

struct StartStopView: View {
    let isRunning: Bool
    let isGameOver: Bool
    let action: () -> Void
    let restartGame: () -> Void

    private var label: some View {
        Text(isRunning ? "STOP" : "START")
            .font(.system(size: 22, weight: .bold))
            .transition(.opacity.combined(with: .scale))
    }
    
    private var backgroundColor: Color {
        isRunning ? .red : .blue
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if isGameOver {
                Button("RESTART") {
                    restartGame()
                }
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            } else {
                Button(action: action) {
                    label
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .animation(.easeInOut(duration: 0.15), value: isRunning)
            }
        }
        .animation(.easeInOut(duration: 0.15), value: isGameOver)
    }
}


