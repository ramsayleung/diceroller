//
//  DiceRecordView.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import SwiftUI

struct DiceRecordView: View {
    let dice: DiceRecord
    
    let colors: [Color] = [.blue, .red, .green, .yellow, .orange]
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
            VStack(alignment: .center) {
                DiceTitleView(numberOfSides: dice.numberOfSlides)
                
                HStack {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 4), alignment: .center, spacing: 20){
                        ForEach(0..<dice.numberOfDices, id: \.self) { index in
                            DiceItemView(value: dice.diceValues[index], foregroundColor: colors[index % colors.count])
                        }
                    }.padding(20)
                }
                
                Spacer() // Create space at the top for the falling effect
                
                RolledDiceValueView(totalRolledValue: dice.totalRolledValue, allDicesCapacity: dice.allDicesCapacity)
            }
            .padding()
        }
    }
}

#Preview {
    DiceRecordView(dice: DiceRecord.example)
}
