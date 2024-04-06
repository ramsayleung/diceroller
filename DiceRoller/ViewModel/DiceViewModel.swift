//
//  DiceViewModel.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import Foundation

extension DiceView {
    @Observable
    class DiceViewModel {
        var areDicesFalling = false
        var rollingDices = [Int]()
        var diceValues = [Int]()
        var rollAt = Date.now
        var fallingOffsetY = 250.0
        var elapsedTime = 0
        
        let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        let animationDuration = 3.0
        
        func rollingDice(onFinish: () -> Void) {
            guard areDicesFalling else { return }
            guard isAnimiationRunning() else { return }
            
            rollingDices.shuffle()
            for i in 0..<diceValues.count {
                diceValues[i] = rollingDices.randomElement() ?? 1
            }
            
            elapsedTime += 1
            if !isAnimiationRunning() {
                onFinish()
            }
        }
        
        func isAnimiationRunning() -> Bool {
            return Double(elapsedTime) < animationDuration
        }
        
        func roll() {
            areDicesFalling.toggle()
            rollAt = Date.now
            elapsedTime = 0
        }
        
        func totalRolledValue() -> Int {
            diceValues.reduce(0, +)
        }
        
        static func populateDice(numberOfDices: Int, numberOfSides: Int) -> [Int] {
            return (0...numberOfDices).map{_ in Int.random(in: 1...numberOfSides)}
        }
    }
}
