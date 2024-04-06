//
//  ContentView.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-04.
//

import SwiftUI

struct ContentView: View {
    @State private var setting = DiceSetting()
    @State private var records = [DiceRecord]()
    
    var body: some View {
        TabView {
            DiceView(numberOfDices: $setting.numberOfDices, numberOfSides: $setting.numberOfSlices, diceRecords: $records)
                .tabItem { Label("Roll Dice", systemImage: "dice.fill") }
            
            HistoryView(records: records)
                .tabItem { Label("History", systemImage: "list.bullet") }
            
            SettingView(setting: $setting)
                .tabItem { Label("Setting", systemImage: "gear") }
        }
        .onAppear(perform: loadData)
        .onChange(of: records, saveData)
        .onChange(of: setting.numberOfDices, saveSetting)
        .onChange(of: setting.numberOfSlices, saveSetting)
    }
    
    func loadData() {
        records = DiceStorage.loadData()
        setting = DiceSettingStorage.loadData()
    }
    
    func saveData() {
        DiceStorage.saveData(dices: records)
    }
    
    func saveSetting() {
        print("\(setting.numberOfDices) x \(setting.numberOfSlices)")
        DiceSettingStorage.saveData(setting: setting)
    }

}

#Preview {
    ContentView()
}
