//
//  Events.swift
//  iCity
//
//  Created by Angelos Staboulis on 6/4/24.
//

import SwiftUI
struct Events: View {
    var vGridLayout = [
        GridItem(.fixed(60)),GridItem(.fixed(55)),GridItem(.fixed(55)),GridItem(.fixed(55)),GridItem(.fixed(55))
    ]
    var body: some View {
            VStack {
                Text("Event Calendar").font(.largeTitle)
                LazyVGrid(columns:vGridLayout){
                        ForEach(Helper.shared.createArray(),id:\.self){item in
                            Text(String(describing:item.number)).foregroundStyle(item.colored == true ? .red : .black)
                                
                        }.padding(15)
                      
                }.padding(25)
            }
                
    }
}

#Preview {
    Events()
}
