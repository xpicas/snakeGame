import SwiftUI

struct boardView: View {
    typealias Point = snakeGameModel.Point
    typealias Direction = snakeGameModel.Direction
    
    let rows: Int
    let columns: Int
    let food: Point
    let snake: Set<Point>
    let isGameOver: Bool
    let score: Int
    let snakeHead: Point?
    let snakeTail: Point?
    let direction: Direction
    let onSwipe: (DragGesture.Value) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.12))
                .shadow(radius: 10)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: columns),
                spacing: 2
            ) {
                ForEach(0..<(rows * columns), id: \.self) { index in
                    let p = point(from: index)
                    cellView(
                        point: p,
                        food: food,
                        snake: snake,
                        snakeHead: snakeHead,
                        snakeTail: snakeTail,
                        direction: direction
                    )
                    .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding(10)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 10)
                    .onEnded(onSwipe)
            )
            
            if isGameOver {
                gameOverView(score: score)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal)
        .animation(.easeOut(duration: 0.18), value: isGameOver)
    }
    
    // rectangle index to snake.Point
    private func point(from index: Int) -> Point {
        let x = index % columns
        let y = index / columns
        return Point(x: x, y: y)
    }
}
