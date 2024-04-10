//
//  Utilities.swift
//  iCity
//
//  Created by Angelos Staboulis on 10/4/24.
//

import SwiftUI

struct Utilities: View {
    @State var menus = ["Emergency Phones","List Reports"]
    var body: some View {
        NavigationStack{
            List(menus,id:\.self){item in
                if item == "Emergency Phones"{
                    NavigationLink {
                        Phones()
                    } label: {
                        Text(item)
                    }
                }
                if item == "List Reports"{
                    NavigationLink {
                        ListReports()
                    } label: {
                        Text(item)
                    }
                }

            }
        }
    }
}

#Preview {
    Utilities()
}
