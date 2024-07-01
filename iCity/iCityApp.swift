//
//  iCityApp.swift
//  iCity
//
//  Created by Angelos Staboulis on 6/4/24.
//

import SwiftUI

@main
struct iCityApp: App {
    @StateObject private var viewModel = RouteViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(users: .init(id: 0, lastname: "", firstname: "", email: "", password: ""), isPresented: false)
                .environmentObject(viewModel)
        }
    }
}
