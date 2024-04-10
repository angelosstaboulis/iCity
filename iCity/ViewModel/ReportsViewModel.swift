//
//  ReportsViewModel.swift
//  iCity
//
//  Created by Angelos Staboulis on 9/4/24.
//

import Foundation
import SQLite
class ReportsViewModel:ObservableObject{
    func createReport(model:ReportsModel){
        DatabaseManager.shared.createReport(model: model)
    }
    func fetchReports()->[ReportsModel]{
        return DatabaseManager.shared.fetchReports()
       
    }
}

