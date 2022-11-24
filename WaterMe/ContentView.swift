//
//  ContentView.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showLaunchScreen = true
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(.custom.light)
        ]
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(.custom.darkGreen)
        ]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                Home()
                    .navigationTitle("WaterMe")
            }
            LaunchScreen()
                .opacity(showLaunchScreen ? 1 : 0)
                .zIndex(showLaunchScreen ? 1 : -1)
                .animation(.easeOut, value: showLaunchScreen)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showLaunchScreen.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
