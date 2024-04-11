//
//  PharmacyViewModel.swift
//  iCity
//
//  Created by Angelos Staboulis on 8/4/24.
//

import Foundation
import SQLite
class PharmacyViewModel:ObservableObject{
    func createPharmacy(){
        DatabaseManager.shared.createPharmacy()
    }
    func fetchPharmacy()->PharmacyModel{
        return DatabaseManager.shared.fetchPharmacy()
    }
}

