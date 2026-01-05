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
    @State private var scoreBump = false

    var body: some View {
        VStack {
            score
            board
            startStop
        }
        .padding(.vertical)
    }

    //MARK: -Intern
    private var score: some View {
        ScoreView(score: viewModel.score)
    }
    
    private var board: some View {
        boardView(
            rows: rows,
            columns: columns,
            food: viewModel.food,
            snake: viewModel.snake,
            isGameOver: viewModel.isGameOver,
            score: viewModel.score,
            snakeHead: viewModel.snakeHead,
            snakeTail: viewModel.snakeTail,
            direction: viewModel.direction,
            onSwipe: viewModel.handleSwipe   // <- directe al VM
        )
        .animation(.spring(response: 0.18, dampingFraction: 0.95), value: viewModel.snake)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: viewModel.food)
    }
    
    private var startStop: some View {
        StartStopView(
            isRunning: viewModel.isRunning,
            isGameOver: viewModel.isGameOver,
            action: toggleGame,
            restartGame: viewModel.restartGame
        )
    }
    
    private func toggleGame() {
        viewModel.isRunning ? viewModel.stopGame() : viewModel.startGame()
    }

}


struct SnakeGameView_Previews: PreviewProvider {
    static var previews: some View {
        snakeGameView(viewModel: snakeGameViewModel())
    }
}
