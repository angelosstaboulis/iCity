//
//  PhotoViewer.swift
//  iCity
//
//  Created by Angelos Staboulis on 1/7/24.
//

import SwiftUI

struct PhotoViewer: View {
    @State var selectedImage:Data
    var body: some View {
        VStack{
            if let getPhoto = UIImage(data: selectedImage){
                          Image(uiImage: getPhoto)
                              .resizable()
            }
        }.navigationTitle("Photo Viewer")
              .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PhotoViewer(selectedImage: .init())
}
