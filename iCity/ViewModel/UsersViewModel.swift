//
//  UsersViewModel.swift
//  iCity
//
//  Created by Angelos Staboulis on 8/4/24.
//

import Foundation
import SQLite
class UsersViewModel:ObservableObject{
    func createUser(model:Users){
        DatabaseManager.shared.createUser(model: model)
    }
    func fetchUsers()->[Users]{
        return DatabaseManager.shared.fetchUsers()
    }
    func openSelected(users:Users)->Bool{
        var selected = false
        let usersData = DatabaseManager.shared.fetchUsers()
        for user in usersData{
            if users.email.count > 0 && users.password.count > 0 {
                if user.email == users.email && user.password == users.password{
                    selected = true
                    break
                }
            }
        }
        return selected
    }
}

