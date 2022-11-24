//
//  CustomImagePickerView.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import SwiftUI

struct CustomImagePickerView: View {
    let pickerType: UIImagePickerController.SourceType
    var completion: (Data) -> Void
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        ImageCameraPickerController(sourceType: pickerType, selectedImage: $selectedImage)
            .onChange(of: selectedImage) { image in
                guard let imageData = image?.pngData() else { return }
                completion(imageData)
            }
    }
}

struct CameraReuseableView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImagePickerView(pickerType: .photoLibrary, completion: {_ in})
    }
}
