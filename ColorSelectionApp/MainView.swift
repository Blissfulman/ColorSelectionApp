//
//  ContentView.swift
//  ColorSelectionApp
//
//  Created by User on 14.12.2020.
//

import SwiftUI

struct MainView: View {
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0, green: 0.2884460092, blue: 0.6252598763, alpha: 1)).ignoresSafeArea()
            
            VStack(spacing: 15) {
                ColorView(red: redValue, green: greenValue, blue: blueValue)
                    .padding(.bottom, 50)
                
                ColorSelectorBar(value: $redValue,
                                 stringValue: "\(lround(redValue))",
                                 color: .red)
                ColorSelectorBar(value: $greenValue,
                                 stringValue: "\(lround(greenValue))",
                                 color: .green)
                ColorSelectorBar(value: $blueValue,
                                 stringValue: "\(lround(blueValue))",
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
