//
//  AddNewPlant.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import PhotosUI
import SwiftUI

struct AddNewPlant: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: AddNewPlantViewModel
        
    @State private var showAlert = false
    @State private var showImageSourceActionSheet = false
    @State private var showPhotosPicker = false
    @State private var showCamera = false
    
    init(persistenceService: PlantsPersistenceServiceable) {
        self._viewModel = StateObject(wrappedValue: AddNewPlantViewModel(service: persistenceService))
        requestGalleryAccess()
    }
        
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Text(NSLocalizedString("Add New Plant", comment: ""))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(LocalizedStringKey("Save")) {
                    viewModel.performSaving()
                    dismiss()
                }
                .disabled(viewModel.saveButtonDisabled)
            }
            
            Button {
                showImageSourceActionSheet.toggle()
            } label: {
//                if let selectedImageData = viewModel.newImageData, let uiimage = UIImage(data: selectedImageData)
                if let uiimage = viewModel.image {
//                    Image(uiImage: uiimage)
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipShape(Circle())
                } else {
                    Image("plus_photo")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.custom.light)
                        .frame(height: 250)
                        
                }
            }
            .frame(height: 300)
            .sheet(isPresented: $showCamera) {
                CustomImagePickerView(pickerType: .camera) { image in
                    viewModel.image = image
//                    viewModel.newImageData = data
                }
            }
            .sheet(isPresented: $showPhotosPicker) {
                CustomImagePickerView(pickerType: .photoLibrary) { image in
                    viewModel.image = image
//                    viewModel.newImageData = data
                }
            }
            CustomTextField(title: "Plant Name", text: $viewModel.newName)
            CustomTextField(title: "Plant Description", text: $viewModel.newDesctiption)
            
            DatePicker("Watering date reminder", selection: $viewModel.newWateringDate, displayedComponents: .hourAndMinute)
            
        }
        .foregroundColor(.custom.light)
        .padding(.top, 30)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.custom.darkGreen.ignoresSafeArea())
        .alert("Error!", isPresented: $showAlert) {
            Button {
                goToAppPrivacySettings()
            } label: {
                Text("Change Privacy Settings")
            }
        } message: {
            Text("You denided access to library which is essential!")
        }
        .confirmationDialog("Image source", isPresented: $showImageSourceActionSheet) {
            Button {
                // Trigger library
                showPhotosPicker.toggle()
            } label: {
                Text("Library")
            }
            Button {
                // Trigger camera
                showCamera.toggle()
            } label: {
                Text("Camera")
            }
            
        }
        
    }
    
    
    
    func requestGalleryAccess() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            if status == .denied {
                showAlert = true
            }
        }
    }
    
    func goToAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else {
            assertionFailure("Not able to open App privacy settings")
            return
        }
        UIApplication.shared.open(url)
    }
}

struct AddNewPlant_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
