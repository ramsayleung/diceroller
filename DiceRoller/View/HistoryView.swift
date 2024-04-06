//
//  HistoryView.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import SwiftUI

struct HistoryView: View {
    let records: [DiceRecord]
    var body: some View {
        NavigationStack {
            List(records){ dice in
                NavigationLink {
                    DiceRecordView(dice: dice)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(dice.numberOfDices) dices x \(dice.numberOfSlides) sides")
                                .padding(.vertical, 5)
                            
                            Text(dice.rolledAt.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("\(dice.totalRolledValue)")
                            .font(.largeTitle)
                            .foregroundStyle(.green)
                        
                        Text("/ \(dice.allDicesCapacity)")
                            .font(.title2)
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryView(records: [DiceRecord.example])
}
