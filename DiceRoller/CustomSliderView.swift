//
//  CustomSlider.swift
//  DiceRoller
//
//  Created by ramsayleung on 2024-04-05.
//

import SwiftUI

struct CustomSliderView: View {
    @Binding var sliderValue: Double
    let inRange: ClosedRange<Double>
    let step: Double
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .gray, .black]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 8)
                .cornerRadius(4)
                
                Slider(
                    value: $sliderValue,
                    in: inRange,
                    step: step
                )
                .accentColor(.white)
                .padding(.horizontal, 16)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    @State var sliderValue: Double = 0.5
    return CustomSliderView(sliderValue: $sliderValue, inRange: 1...5, step: 1)
}
