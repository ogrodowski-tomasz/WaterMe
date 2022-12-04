//
//  EditPlantView.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import SwiftUI

struct EditPlantView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: EditPlanViewModel
    
    init(plant: Plant, service: PlantsPersistenceServiceable) {
        self._viewModel = StateObject(wrappedValue: EditPlanViewModel(plant: plant, service: service))
    }
    
    @State private var showDeletingPlantAlert = false
    @State private var showAlert = false
    @State private var showImageSourceActionSheet = false
    @State private var showPhotosPicker = false
    @State private var showCamera = false
    
    private let yOffset = 45.0 // to expand through bottom Safe Area
    
    var body: some View {
        VStack {
            Button {
                showImageSourceActionSheet.toggle()
            } label: {
                if let oldUiImage = viewModel.oldImage  {
                    // Showing old image at first
                    Image(uiImage: oldUiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                } else if let newUiImage = viewModel.updatedUiImage {
                    // Showing updated image if selected
                    Image(uiImage: newUiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                }
            }
            .sheet(isPresented: $showCamera) {
                CustomImagePickerView(pickerType: .camera) { uiimage in
                    viewModel.updatedUiImage = uiimage
                }
            }
            .sheet(isPresented: $showPhotosPicker) {
                CustomImagePickerView(pickerType: .photoLibrary) { uiimage in
                    viewModel.updatedUiImage = uiimage
                }
            }
            
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 250)
            
            
            ZStack(alignment: .top) {
                Color.custom.darkGreen.ignoresSafeArea()
                VStack(spacing: 12) {
                    
                    CustomTextField(title: "Provide new name", text: $viewModel.newName)
                    CustomTextField(title: "Provide new description", text: $viewModel.newDesctiption)
                    DatePicker("Change watering time", selection: $viewModel.newWateringDate, displayedComponents: .hourAndMinute)
                        .onTapGesture {
                            hideKeyboard()
                        }
                    
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            showDeletingPlantAlert.toggle()
                        } label: {
                            Text("Delete")
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.red.opacity(0.2))
                                }
                        }
                        
                        Button {
                            viewModel.updatePlant()
                            dismiss()
                        } label: {
                            Text("Save Changes")
                                .foregroundColor(.custom.light)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.custom.lightGreen.opacity(0.5))
                                }
                        }
                    }
                    .offset(y: -yOffset)
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top)
            }
            .cornerRadius(10)
            .offset(y: yOffset)
        }
        
        .background {
            Color.custom.lightOrange.ignoresSafeArea()
        }
        .navigationTitle(viewModel.plant.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "chevron.down")
                            .rotationEffect(.init(degrees: 90))
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("Cancel")
                            .font(.headline)
                            .fontWeight(.medium)
                    }
                }
                .tint(.custom.darkGreen)
            }
        }
        .alert("Are You sure?", isPresented: $showDeletingPlantAlert) {
            
            Button(role: .cancel, action: {}) {
                Text("Cancel")
            }
            
            Button(role: .destructive) {
                viewModel.deletePlant()
                dismiss()
            } label: {
                Text("Delete")
            }
            
        } message: {
            Text("Are you sure You want to delete ") + Text(viewModel.plant.name).bold() + Text(" ?")
        }
        .onAppear {
            UIApplication.shared.setStatusBarStyle(to: .darkContent)
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
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct EditPlantView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
