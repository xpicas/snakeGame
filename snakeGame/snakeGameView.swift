//
//  ContentView.swift
//  snakeGame
//
//  Created by Xavier Pedrals Camprubí on 5/12/25.
//
import SwiftUI

struct snakeGameView: View {
    let rows = 15
    let columns = 10

    @ObservedObject var viewModel: snakeGameViewModel
    
    var body: some View {
        VStack {
            // MARK: - Score
            HStack {
                Label("Score", systemImage: "star.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.secondary)

                Spacer()

                Text("\(viewModel.points)")
                    .font(.system(size: 28, weight: .heavy))
                    .monospacedDigit()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(radius: 6)
            .padding(.horizontal)
            
            // MARK: - Board
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.12))
                    .shadow(radius: 10)
                
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: columns),
                    spacing: 2
                ) {
                    ForEach(0..<(rows * columns), id: \.self) { index in
                        let p = point(from: index)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                                )
                            
                            // Menjar amb pulsació
                            if p == viewModel.food {
                                Text("🐀")
                                    .font(.system(size: 24))
                                    .scaleEffect(1.15)
                                    .symbolEffect(.pulse) // iOS 17+, si no tens iOS 17, treu aquesta línia
                            } else if viewModel.snake.contains(p) {
                                Text("🟩")
                                    .font(.system(size: 23))
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding(10)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 10)
                        .onEnded { value in
                            handleSwipe(value)
                        }
                )
                // Animació suau quan canvia la serp
                .animation(.linear(duration: 0.8), value: viewModel.snake)
                
                // MARK: - GAME OVER overlay (amb animació)
                if viewModel.isGameOver {
                    Color.black.opacity(0.55)
                        .cornerRadius(20)
                        .transition(.opacity)

                    VStack(spacing: 12) {
                        Text("GAME OVER")
                            .font(.system(size: 44, weight: .heavy))
                            .foregroundColor(.white)
                            .shadow(radius: 12)

                        Text("Punts: \(viewModel.points)")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white.opacity(0.9))

                    }
                    .padding()
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal)
            .animation(.easeOut(duration: 0.18), value: viewModel.isGameOver)

            // MARK: - Start / Stop button
            Button(viewModel.isRunning ? "STOP" : "START") {
                viewModel.isRunning ? viewModel.stopGame() : viewModel.startGame()
            }
            .font(.system(size: 22, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding()
            .background(viewModel.isRunning ? Color.red : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(16)
            .padding(.horizontal)
        }
        .padding(.vertical)
    }

    //MARK: -Intern
    // rectangle index to snake.Point
    private func point(from index: Int) -> snakeGameModel.Point {
        let x = index % columns
        let y = index / columns
        return snakeGameModel.Point(x: x, y: y)
    }
       
    private func handleSwipe(_ value: DragGesture.Value) {
        let dx = value.translation.width
        let dy = value.translation.height

        // Decideix si el moviment és horitzontal o vertical
        if abs(dx) > abs(dy) {
            // Horitzontal
            if dx > 0 {
                viewModel.changeDirection(.right)
            } else {
                viewModel.changeDirection(.left)
            }
        } else {
            // Vertical
            if dy > 0 {
                viewModel.changeDirection(.down)
            } else {
                viewModel.changeDirection(.up)
            }
        }
    }
    
}


struct SnakeGameView_Previews: PreviewProvider {
    static var previews: some View {
        snakeGameView(viewModel: snakeGameViewModel())
    }
}
