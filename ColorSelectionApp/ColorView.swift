//
//  ColorView.swift
//  ColorSelectionApp
//
//  Created by User on 17.12.2020.
//

import SwiftUI

struct ColorView: View {
    let red: Double
    let green: Double
    let blue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20.0)
            .fill(Color(red: red / 255,
                        green: green / 255,
                        blue: blue / 255))
            .frame(height: 120)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 3))
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView(red: 10, green: 220, blue: 100)
    }
}
