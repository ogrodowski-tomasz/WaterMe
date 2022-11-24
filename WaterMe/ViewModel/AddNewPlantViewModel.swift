//
//  AddNewPlantViewModel.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 24/11/2022.
//

import SwiftUI
import UIKit

class AddNewPlantViewModel: ObservableObject {
    
    let service: PlantsPersistenceServiceable
    
    init(service: PlantsPersistenceServiceable) {
        self.service = service
    }
    
    @Published var newName: String = ""
    @Published var newDesctiption: String = ""
//    var newImageData: Data? = nil
    @Published var newWateringDate: Date = Date()
    @Published var image: UIImage? 
    
    var saveButtonDisabled: Bool {
        guard !newName.isEmpty, !newDesctiption.isEmpty else {
            return true
        }
        return false
    }
    
    func performSaving() {
        var imageData: Data
        if let newImageData = image?.pngData() {
            imageData = newImageData
        } else {
            guard let defaultImageData = UIImage(named: "plant")?.pngData() else { return }
            imageData = defaultImageData
        }
        
        let plantID = UUID().uuidString

        let plant = Plant(id: plantID, name: newName, description: newDesctiption, wateringDate: newWateringDate, imageData: imageData)
        service.create(plant: plant)
        UserNotificationsService().scheduleNotification(withID: plantID, titleName: newName, notificationTriggerDate: newWateringDate)
    }
}
