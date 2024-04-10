//
//  EventsViewModel.swift
//  iCity
//
//  Created by Angelos Staboulis on 9/4/24.
//

import Foundation
import SQLite
class EventsViewModel:ObservableObject{
    func fetchEvents()->[EventsModel]{
        return DatabaseManager.shared.fetchEvents()
    }
}
