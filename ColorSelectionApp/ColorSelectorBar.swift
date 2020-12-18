//
//  ColorSelectorBar.swift
//  ColorSelectionApp
//
//  Created by User on 16.12.2020.
//

import SwiftUI

struct ColorSelectorBar: View {
    @Binding var value: Double
    @State var stringValue: String
    let color: Color
    
    @State private var isVisibleAlert = false
    
    var body: some View {
        HStack(spacing: 15) {
            Text("\(lround(value))")
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
                .onChange(of: stringValue) { enteredString in

                    // Фильтрация нецифровых символов
                    let filteredString = enteredString
                        .filter { "0123456789".contains($0) }
                    stringValue = filteredString

                    // Если строка пустая, то отображается "0"
                    guard stringValue != "" else {
                        value = 0
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

struct ColorSelectorBar_Previews: PreviewProvider {
    @State static var sliderValue = Double.random(in: 0...255)
    
    static var previews: some View {
        ZStack {
            Color(.gray)
            ColorSelectorBar(value: $sliderValue,
                             stringValue: "\(lround(sliderValue))",
                         color: .orange)
        }
    }
}
