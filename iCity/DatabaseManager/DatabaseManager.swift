//
//  DatabaseManager.swift
//  iCity
//
//  Created by Angelos Staboulis on 10/4/24.
//

import Foundation
import SQLite
class DatabaseInit{
    static let shared = DatabaseInit()
    private init(){}

    func initDB()->Connection{
        var db:Connection?
        do{
            let path = Bundle.main.resourcePath! + "/iCity.db"
            let pathNew = URL.applicationDirectory.path() + "iCity.db"
            if FileManager.default.fileExists(atPath: pathNew){
                db = try Connection(pathNew)
            }else{
                try FileManager.default.copyItem(atPath: path, toPath: pathNew)
                db = try Connection(pathNew)
            }
            
           
        }catch{
            debugPrint("something went wrong!!!!!"+error.localizedDescription)
        }
        return db!
    }
}
class DataFetcher{
    func fetchUsers() -> [Users] {
        var users:[Users] = []
        do{
            for record in try DatabaseInit.shared.initDB().prepare("SELECT * FROM users"){
                guard let userID = record[0] else {
                    return []
                }
                guard let lastname = record[1] else {
                    return []
                }
                guard let firstname = record[2] else {
                    return []
                }
                guard let email = record[3] else {
                    return []
                }
                guard let password = record[4] else {
                    return []
                }
                
                users.append(Users(id:userID as! Int64, lastname: String(describing:lastname), firstname: String(describing:firstname), email: String(describing:email), password: String(describing:password)))
            }
        }catch{
            debugPrint("something went wrong!!!!"+error.localizedDescription)
        }
       
        return users
    }
    
    func fetchPharmacy() -> PharmacyModel {
        var pharmacy = PharmacyModel(id: 0, fullname: "", address: "", phone: "", date: "")
        do{
            for record in try DatabaseInit.shared.initDB().prepare("SELECT * FROM pharmacy"){
                let currentDate = Helper.shared.getDate()
                var getPharmacyID:Int64 = 0
                var getFullName:String = ""
                var getAddress:String = ""
                var getPhone:String = ""
                var getDateField:String = ""
                if let pharmacyID = record[0] {
                    getPharmacyID = pharmacyID as! Int64
                }
                if let fullname = record[1] {
                    getFullName = String(describing:fullname)
                }
                if let address = record[2] {
                    getAddress = String(describing:address)
                }
                if let phone = record[3] {
                    getPhone = String(describing:phone)
                }
                if let dateField = record[4] {
                    getDateField = String(describing:dateField)
                    
                }
                debugPrint(currentDate,getDateField,getPharmacyID,getFullName,getAddress,getPhone)
                if currentDate == getDateField{
                    pharmacy = PharmacyModel(id:getPharmacyID, fullname: getFullName, address:getAddress, phone: getPhone, date: getDateField)
                }
                
                
            }
        }catch{
            debugPrint("something went wrong!!!!")
        }
        return pharmacy
    }
    
    func fetchEvents() -> [EventsModel] {
        var events:[EventsModel] = []
        do{
            for record in try DatabaseInit.shared.initDB().prepare("SELECT * FROM events"){
                guard let eventID = record[0] else {
                    return []
                }
                guard let eventname = record[1] else {
                    return []
                }
                guard let eventdescription = record[2] else {
                    return []
                }
                guard let eventdate = record[3] else {
                    return []
                }
                events.append(EventsModel(id: eventID as! Int64, eventname:String(describing:eventname), eventdescription: String(describing:eventdescription), eventdate:String(describing:eventdate)))
            }
        }catch{
            debugPrint("something went wrong!!!!")
        }
       
        return events
    }
    
    func fetchReports() -> [ReportsModel] {
        var reports:[ReportsModel] = []
        do{
            for record in try DatabaseInit.shared.initDB().prepare("SELECT * FROM reports"){
                guard let reportId = record[0] else {
                    return []
                }
                guard let reportEidos = record[1] else {
                    return []
                }
                guard let reportdescription = record[2] else {
                    return []
                }
                guard let reportfullname = record[3] else {
                    return []
                }
                guard let reportEmail = record[4] else {
                    return []
                }
                guard let reportPhoto = record[5] else {
                    return []
                }
                reports.append(ReportsModel(id: reportId as! Int64, report_eidos:reportEidos as! Int64 , report_description:  String(describing:reportdescription), report_fullname: String(describing:reportfullname), report_email: String(describing:reportEmail), report_photo: String(describing:reportPhoto)))
            }
        }catch{
            debugPrint("something went wrong!!!!")
        }
        return reports
    }
    
    
}
class DataManager{
    func createUser(model:Users){
        do{
            let table = Table("Users")
            let id = Expression<Int64>("id")
            let lastname = Expression<String>("lastname")
            let firstname = Expression<String>("firstname")
            let email = Expression<String>("email")
            let password = Expression<String>("password")
            let users = table.insert([id<-Int64.random(in: 1...100000),lastname<-model.lastname,firstname<-model.firstname,email<-model.email,password<-model.password])
            try DatabaseInit.shared.initDB().run(users)
        }catch{
            debugPrint("something went wrong!!!!")
        }
    }
    func createPharmacy(){
        do{
            let table = Table("pharmacy")
            let id = Expression<Int64>("id")
            let fullname = Expression<String>("fullname")
            let address = Expression<String>("address")
            let phone = Expression<String>("phone")
            let date = Expression<String>("date")
            debugPrint(Helper.shared.getDate())
            let pharmacy = table.insert([id<-Int64.random(in: 1...100000),fullname<-"Σταμπουλής Αγγελος",address<-"Βενιζέλου Ελευθερίου 29,Κομοτηνή",date<-Helper.shared.getDate()])
            try DatabaseInit.shared.initDB().run(pharmacy)
        }catch{
            debugPrint("something went wrong!!!!")
        }
    }
    func createReport(model:ReportsModel){
        do{
            let table = Table("reports")
            let id = Expression<Int64>("id")
            let report_eidos = Expression<Int64>("report_eidos")
            let report_description = Expression<String>("report_description")
            let report_fullname = Expression<String>("report_fullname")
            let report_email = Expression<String>("report_email")
            let report_photo = Expression<String>("report_photo")
            let report = table.insert([id<-Int64.random(in: 1...100000),report_eidos<-model.report_eidos,report_description<-model.report_description,report_fullname<-model.report_fullname,report_email<-model.report_email,report_photo<-model.report_photo])
            try DatabaseInit.shared.initDB().run(report)
        }catch{
            debugPrint("something went wrong!!!!")
        }
    }
}
class DatabaseManager{
    let fetcher = DataFetcher()
    let manager = DataManager()
    static let shared = DatabaseManager()
    private init(){}
    func createPharmacy(){
        manager.createPharmacy()
    }
    func createUser(model:Users){
        manager.createUser(model: model)
    }
    func createReport(model:ReportsModel){
        manager.createReport(model: model)
    }
    func fetchEvents()->[EventsModel]{
        return fetcher.fetchEvents()
    }
    func fetchPharmacy()->PharmacyModel{
        return fetcher.fetchPharmacy()
    }
    func fetchUsers()->[Users]{
        return fetcher.fetchUsers()
    }
    func fetchReports()->[ReportsModel]{
        return fetcher.fetchReports()
    }
    
}
