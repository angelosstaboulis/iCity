//
//  EventsModel.swift
//  iCity
//
//  Created by Angelos Staboulis on 9/4/24.
//

import Foundation
struct EventsModel:Hashable{
    var id:Int64
    var eventname:String
    var eventdescription:String
    var eventdate:String
    func hash(into hasher: inout Hasher) {
        
    }
}
