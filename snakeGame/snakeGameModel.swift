//
//  snakeGameModel.swift
//  snakeGame
//
//  Created by Xavier Pedrals Camprubí on 5/12/25.
//

import Foundation

struct snakeGameModel{
    private var snake: [Point] //quan importa l'ordre es fa servir com Array
    var snakeSet: Set<Point> { Set(snake) } //quan importa la pertinença es fa servir com a Set
    var snakeHead: Point? { snake.first }
    var snakeTail: Point? { snake.last }
    
    private(set) var food: Point
    private(set) var direction = Direction.up
    private(set) var score: Int = 0
    private(set) var isGameOver: Bool = false

    var maxX: Int
    var maxY: Int
    
    enum Direction: String {
        case up, down, left, right
    }
    
    init(columns: Int, rows: Int){	
        maxX = columns
        maxY = rows

        snake = []
        food = Point(x: 0, y: 0)
        
        initSnake()
        food = generateFood()
    }
    
    struct Point: Hashable, CustomStringConvertible {
        var x: Int
        var y: Int
        var description: String {
            "Point(x: \(x), y: \(y))"
        }
    }
    
    mutating func initSnake(){
        for index in 0..<3 {
            snake.append(
                Point(x: maxX / 2, y: maxY / 2 + index)
            )
        }
    }
    
    mutating func moveSnake(_ direction: Direction) -> Bool {
        guard let head = snake.first else {return true}
        var newHead = head
        
        switch direction {
        case .up:
            if head.y == 0 { newHead.y = maxY - 1 } else { newHead.y -= 1 }
        case .down:
            if head.y == maxY - 1 { newHead.y = 0 } else { newHead.y += 1 }
        case .right:
            if head.x == maxX - 1 { newHead.x = 0 } else { newHead.x += 1 }
        case .left:
            if head.x == 0 { newHead.x = maxX - 1} else { newHead.x -= 1 }
        }
                
        //xoc amb el propi cos
        if snakeSet.contains(newHead) {
            isGameOver = true
            return isGameOver
        } else {
            // mou el cos
            snake.insert(newHead, at: 0)
            if snake.first == food {
                food = generateFood()
                score += 1
            } else {
                snake.removeLast()
            }
        }
        return isGameOver
    }
    
    mutating func generateFood() -> Point {
        var newFood = Point(x: 0, y: 0)
        repeat {
            newFood.x = Int.random(in: 0..<maxX)
            newFood.y = Int.random(in: 0..<maxY)
        } while snakeSet.contains(newFood)
        return newFood
    }
    
    mutating func changeDirection(_ newDirection: Direction) {
        switch newDirection {
        case .up:
            if direction != .down {
                direction = .up
            }
        case .down:
            if direction != .up{
                direction = .down
            }
        case .left:
            if direction != .right {
                direction = .left
            }
        case .right:
            if direction != .left {
                direction = .right
            }
        }
    }
}
