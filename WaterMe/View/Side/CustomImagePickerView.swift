//
//  CustomImagePickerView.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import SwiftUI

struct CustomImagePickerView: View {
    let pickerType: UIImagePickerController.SourceType
    var completion: (UIImage) -> Void
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        ImageCameraPickerController(sourceType: pickerType, selectedUIImage: $selectedImage)
            .onChange(of: selectedImage) { uiimage in
                guard let uiimage = selectedImage else { return }
                completion(uiimage)
            }
    }
}

struct CameraReuseableView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImagePickerView(pickerType: .photoLibrary, completion: {_ in})
    }
}
