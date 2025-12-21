//
//  snakeGameViewModel.swift
//  snakeGame
//
//  Created by Xavier Pedrals Camprubí on 5/12/25.
//

import SwiftUI
import Combine

class snakeGameViewModel: ObservableObject {
    private static func createSnakeGame() -> snakeGameModel {
        return snakeGameModel(columns: 10, rows: 15)
    }
    
    // Límits temps
    private static let minSeconds: TimeInterval = 0.05
    private static let maxSeconds: TimeInterval = 0.7
    
    
    @Published private var model = createSnakeGame()
    
    private var timer: AnyCancellable?
    private var seconds = maxSeconds

    // MARK: - Accés al model per la View
    var snake: [snakeGameModel.Point] { model.snake }
    var food: snakeGameModel.Point { model.food }
    var points: Int { model.points }
    var direction: snakeGameModel.Direction { model.direction }
    var isRunning: Bool = false
    var isGameOver: Bool = false
    
    // MARK: - Intencions usuari

    func changeDirection(_ newDirection: snakeGameModel.Direction) {
        model.changeDirection(newDirection)
    }

    func startGame() {
        guard !isRunning else { return }      // evita crear 2 timers
        isRunning = true
        startTimer(snakeGameViewModel.maxSeconds)
    }

    func stopGame() {
        isRunning = false
        timer?.cancel()
        timer = nil
    }


    // MARK: - Interns

    private func startTimer(_ seconds: TimeInterval) {
        // Cancel·la l’anterior abans de crear-ne un de nou
        timer?.cancel()

        timer = Timer
            .publish(every: seconds, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    private func tick() {
        let oldLength = model.snake.count
        if model.moveSnake(model.direction){
            stopGame()
            isGameOver = true
        } else { // Si ha menjat (ha pujat punts), accelera una mica
            if oldLength < model.snake.count {
                increaseSpeed()
            }
        }
    }

    private func increaseSpeed() {
        if seconds > snakeGameViewModel.minSeconds {
            seconds -= 0.05
            startTimer(seconds)
        }
    }

}

