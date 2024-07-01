//
//  RouteViewModel.swift
//  iCity
//
//  Created by Angelos Staboulis on 1/7/24.
//

import Foundation
import SwiftUI
class RouteViewModel: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ routPathView: RoutePath) {
        path.append(routPathView)
    }
    
    func pop() {
        path.removeLast()
    }
}
