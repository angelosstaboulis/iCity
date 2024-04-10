//
//  ReportsModel.swift
//  iCity
//
//  Created by Angelos Staboulis on 9/4/24.
//

import Foundation

struct ReportsModel:Hashable{
    var id:Int64
    var report_eidos:Int64
    var report_description:String
    var report_fullname:String
    var report_email:String
    var report_photo:String
    func hash(into hasher: inout Hasher) {
        
    }
}
