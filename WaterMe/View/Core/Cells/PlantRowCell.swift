//
//  PlantRowCell.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import SwiftUI

struct PlantRowCell: View {
    let plant: Plant
    
    var formattedWateringDate: String {
        plant.wateringDate.formatted(date: .omitted, time: .shortened)
    }
    
    var uiimageFromData: UIImage? {
        UIImage(data: plant.imageData)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 5) {
                Group {
                    if let uiimageFromData {
                        Image(uiImage: uiimageFromData)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image("plant")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(plant.name)
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Text(plant.description)
                        .font(.caption)
                        .fontWeight(.light)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    Text("Watering time: ")
                        .font(.footnote)
                    +
                    Text(formattedWateringDate)
                        .font(.footnote)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.custom.light)
        
    }
}

struct PlantRowCell_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
