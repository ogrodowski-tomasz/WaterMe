//
//  LaunchScreen.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 24/11/2022.
//

import SwiftUI

struct DotView: View {
    @State var delay = 0.0
    private let size = 10.0
    @State private var scale = 0.5
    var body: some View {
        Circle()
            .frame(width: size, height: size)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.3).repeatForever().delay(delay), value: scale)
            .onAppear {
                withAnimation {
                    self.scale = 1
                }
            }
    }
}

struct LaunchScreen: View {
    
    @State private var showFirstDot = false
    @State private var showSecondDot = false
    @State private var showThirdDot = false
    
    var body: some View {
        ZStack {
            Color.custom.lightGreen.ignoresSafeArea()
            VStack(alignment: .center, spacing: 15) {
                Image("plant")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                Text("WaterMe")
                    .font(.system(.largeTitle, design: .serif, weight: .medium))
                Text("Loading your plants' data..")
                .font(.system(.title, design: .serif))
                
                HStack {
                    DotView()
                    DotView(delay: 0.1)
                    DotView(delay: 0.15)
                }
            }
            .padding(.horizontal)
//            .onAppear(perform: animateDots)
        }
    }
//    private func animateDots() {
//        for _ in 0..<4 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                withAnimation(.easeInOut(duration: 0.25)) {
//                    showFirstDot = true
//                }
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                withAnimation(.easeInOut(duration: 0.25)) {
//                    showSecondDot = true
//                }
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                withAnimation(.easeInOut(duration: 0.25)) {
//                    showThirdDot = true
//                }
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                withAnimation(.easeInOut(duration: 0.25)) {
//                    showFirstDot = false
//                    showSecondDot = false
//                    showThirdDot = false
//
//                }
//            }
//
//
//        }
//    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
