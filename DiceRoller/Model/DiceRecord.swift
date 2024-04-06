//
//  DiceRecord.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import Foundation
struct DiceRecord: Codable, Identifiable, Equatable {
    var id = UUID()
    let rolledAt: Date
    let numberOfDices: Int
    let numberOfSlides: Int
    let diceValues: [Int]
    let allDicesCapacity: Int
    let totalRolledValue: Int
    
#if DEBUG
    static let example = DiceRecord(rolledAt: Date.now, numberOfDices: 5, numberOfSlides: 6, diceValues: [1,3,4,5,5], allDicesCapacity: 30, totalRolledValue: 18)
#endif
}
