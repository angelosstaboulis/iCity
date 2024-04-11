//
//  Helper.swift
//  iCity
//
//  Created by Angelos Staboulis on 8/4/24.
//

import Foundation
import MapKit
class Helper{
    static let shared = Helper()
    private init(){}
    func getDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return  dateFormatter.string(from: Date())
    }
    func createDate(date:String)->Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yy"
        guard let newDate = dateFormatter.date(from: date) else {
            return 0
        }
        return Calendar.current.component(.day, from: newDate)
    }
    func getCoordinates(pharmacy:String) async -> CLLocationCoordinate2D{
        return await withCheckedContinuation { continuation in
            let address = CLGeocoder()
            let addressNew = pharmacy
            var coordinateLocation = CLLocation()
            address.geocodeAddressString(addressNew) { placemark, error in
                if let location = placemark?.first?.location{
                   coordinateLocation = location
                }
                let coordinate = CLLocationCoordinate2D(latitude: coordinateLocation.coordinate.latitude, longitude: coordinateLocation.coordinate.longitude)
                continuation.resume(returning: coordinate)
            }
        }
        
    }
    func createArray()->[EventArray]{
        var days:[EventArray] = []
        let viewModel = EventsViewModel()
        let events = viewModel.fetchEvents()
        var eventCounter = 0
        var date:[EventArray] = []
        for item in 0..<getLastDay(){
                days.append(.init(number: item+1, colored: false))
        }
        for _ in 0..<getLastDay(){
            if eventCounter < events.count{
                date.append(.init(number: createDate(date:events[eventCounter].eventdate), colored: true))
                eventCounter = eventCounter + 1
            }
            
        }
        for item in 0..<getLastDay(){
            for subitem in 0..<date.count{
                if item == date[subitem].number {
                    days.remove(at: item-1)
                    days.insert(.init(number: date[subitem].number, colored: true), at: item-1)
                    
                }
            }
            
            
        }
        return days
    }
    func getDateCurrent()->String{
        var dateCurrent:String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd-MMMM-yyyy"
        dateCurrent = dateFormatter.string(from: Date())
        return dateCurrent
    }
    func createSelectedDay()->Int{
        return Calendar.current.component(.day, from: Date())
    }
    func getLastDay()->Int{
        guard let lastDay =  Calendar.current.range(of: .day, in: .month, for: Date()) else {
            return 0
        }
        return lastDay.upperBound - 1
    }
}
