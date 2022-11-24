//
//  EmptyView.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import SwiftUI

struct EmptyView: View {
    
    let onTapGesture: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Image("plant")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text("Welcome to ")
            +
            Text("WaterMe")
                .fontWeight(.black)
            Text("Add new plant to Your collection by tapping here or on + button")
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .fontWeight(.bold)
        .foregroundColor(.custom.light)
        .onTapGesture {
            onTapGesture()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(onTapGesture: {})
            .background { Color.black }
    }
}
