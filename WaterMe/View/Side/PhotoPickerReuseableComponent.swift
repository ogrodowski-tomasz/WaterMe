//
//  PhotoPickerReuseableComponent.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import PhotosUI
import SwiftUI

// This View is currently not used because of extension of this app to use "Camera". PhPhotosPicker doesn't support Camera yet.
// I did not delete this because of learning purposes.
struct PhotoPickerReuseableComponent: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    let completion: (Data) -> Void
    
    init(entryImageData: Data? = nil, completion: @escaping (Data) -> Void) {
        self.completion = completion
        if let entryImageData {
            self._selectedImageData = State(initialValue: entryImageData)
        }
    }
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                if let selectedImageData, let uiimage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                } else {
                    Image("plus_photo")
                        .renderingMode(.template)
                        .foregroundColor(.green)
                        .scaledToFit()
                        .clipShape(Circle())
                }
                
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        completion(data)
                    }
                }
            }
    }
}

struct PhotoPickerReuseableComponent_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerReuseableComponent(completion: { _ in })
    }
}
