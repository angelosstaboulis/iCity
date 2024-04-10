//
//  MainMenu.swift
//  iCity
//
//  Created by Angelos Staboulis on 6/4/24.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        VStack{
            TabView{
                Report(model:.init(id: 0, report_eidos: 1, report_description: "", report_fullname: "", report_email: "", report_photo: ""), selection: 0)
                    .tabItem {
                        Image("report").resizable()
                        Text("Report")
                    }
                Pharmacy(pharmacy: .init(id: 0, fullname: "", address: "", phone: "", date: ""), coordinate: .init())
                    .tabItem {
                        Image("pharmacy").resizable()
                        Text("Pharmacy")
                    }
                Events()
                    .tabItem {
                        Image("event").resizable()
                        Text("Event")
                    }
                Utilities()
                    .tabItem {
                        Image("utilities").resizable()
                        Text("Utilities")
                    }
            }
        }.navigationTitle("iCity")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MainMenu()
}
