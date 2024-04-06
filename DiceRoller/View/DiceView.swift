//
//  DiceView.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import SwiftUI

// MARK: - DiceItemView
struct DiceItemView: View {
    let value: Int
    let foregroundColor: Color
    var body: some View {
        ZStack {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
            
            Text("\(value)")
                .foregroundColor(foregroundColor)
                .font(.custom("Optima", size: 24))
                .bold()
        }
    }
}

// MARK: - RolledDiceValueView
struct RolledDiceValueView: View {
    let totalRolledValue: Int
    let allDicesCapacity: Int
    var body: some View {
        VStack {
            Text("Total")
                .font(.custom("Thonburi", size: 30))
                .bold()
                .foregroundStyle(.white)
                .padding(.vertical, 5)
            
            HStack {
                Text(" \(totalRolledValue) ")
                    .font(.custom("Optima", size: 35))
                    .bold()
                    .foregroundStyle(.green)
                Text("/ \(allDicesCapacity)")
                    .font(.custom("Optima", size: 20))
                    .foregroundStyle(.white)
            }
        }
    }
}

struct DiceTitleView: View {
    let numberOfSides: Int
    var body: some View {
        HStack(alignment: .center) {
            Text("\(numberOfSides)-sides")
                .font(.custom("Optima", size: 25))
                .bold()
            
            Image(systemName: "die.face.5")
                .resizable()
                .frame(width: 18, height: 18)
                .rotationEffect(.degrees(-30))
        }
        .padding()
        .foregroundColor(.white)
        .background(.black.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
    }
}

// MARK: - DiceView
struct DiceView: View {
    @State private var viewModel: DiceViewModel
    @Binding var numberOfDices : Int
    @Binding var numberOfSides : Int
    @Binding var records: [DiceRecord]
    
    let colors: [Color] = [.blue, .red, .green, .yellow, .orange]
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
            VStack(alignment: .center) {
                DiceTitleView(numberOfSides: numberOfSides)
                
                HStack {
                    Spacer() // Create space at the top for the falling effect
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 4), alignment: .center, spacing: 20){
                        ForEach(0..<numberOfDices, id: \.self) { index in
                            DiceItemView(value: index < viewModel.diceValues.count ? viewModel.diceValues[index] : 0, foregroundColor: colors[index % colors.count])
                                .rotationEffect(.degrees(viewModel.areDicesFalling ? Double.random(in: 180...360) : 0))
                                .offset(y: viewModel.areDicesFalling ? viewModel.fallingOffsetY : 0)
                                .animation(Animation.bouncy(duration: viewModel.animationDuration), value: viewModel.areDicesFalling)
                        }
                    }
                    .padding(20)
                    .onReceive(viewModel.timer) { time in
                        viewModel.rollingDice() {
                            let diceRecord = DiceRecord(rolledAt: viewModel.rollAt, numberOfDices: numberOfDices, numberOfSlides: numberOfSides, diceValues: viewModel.diceValues, allDicesCapacity: allDicesCapacity(), totalRolledValue: viewModel.totalRolledValue())
                            records.append(diceRecord)
                        }
                    }
                }.opacity(viewModel.areDicesFalling ? 1 : 0)
                Spacer() // Create space at the bottom for the bounce effect
                
                RolledDiceValueView(totalRolledValue: viewModel.totalRolledValue(), allDicesCapacity: allDicesCapacity())
                    .opacity(viewModel.isAnimiationRunning() || !viewModel.areDicesFalling ? 0 : 1)
                
                Button {
                    viewModel.roll()
                } label: {
                    HStack(alignment: .center) {
                        Image(systemName: "die.face.5")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .rotationEffect(.degrees(-30))
                        Text("ROLL")
                            .font(.custom("Optima", size: 25))
                            .bold()
                    }
                    .padding(.horizontal, 13)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(Capsule())
                    .shadow(radius: 10)
                }
                .padding()
            }
            .padding(.top, 5)
        }
        .onChange(of: numberOfDices, reset)
        .onChange(of: numberOfSides, reset)
    }
    
    
    func allDicesCapacity() -> Int {
        numberOfDices * numberOfSides
    }
    
    func reset() {
        viewModel.areDicesFalling = false
        viewModel.fallingOffsetY = 250.0
        viewModel.rollingDices = DiceViewModel.populateDice(numberOfDices: numberOfDices, numberOfSides: numberOfSides)
        viewModel.diceValues = Array(repeating: 0, count: numberOfDices)
    }
    
    init(numberOfDices: Binding<Int>, numberOfSides: Binding<Int>, diceRecords: Binding<Array<DiceRecord>>) {
        self._numberOfDices = numberOfDices
        self._numberOfSides = numberOfSides
        self._records = diceRecords
        self.viewModel = DiceViewModel()
        self.viewModel.rollingDices = DiceViewModel.populateDice(numberOfDices: numberOfDices.wrappedValue, numberOfSides: numberOfSides.wrappedValue)
        self.viewModel.diceValues = Array(repeating: 0, count: numberOfDices.wrappedValue)
    }
}

#Preview {
    @State var numberOfDices = 4
    @State var numberOfSides = 6
    @State var records = [DiceRecord]()
    return DiceView(numberOfDices: $numberOfDices, numberOfSides: $numberOfSides, diceRecords: $records)
}
