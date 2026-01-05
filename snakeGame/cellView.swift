import SwiftUI

struct cellView: View {
    typealias Point = snakeGameModel.Point
    typealias Direction = snakeGameModel.Direction

    let point: Point
    let food: Point
    let snake: Set<Point>
    let snakeHead: Point?
    let snakeTail: Point?
    let direction: Direction

    private var isSnake: Bool { snake.contains(point) }
    private var isHead: Bool { snakeHead == point }
    private var isTail: Bool { snakeTail == point }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                )

            if point == food {
                Text("🐀")
                    .font(.system(size: 24))
                    .scaleEffect(1.15)
                    .transition(.scale.combined(with: .opacity))
            } else if isSnake {
                if isHead {
                    Text("🟩")
                        .font(.system(size: 22))
                        .scaleEffect(1.12)
                        .shadow(radius: 8)
                        .rotationEffect(angle(for: direction))
                        .animation(.spring(response: 0.15, dampingFraction: 0.8), value: direction)
                } else {
                    Text("🟩")
                        .font(.system(size: 22))
                        .opacity(isTail ? 0.75 : 1.0)
                        .animation(.linear(duration: 0.12), value: isSnake)
                }
            }
        }
    }

    private func angle(for direction: Direction) -> Angle {
        switch direction {
        case .up: return .degrees(0)
        case .right: return .degrees(90)
        case .down: return .degrees(180)
        case .left: return .degrees(270)
        }
    }
}
