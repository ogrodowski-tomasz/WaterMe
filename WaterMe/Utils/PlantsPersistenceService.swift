//
//  PlantsPersistenceService.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import Combine
import CoreData
import Foundation

protocol PlantsPersistenceServiceable {
    var fetchedEntitiesSubject: CurrentValueSubject<[PlantEntity], Error> { get }
    
    func create(plant: Plant)
    func update(plant: Plant)
    func delete(plant: Plant)
}

class PlantsPersistenceService: PlantsPersistenceServiceable {
    private let container: NSPersistentContainer
    private let containerName = "PlantModel"
    private var entityName: String = "PlantEntity"
    
    var fetchedEntitiesSubject = CurrentValueSubject<[PlantEntity], Error>([])
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                print("DEBUG: Error fetching Core Data entities! ", error)
            }
            self.getEntities()
        }
    }
    
    func getEntities() {
        let request = NSFetchRequest<PlantEntity>(entityName: entityName)
        
        do {
            let fetchedEntities = try container.viewContext.fetch(request)
            fetchedEntitiesSubject.send(fetchedEntities)
//            clearContainer(entities: fetchedEntities)
        } catch {
            fetchedEntitiesSubject.send(completion: .failure(error))
        }
    }
    
    func create(plant: Plant) {
        let entity = PlantEntity(context: container.viewContext)
        entity.id = plant.id
        entity.name = plant.name
        entity.plantDescription = plant.description
        entity.wateringDate = plant.wateringDate
        entity.imageData = plant.imageData
        applyChanges()
    }
    
    func update(plant: Plant) {
        if var enitity = fetchedEntitiesSubject.value.first(where: { plantEntity in
            plantEntity.id ?? "" == plant.id
        }) {
            translate(plant: plant, entity: &enitity)
            applyChanges()
        } else {
            print("DEBUG: Cannot find this plant in container in order to update it")
        }
    }
    
    func delete(plant: Plant) {
        if let enitity = fetchedEntitiesSubject.value.first(where: { plantEntity in
            plantEntity.id ?? "" == plant.id
        }) {
            container.viewContext.delete(enitity)
            applyChanges()
        } else {
            print("DEBUG: Cannot find this plant in container in order to delete it")
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
            print("DEBUG: Successfully saved Entities!")
        } catch {
            print("DEBUG: Error saving data! ", error.localizedDescription)
        }
    }
    
    private func applyChanges() {
        save()
        getEntities()
    }
    
    private func translate(plant: Plant, entity: inout PlantEntity) {
        entity.id = plant.id
        entity.name = plant.name
        entity.plantDescription = plant.description
        entity.wateringDate = plant.wateringDate
        entity.imageData = plant.imageData
    }
    
    private func clearContainer(entities: [PlantEntity]) {
        for entity in entities {
            container.viewContext.delete(entity)
            applyChanges()
        }
        print("DEBUG: Successfully cleaned container")
    }
    
    
}
