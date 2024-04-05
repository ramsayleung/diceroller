//
//  DiceView.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import SwiftUI
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

struct DiceView: View {
    @State private var viewModel: DiceViewModel
    @Binding var numberOfDices : Int
    @Binding var numberOfSides : Int
    
    let colors: [Color] = [.blue, .red, .green, .yellow, .orange]
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
            VStack(alignment: .center) {
                HStack {
                    Spacer() // Create space at the top for the falling effect
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 4), alignment: .center, spacing: 20){
                        ForEach(0..<numberOfDices, id: \.self) { index in
                            DiceItemView(value: index < viewModel.diceValues.count ? viewModel.diceValues[index] : 0, foregroundColor: colors[index % colors.count])
                                .rotationEffect(.degrees(viewModel.areDicesFalling ? Double.random(in: 180...360) : 0))
                                .offset(y: viewModel.areDicesFalling ? viewModel.fallingOffsetY : 0)
                                .animation(Animation.bouncy(duration: viewModel.animationDuration), value: viewModel.areDicesFalling)
                        }
                    }.padding(20)
                        .onReceive(viewModel.timer) { time in
                            viewModel.rollingDice()
                        }
                }.opacity(viewModel.areDicesFalling ? 1 : 0)
                Spacer() // Create space at the bottom for the bounce effect
                VStack {
                    Text("Total")
                        .font(.custom("Thonburi", size: 35))
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text(" \(viewModel.totalRoll()) ")
                            .font(.custom("Optima", size: 40))
                            .bold()
                            .foregroundStyle(.green)
                        
                        Text("/ \(allDicesCapacity())")
                            .font(.custom("Optima", size: 25))
                            .foregroundStyle(.white)
                    }
                }.opacity(viewModel.isAnimiationRunning() || !viewModel.areDicesFalling ? 0 : 1)
                
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
        }
        .onChange(of: numberOfDices, reset)
        .onChange(of: numberOfSides, reset)
    }
    
    
    func allDicesCapacity() -> Int {
        numberOfDices * numberOfSides
    }
    
    func reset() {
        viewModel.areDicesFalling = false
        viewModel.fallingOffsetY = 300
        viewModel.rollingDices = DiceViewModel.populateDice(numberOfDices: numberOfDices, numberOfSides: numberOfSides)
        viewModel.diceValues = Array(repeating: 0, count: numberOfDices)
    }
    
    init(numberOfDices: Binding<Int>, numberOfSides: Binding<Int>) {
        self._numberOfDices = numberOfDices
        self._numberOfSides = numberOfSides
        self.viewModel = DiceViewModel()
        self.viewModel.rollingDices = DiceViewModel.populateDice(numberOfDices: numberOfDices.wrappedValue, numberOfSides: numberOfSides.wrappedValue)
        self.viewModel.diceValues = Array(repeating: 0, count: numberOfDices.wrappedValue)
    }
}

#Preview {
    @State var numberOfDices = 4
    @State var numberOfSides = 6
    return DiceView(numberOfDices: $numberOfDices, numberOfSides: $numberOfSides)
}
