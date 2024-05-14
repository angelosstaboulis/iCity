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
    @State private var selectedItem: PhotosPickerItem? = nil
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
                    Text("Please Select Type")
                }
                    Text("Selected Type")
                    if model.report_eidos == 1{
                        Text("Οδοποία - Συντήρηση")
                    }
                    if model.report_eidos == 2{
                        Text("Ηλεκτροφωτισμός")
                    }
                    if model.report_eidos == 3{
                        Text("Καθαριότητα - Ανακκύλωση")
                    }
                    if model.report_eidos == 4{
                        Text("Υδρευση - Αποχετευση")
                    }
                    if model.report_eidos == 5{
                        Text("Πυρκαγιά - Πλημμύρα - Σεισμός")
                    }
                    Text("FullName")
                    TextField("FullName", text: $model.report_fullname)
                    Text("Email")
                    TextField("Email", text: $model.report_email).autocapitalization(.none)
                    Text("Description")
                    TextField("Description", text: $model.report_description)
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Text("Please Select a photo")
                        }.onChange(of: selectedItem) { oldValue, newValue in                              
                                Task{
                                    if let contentType = newValue?.supportedContentTypes.first{
                                        let url = "\(UUID().uuidString).\(contentType.preferredFilenameExtension ?? "")"
                                        model.report_photo = url
                                        
                                    }
                                    if let selectedImage = try await selectedItem?.loadTransferable(type: Data.self){
                                        model.report_image = selectedImage
                                        
                                    }
                                }
                        
                        }
                    VStack{
                        Text("Photo Path").frame(width:310,height:45,alignment:.leading).font(.system(size: 16.0))
                        Text(model.report_photo).frame(width:350,height:45,alignment:.leading).font(.system(size: 14.0))
                    }.frame(width:450,height:45)
                        NavigationStack{
                            NavigationLink {
                                DetailsPhoto(photo:model.report_image)
                            } label: {
                                Text("Show Photo")
                            }

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

#Preview {
    Report(model: .init(id: 0, report_eidos: 0, report_description: "", report_fullname: "", report_email: "", report_photo: "", report_image: .init()), selection: 0)
}
