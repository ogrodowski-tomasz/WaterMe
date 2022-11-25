//
//  EditPlanViewModel.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import Foundation
import UIKit

class EditPlanViewModel: ObservableObject {
    
    let plant: Plant
    
    var newName: String
    var newDesctiption: String
    
    var updatedUiImage: UIImage? {
        didSet {
            oldImage = nil
        }
    }
    var oldImage: UIImage?
    var newWateringDate: Date
    
    var service: PlantsPersistenceServiceable
    
    init(plant: Plant, service: PlantsPersistenceServiceable) {
        self.plant = plant
        self.service = service
        
        newName = plant.name
        newDesctiption = plant.description
        newWateringDate = plant.wateringDate
        
        if let uiimageFromOldData = UIImage(data: plant.imageData) {
            self.oldImage = uiimageFromOldData
        }
    }
    
    func updatePlant() {
        var imageData = Data()

        if let updatedUiImage = updatedUiImage, let updatedImageData = updatedUiImage.pngData() {
            imageData = updatedImageData
        } else if let oldUIImage = oldImage, let oldImageData = oldUIImage.pngData() {
            imageData = oldImageData
        }
        
        let editedPlant = Plant(
            id: plant.id,
            name: newName,
            description: newDesctiption,
            wateringDate: newWateringDate,
            imageData: imageData
        )
        
        service.update(plant: editedPlant)
        HapticManager.notification(type: .success)
        
        // Rescheduling notification
        UserNotificationsService().removeNotification(notificationId: plant.id)
        UserNotificationsService().scheduleNotification(withID: plant.id, titleName: editedPlant.name, notificationTriggerDate: editedPlant.wateringDate)
        
    }
    
    func deletePlant() {
        UserNotificationsService().removeNotification(notificationId: plant.id)
        service.delete(plant: plant)
        HapticManager.notification(type: .success)
    }
    
}
