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
                users.append(Users(id:record[0] as! Int64, lastname: String(describing:record[1]!), firstname: String(describing:record[2]!), email: String(describing:record[3]!), password: String(describing:record[4]!)))
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
                let date = String(describing:record[4]!)
                if currentDate == date{
                    pharmacy = PharmacyModel(id:record[0] as! Int64, fullname: String(describing:record[1]!), address: String(describing:record[2]!), phone: String(describing:record[3]!), date: String(describing:record[4]!))
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
                events.append(EventsModel(id: record[0] as! Int64, eventname:String(describing:record[1]!), eventdescription: String(describing:record[2]!), eventdate:String(describing:record[3]!)))
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
                reports.append(ReportsModel(id: record[0] as! Int64, report_eidos:record[1] as! Int64, report_description:  String(describing:record[2]!), report_fullname: String(describing:record[3]!), report_email: String(describing:record[4]!), report_photo: String(describing:record[5]!)))
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
