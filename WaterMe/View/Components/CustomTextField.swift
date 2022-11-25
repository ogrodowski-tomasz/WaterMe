//
//  CustomTextField.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import SwiftUI

struct CustomTextField: View {
    let title: LocalizedStringKey
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text, prompt: Text(title))
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.textFieldGray)
            }
            .foregroundColor(.white)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(title: "Plant description", text: .constant(""))
    }
}
