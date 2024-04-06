//
//  Dice.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import Foundation

@Observable
class DiceSetting: Codable, Equatable{
    static func == (lhs: DiceSetting, rhs: DiceSetting) -> Bool {
        lhs.numberOfDices == rhs.numberOfDices && rhs.numberOfSlices == lhs.numberOfSlices
    }
    
    var numberOfDices = 5
    var numberOfSlices = 6
}
