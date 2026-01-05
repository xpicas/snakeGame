//
//  snakeGameViewModel.swift
//  snakeGame
//
//  Created by Xavier Pedrals Camprubí on 5/12/25.
//

import SwiftUI
import Combine

class snakeGameViewModel: ObservableObject {
    typealias Point = snakeGameModel.Point
    typealias Direction = snakeGameModel.Direction
    
    private static func createSnakeGame() -> snakeGameModel {
        return snakeGameModel(columns: 10, rows: 15)
    }
    
    // Límits temps
    private static let minSeconds: TimeInterval = 0.2
    private static let maxSeconds: TimeInterval = 0.7
    
    @Published private var model = createSnakeGame()
    @Published private(set) var isRunning: Bool = false
    @Published private(set) var isGameOver: Bool = false
    
    private var timer: AnyCancellable?
    private var seconds = maxSeconds

    // MARK: - Accés al model per la View
    var snake: Set<Point> { model.snakeSet }
    var food: Point { model.food }
    var score: Int { model.score }
    var direction: Direction { model.direction }
    var snakeHead: Point? { model.snakeHead }
    var snakeTail: Point? { model.snakeTail }
    
    // MARK: - Intencions usuari

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

    func restartGame() {
        stopGame()
        model = snakeGameViewModel.createSnakeGame()
        isGameOver = false
    }
    
    func handleSwipe(_ value: DragGesture.Value) {
        let dx = value.translation.width
        let dy = value.translation.height

        if abs(dx) > abs(dy) {
            changeDirection(dx > 0 ? .right : .left)
        } else {
            changeDirection(dy > 0 ? .down : .up)
        }
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
        let oldLength = snake.count
        if model.moveSnake(model.direction){
            stopGame()
            isGameOver = true
        } else { // Si ha menjat (ha pujat punts), accelera una mica
            if oldLength < snake.count {
                increaseSpeed()
            }
        }
    }

    private func increaseSpeed() {
        if seconds > snakeGameViewModel.minSeconds {
            seconds -= 0.01
            startTimer(seconds)
        }
    }
    
    private func changeDirection(_ newDirection: Direction) {
        model.changeDirection(newDirection)
    }
}

