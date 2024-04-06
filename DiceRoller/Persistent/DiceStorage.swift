//
//  DiceStorage.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import Foundation

class DiceStorage {
    static let savePath = URL.documentsDirectory.appending(path: "savedDiceRecords")
    static func loadData() -> [DiceRecord] {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode([DiceRecord].self, from: data)
        } catch {
            return []
        }
    }

    static  func saveData(dices: [DiceRecord]) {
        do {
            let data = try JSONEncoder().encode(dices)
            try data.write(to: savePath)
        }catch {
            print("Unable to save data.")
        }
    }
}
