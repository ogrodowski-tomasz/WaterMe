//
//  EditPlanViewModel.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import Foundation

class EditPlanViewModel: ObservableObject {
    
    let plant: Plant
    
    var newName: String
    var newDesctiption: String
    var newImageData: Data
    var newWateringDate: Date
    
    var service: PlantsPersistenceServiceable
    
    init(plant: Plant, service: PlantsPersistenceServiceable) {
        self.plant = plant
        self.service = service
        
        newName = plant.name
        newDesctiption = plant.description
        newImageData = plant.imageData
        newWateringDate = plant.wateringDate
    }
    
    func updatePlant() {
        let editedPlant = Plant(
            id: plant.id,
            name: newName,
            description: newDesctiption,
            wateringDate: newWateringDate,
            imageData: newImageData
        )
        service.update(plant: editedPlant)

        // Rescheduling notification
        UserNotificationsService().removeNotification(notificationId: plant.id)
        UserNotificationsService().scheduleNotification(withID: plant.id, titleName: editedPlant.name, notificationTriggerDate: editedPlant.wateringDate)
    }
    
    func deletePlant() {
        service.delete(plant: plant)
    }
    
}
