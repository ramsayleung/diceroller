//
//  Dice.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import Foundation

@Observable
class DiceSetting: Codable {
    var numberOfDices = 5
    var numberOfSlices = 6
}
