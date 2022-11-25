//
//  Home.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import SwiftUI
import UserNotifications

struct Home: View {
    @State private var presentAddNewPlant = false
    
    @StateObject private var viewModel = PlantsViewModel()
    
    var body: some View {
        ZStack {
            Color.custom.darkGreen.ignoresSafeArea()
            PlantsView()
            .toolbar {
                Button {
                    presentAddNewPlant.toggle()
                } label: {
                    Label("Add New Plant", systemImage: "plus")
                        .font(.title2)
                }
                .tint(.custom.light)
            }
            .padding(.horizontal, 10)
            .padding(.top, 25)
        }
        .sheet(isPresented: $presentAddNewPlant) {
            AddNewPlant(persistenceService: viewModel.providePersistenceService())
        }
        .onAppear {
            UIApplication.shared.setStatusBarStyle(to: .lightContent)
        }
    }
    
    @ViewBuilder
    private func PlantsView() -> some View {
        if viewModel.plants.isEmpty {
            EmptyView {
                presentAddNewPlant.toggle()
            }
        } else {
            ScrollView {
                VStack {
                    ForEach(viewModel.plants) { plant in
                        NavigationLink {
                            EditPlantView(plant: plant, service: viewModel.providePersistenceService())
                        } label: {
                            PlantRowCell(plant: plant)
                        }
                    }
                    .tint(.black)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}



    // Mocked data for development
//                    ForEach(0..<10) { num in
//                        NavigationLink {
//                            Text("Plant #\(num)")
//                        } label: {
//                            PlantRowCell(plant: Plant(name: "Plant #\(num)", description: "Description of plant #\(num)", wateringDate: Date(), imageData: Data()))
//                        }
//
//                    }
