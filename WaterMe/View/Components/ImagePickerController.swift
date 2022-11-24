//
//  ImagePickerController.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import SwiftUI
import UIKit

// This implementation was based on article on this list:
// https://www.appcoda.com/swiftui-camera-photo-library/

struct ImageCameraPickerController: UIViewControllerRepresentable {
 
    var sourceType: UIImagePickerController.SourceType
    
    @Binding var selectedUIImage: UIImage?

    @Environment(\.dismiss) var dismiss
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageCameraPickerController>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImageCameraPickerController>) {
 
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImageCameraPickerController
     
        init(_ parent: ImageCameraPickerController) {
            self.parent = parent
        }
        
        
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            if let uiiimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedUIImage = uiiimage.fixedOrientation()
            }
     
            parent.dismiss()
        }
    }
    
}
