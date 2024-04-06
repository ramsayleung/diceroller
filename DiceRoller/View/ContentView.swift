//
//  ContentView.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-04.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    @State private var setting = DiceSetting()
    @State private var records = [DiceRecord]()
    
    var body: some View {
        TabView {
            DiceView(numberOfDices: $setting.numberOfDices, numberOfSides: $setting.numberOfSlices, diceRecords: $records)
                .tabItem { Label("Roll Dice", systemImage: "dice.fill") }
            
            HistoryView(records: records)
                .tabItem { Label("History", systemImage: "list.bullet") }
            
            SettingView(numberOfDices: $setting.numberOfDices, numberOfSlices: $setting.numberOfSlices)
                .tabItem { Label("Setting", systemImage: "gear") }
        }
    }
}

#Preview {
    ContentView()
}
