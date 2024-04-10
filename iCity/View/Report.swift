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
                    Text("Type")
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
                            Text("Select a photo")
                        }.onChange(of: selectedItem) { newValue in
                            if let contentType = newValue?.supportedContentTypes.first{
                                let url = "\(UUID().uuidString).\(contentType.preferredFilenameExtension ?? "")"
                                model.report_photo = url
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
    Report(model: .init(id: 0, report_eidos: 0, report_description: "", report_fullname: "", report_email: "", report_photo: ""), selection: 0)
}
