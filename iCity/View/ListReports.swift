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
                HStack{
                    Text(item.report_fullname)
                    Text(item.report_description)
                }.frame(width:400,height:45)
                 
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
