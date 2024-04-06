//
//  SettingView.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import SwiftUI

struct SettingView: View {
    @Binding var numberOfDices: Int
    @Binding var numberOfSlices: Int
    var body: some View {
        NavigationStack {
            Form {
                Section("Number of Dice") {
                    Text("Dices: \(numberOfDices.formatted(.number))")
                        .font(.headline)
                        .padding()
                    
                    CustomSliderView(sliderValue: numberOfDicesProxy, inRange: 1...8, step: 1)
                }
                
                Section("Number of Slices") {
                    Text("Slices: \(numberOfSlices)")
                        .font(.headline)
                        .padding()
                    Picker("Please choose a color", selection: $numberOfSlices) {
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
                return Double(numberOfDices)
            },
            set: {
                numberOfDices = Int($0)
            }
        )
    }
}

#Preview {
    @State  var numberOfSlices = 6
    @State  var numberOfDices = 5
    return SettingView(numberOfDices: $numberOfDices, numberOfSlices: $numberOfSlices)
}
