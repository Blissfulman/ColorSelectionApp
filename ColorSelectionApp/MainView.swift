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
    
    @State private var redTextValue = ""
    @State private var greenTextValue = ""
    @State private var blueTextValue = ""
    
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
                
                ColorSlider(value: $redSliderValue,
                            stringValue: $redTextValue,
                            color: .red)
                ColorSlider(value: $greenSliderValue,
                            stringValue: $greenTextValue,
                            color: .green)
                ColorSlider(value: $blueSliderValue,
                            stringValue: $blueTextValue,
                            color: .blue)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    @Binding var stringValue: String
    let color: Color
    
    @State private var isVisibleAlert = false
    
    var body: some View {
        let roundedStringValue = "\(lround(value))"
        
        HStack(spacing: 15) {
            Text(roundedStringValue)
                .foregroundColor(.white)
                .frame(width: 33, alignment: .leading)
            
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
                .onChange(of: value) { newValue in
                    stringValue = "\(lround(newValue))"
                }
            
            TextField("", text: $stringValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)
                .onAppear {
                    stringValue = roundedStringValue
                }
                .onChange(of: stringValue) { enteredString in
                    
                    // Фильтрация нецифровых символов
                    let filteredString = enteredString
                        .filter { "0123456789".contains($0) }
                    stringValue = filteredString
                    
                    // Если строка пустая, то отображается "0"
                    guard stringValue != "" else {
                        value = 0
                        stringValue = "0"
                        return
                    }
                    
                    guard
                        let newValue = Double(filteredString),
                        newValue <= 255 else {
                        
                        // Если число больше 255
                        value = 0
                        stringValue = "0"
                        isVisibleAlert = true
                        return
                    }
                    
                    // Введено корректное значение
                    value = newValue
                }
                .alert(isPresented: $isVisibleAlert) {
                    Alert(title: Text("Некорректное значение"),
                          message: Text("Введите значение от 0 до 255"))
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
