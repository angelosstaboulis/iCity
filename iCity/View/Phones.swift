//
//  Phones.swift
//  iCity
//
//  Created by Angelos Staboulis on 6/4/24.
//

import SwiftUI

struct Phones: View {
    var body: some View {
        VStack{
            Form{
                Section("Emergency Phones"){
                    Link(destination:URL(string:"tel://104")!, label: {
                        Text("ΕΛΠΑ-140")
                    })
                    Link(destination:URL(string:"tel://154")!, label: {
                        Text("EXPRESS SERVICE-154")
                    })
                    Link(destination:URL(string:"tel://157")!, label: {
                        Text("HELLAS SERVICE-157")
                    })
                    Link(destination:URL(string:"tel://121")!, label: {
                        Text("ΟΤΕ-121")
                    })
                    Link(destination:URL(string:"tel://125")!, label: {
                        Text("ΔΕΗ-125")
                    })
                    Link(destination:URL(string:"tel://199")!, label: {
                        Text("Πυροσβεστική-199")
                    })
                    Link(destination:URL(string:"tel://100")!, label: {
                        Text(" ΕΛ.ΑΣ - Άμεση Δράση - 100")
                    })
                }
            }
            
            
            
        }.navigationTitle("iCity")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    Phones()
}
