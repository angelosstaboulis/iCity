//
//  DetailsPhoto.swift
//  iCity
//
//  Created by Angelos Staboulis on 14/5/24.
//

import SwiftUI

struct DetailsPhoto: View {
    var photo:Data
    var body: some View {
        VStack{
            if let getPhoto = UIImage(data: photo){
                Image(uiImage: getPhoto)
                    .resizable()
            }
        }.navigationTitle("Photo Viewer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailsPhoto(photo: .init())
}
