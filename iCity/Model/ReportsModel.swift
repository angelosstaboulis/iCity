//
//  ReportsModel.swift
//  iCity
//
//  Created by Angelos Staboulis on 9/4/24.
//

import Foundation
import SwiftUI
struct ReportsModel:Hashable{
    var id:Int64
    var report_eidos:Int64
    var report_description:String
    var report_fullname:String
    var report_email:String
    var report_photo:String
    var report_image:Data
    func hash(into hasher: inout Hasher) {
        
    }
}
