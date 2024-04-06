//
//  SettingStorage.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import Foundation

class DiceSettingStorage {
    static let savePath = URL.documentsDirectory.appending(path: "savedDiceSetting")
    static func loadData() -> DiceSetting {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode(DiceSetting.self, from: data)
        } catch {
            return DiceSetting()
        }
    }

    static  func saveData(setting: DiceSetting) {
        do {
            let data = try JSONEncoder().encode(setting)
            try data.write(to: savePath)
        }catch {
            print("Unable to save data.")
        }
    }
}
