//
//  DatabaseManager.swift
//  iCity
//
//  Created by Angelos Staboulis on 10/4/24.
//

import Foundation
import SQLite
class DatabaseInit{
    func createConnection() -> Connection{
        let path = Bundle.main.resourcePath!
        
        let sourcePath = "\(path)/iCity.db"
        
        _ = copyDatabaseIfNeeded(sourcePath: sourcePath)
        
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = documents + "/iCity.db"

        return try! Connection(destinationPath)
    }
    func copyDatabaseIfNeeded(sourcePath: String) -> Bool {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = documents + "/iCity.db"
        let exists = FileManager.default.fileExists(atPath: destinationPath)
        guard !exists else { return false }
        do {
            try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath)
            return true
        } catch {
            print("error during file copy: \(error)")
            return false
        }
    }
}
class DataFetcher{
    func fetchUsers(connection:DatabaseInit) -> [Users] {
        var users:[Users] = []
        do{
            for record in try connection.createConnection().prepare("SELECT * FROM users"){
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
    
    func fetchPharmacy(connection:DatabaseInit) -> PharmacyModel {
        var pharmacy = PharmacyModel(id: 0, fullname: "", address: "", phone: "", date: "")
        do{
            for record in try connection.createConnection().prepare("SELECT * FROM pharmacy"){
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
    
    func fetchEvents(connection:DatabaseInit) -> [EventsModel] {
        var events:[EventsModel] = []
        do{
            for record in try connection.createConnection().prepare("SELECT * FROM events"){
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
    
    func fetchReports(connection:DatabaseInit) -> [ReportsModel] {
        var reports:[ReportsModel] = []
        do{
            for record in try connection.createConnection().prepare("SELECT * FROM reports"){
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
    func createUser(connection:DatabaseInit,model:Users){
        do{
            let table = Table("Users")
            let id = Expression<Int64>("id")
            let lastname = Expression<String>("lastname")
            let firstname = Expression<String>("firstname")
            let email = Expression<String>("email")
            let password = Expression<String>("password")
            let users = table.insert([id<-Int64.random(in: 1...100000),lastname<-model.lastname,firstname<-model.firstname,email<-model.email,password<-model.password])
            try connection.createConnection().run(users)
        }catch{
            debugPrint("something went wrong!!!!")
        }
    }
    func createPharmacy(connection:DatabaseInit){
        do{
            let table = Table("pharmacy")
            let id = Expression<Int64>("id")
            let fullname = Expression<String>("fullname")
            let address = Expression<String>("address")
            let phone = Expression<String>("phone")
            let date = Expression<String>("date")
            let pharmacy = table.insert([id<-Int64.random(in: 1...100000),fullname<-"Σταμπουλής Αγγελος",address<-"Βενιζέλου Ελευθερίου 29,Κομοτηνή",phone<-"694207544",date<-Helper.shared.getDate()])
            try connection.createConnection().run(pharmacy)
        }catch{
            debugPrint("something went wrong!!!!")
        }
    }
    func createReport(connection:DatabaseInit,model:ReportsModel){
        do{
            let table = Table("reports")
            let id = Expression<Int64>("id")
            let report_eidos = Expression<Int64>("report_eidos")
            let report_description = Expression<String>("report_description")
            let report_fullname = Expression<String>("report_fullname")
            let report_email = Expression<String>("report_email")
            let report_photo = Expression<String>("report_photo")
            let report = table.insert([id<-Int64.random(in: 1...100000),report_eidos<-model.report_eidos,report_description<-model.report_description,report_fullname<-model.report_fullname,report_email<-model.report_email,report_photo<-model.report_photo])
            try connection.createConnection().run(report)
        }catch{
            debugPrint("something went wrong!!!!")
        }
    }
}
class DatabaseManager{
    let connectionDB = DatabaseInit()
    let fetcher = DataFetcher()
    let manager = DataManager()
    static let shared = DatabaseManager()
    private init(){}
    func createPharmacy(){
        manager.createPharmacy(connection: connectionDB)
    }
    func createUser(model:Users){
        manager.createUser(connection: connectionDB,model: model)
    }
    func createReport(model:ReportsModel){
        manager.createReport(connection: connectionDB,model: model)
    }
    func fetchEvents()->[EventsModel]{
        return fetcher.fetchEvents(connection: connectionDB)
    }
    func fetchPharmacy()->PharmacyModel{
        return fetcher.fetchPharmacy(connection: connectionDB)
    }
    func fetchUsers()->[Users]{
        return fetcher.fetchUsers(connection: connectionDB)
    }
    func fetchReports()->[ReportsModel]{
        return fetcher.fetchReports(connection: connectionDB)
    }
    
}
