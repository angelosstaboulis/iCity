//
//  ListReports.swift
//  iCity
//
//  Created by Angelos Staboulis on 10/4/24.
//

import SwiftUI

struct ListReports: View {
    @StateObject var object = ReportsViewModel()
    @State var list:[ReportsModel] = []
    var body: some View {
        VStack{
            List(list,id:\.self){item in
                VStack{
                    Text("FullName").frame(width:300,height:45,alignment: .leading)
                        .foregroundStyle(.blue)
                    Text(item.report_fullname).frame(width:300,height:45,alignment: .leading)
                    Text("Email").frame(width:300,height:45,alignment: .leading)
                        .foregroundStyle(.blue)
                    Text(item.report_email).frame(width:300,height:45,alignment: .leading)
                    Text("Report Category").frame(width:300,height:45,alignment: .leading)
                        .foregroundStyle(.blue)
                    if item.report_eidos == 1 {
                        Text("Οδοποίια-Συντηρηση").frame(width:300,height:45,alignment: .leading)
                    }
                    if item.report_eidos == 2 {
                        Text("Ηλεκτροφωτισμός").frame(width:300,height:45,alignment: .leading)
                    }
                    if item.report_eidos == 3 {
                        Text("Καθαριότητα - Ανακύκλωση").frame(width:300,height:45,alignment: .leading)
                    }
                    if item.report_eidos == 4 {
                        Text("Υδρευση - Αποχέτευση").frame(width:300,height:45,alignment: .leading)
                    }
                    if item.report_eidos == 5 {
                        Text("Πυρκαγιά - Πλημμύρα - Σεισμός").frame(width:300,height:45,alignment: .leading)
                    }
                    Text("Report Description").frame(width:300,height:45,alignment: .leading)
                        .foregroundStyle(.blue)
                    Text(item.report_description).frame(width:300,height:45,alignment: .leading)
                }.frame(width:400,height:445)
                
            }.onAppear {
                list = object.fetchReports()
            }.navigationTitle("iCity")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ListReports()
}
