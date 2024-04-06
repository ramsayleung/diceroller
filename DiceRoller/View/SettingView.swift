//
//  SettingView.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import SwiftUI

struct SettingView: View {
    @Binding var setting: DiceSetting
    var body: some View {
        NavigationStack {
            Form {
                Section("Number of Dice") {
                    Text("Dices: \(setting.numberOfDices.formatted(.number))")
                        .font(.headline)
                        .padding()
                    
                    CustomSliderView(sliderValue: numberOfDicesProxy, inRange: 1...8, step: 1)
                }
                
                Section("Number of Slices") {
                    Text("Slices: \(setting.numberOfSlices)")
                        .font(.headline)
                        .padding()
                    Picker("Please choose a color", selection: $setting.numberOfSlices) {
                        ForEach([4,6,10,15,20,100], id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                }
            }
        }
    }
    
    var numberOfDicesProxy: Binding<Double> {
        Binding<Double>(
            get: {
                return Double(setting.numberOfDices)
            },
            set: {
                setting.numberOfDices = Int($0)
            }
        )
    }
    
}

#Preview {
    @State  var setting = DiceSetting()
    return SettingView(setting: $setting)
}
