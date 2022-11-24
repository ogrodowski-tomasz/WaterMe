//
//  PlantsViewModel.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import Combine
import Foundation

class PlantsViewModel: ObservableObject {
    
    @Published var plants = [Plant]()
    
    private var service: PlantsPersistenceServiceable
    private var cancellables = Set<AnyCancellable>()
    
    init(service: PlantsPersistenceServiceable = PlantsPersistenceService()) {
        self.service = service
        addCoreDataSubscribtion()
    }
    
    private func addCoreDataSubscribtion() {
        service.fetchedEntitiesSubject
            .sink { _ in
            } receiveValue: { [weak self] fetchedEntities in
                print("DEBUG: Fetched \(fetchedEntities.count) new Entities")
                var plants = [Plant]()
                fetchedEntities.forEach { entity in
//                    #warning(" handle isWatered here")
                    // Tutaj powinna się odbyć permutacja wartości isWatered w zależności od tego jaka jest godzina
                    let plant = Plant(id: entity.id ?? "", name: entity.name ?? "", description: entity.plantDescription ?? "", wateringDate: entity.wateringDate ?? Date(), imageData: entity.imageData ?? Data())
                    plants.append(plant)
                }
                self?.plants = plants
            }
            .store(in: &cancellables)
    }
    
    func addPlant(plant: Plant) {
        service.create(plant: plant)
    }
    
    func updatePlant(plant: Plant) {
        // TODO: Update plant in service
    }

    func providePersistenceService() -> PlantsPersistenceServiceable {
        return service
    }
    
}
