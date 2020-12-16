//
//  ContentView.swift
//  ColorSelectionApp
//
//  Created by User on 14.12.2020.
//

import SwiftUI

struct MainView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0, green: 0.2884460092, blue: 0.6252598763, alpha: 1)).ignoresSafeArea()
            
            VStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(Color(.sRGB,
                                red: redSliderValue / 255,
                                green: greenSliderValue / 255,
                                blue: blueSliderValue / 255,
                                opacity: 1))
                    .frame(height: 120)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 3))
                    .padding(.bottom, 50)
                
                ColorSelectorBar(value: $redSliderValue,
                                 stringValue: "\(lround(redSliderValue))",
                                 color: .red)
                ColorSelectorBar(value: $greenSliderValue,
                                 stringValue: "\(lround(greenSliderValue))",
                                 color: .green)
                ColorSelectorBar(value: $blueSliderValue,
                                 stringValue: "\(lround(blueSliderValue))",
                                 color: .blue)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
