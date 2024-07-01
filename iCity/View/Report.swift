//
//  Report.swift
//  iCity
//
//  Created by Angelos Staboulis on 6/4/24.
//

import SwiftUI
import PhotosUI
import Foundation
struct Report: View {
    @State var model:ReportsModel
    @State private var selectedItems:[PhotosPickerItem] = []
    @State var selectedImage:Data
    @StateObject var object = ReportsViewModel()
    @State var selection:Int64
    var body: some View {
        VStack{
            Form{
                Section("Report Problem"){
                    Menu {
                        Button {
                            model.report_eidos = 1
                            
                        } label: {
                            Text("Οδοποίια-Συντηρηση").tag(0)
                        }
                        Button {
                            model.report_eidos = 2
                            
                        } label: {
                            Text("Ηλεκτροφωτισμός").tag(1)
                        }
                        Button {
                            model.report_eidos = 3
                        } label: {
                            Text("Καθαριότητα - Ανακύκλωση").tag(1)
                        }
                        Button {
                            model.report_eidos = 4
                        } label: {
                            Text("Υδρευση - Αποχέτευση").tag(1)
                        }
                        Button {
                            model.report_eidos = 5
                        } label: {
                            Text("Πυρκαγιά - Πλημμύρα - Σεισμός").tag(1)
                        }
                       
                        
                    }
                label: {
                    Text("Type")
                }
                    Text("Selected Type")
                    if model.report_eidos == 1 {
                        Text("Οδοποίια-Συντηρηση")
                    }
                    if model.report_eidos == 2 {
                        Text("Ηλεκτροφωτισμός")
                    }
                    if model.report_eidos == 3 {
                        Text("Καθαριότητα - Ανακύκλωση")
                    }
                    if model.report_eidos == 4 {
                        Text("Υδρευση - Αποχέτευση")
                    }
                    if model.report_eidos == 5 {
                        Text("Πυρκαγιά - Πλημμύρα - Σεισμός")
                    }
                    Text("FullName")
                    TextField("FullName", text: $model.report_fullname)
                    Text("Email")
                    TextField("Email", text: $model.report_email).autocapitalization(.none)
                    Text("Description")
                    TextField("Description", text: $model.report_description)
                    PhotosPicker(
                        selection: $selectedItems,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Text("Select a photo")
                        }.onChange(of: selectedItems) { newValue in
                            Task {
                                if let item = selectedItems.first{
                                    if let image = try? await item.loadTransferable(type: Data.self) {
                                        if let contentType = item.supportedContentTypes.first{
                                            let filename = UUID().uuidString+".".appending(contentType.preferredFilenameExtension!)
                                            model.report_photo = filename
                                        }
                                        selectedImage = image
                                        
                                    }
                                }
                               
                                          
                            }
                    }
                    Text("Selected Photo")
                    Text(model.report_photo)
                    NavigationLink {
                       PhotoViewer(selectedImage: selectedImage)
                    } label: {
                        Text("Open Selected Photo")
                    }
                    Button(action: {
                        object.createReport(model: model)
                    }, label: {
                        Text("Send Report").foregroundStyle(.white)
                    }).background {
                        RoundedRectangle(cornerRadius: 22.0).frame(width:200,height:45,alignment: .center)
                            .foregroundStyle(.blue)
                    }.frame(width:300,height:45,alignment: .center)
                    
                    
                    
                    
                }
            }
            
        }
    }
}


