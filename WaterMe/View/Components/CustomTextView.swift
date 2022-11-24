//
//  CustomTextView.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import SwiftUI


struct CustomTextView: View {
    @Binding var text: String
    let placeholder: String
    
    @FocusState private var isTextViewFocused: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .focused($isTextViewFocused)
                .onSubmit {
                    isTextViewFocused = false
                    hideKeyboard()
                }
                

            Text(placeholder)
                .fontWeight(.light)
                .padding(7)
                .hidden(!text.isEmpty)
                .allowsHitTesting(false)
            
        }
        .foregroundColor(.custom.light)
        .padding(8)
        .background { Color.textFieldGray }
        .cornerRadius(10)

    }
}

struct CustomTextView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPlant(persistenceService: PlantsPersistenceService())
    }
}
