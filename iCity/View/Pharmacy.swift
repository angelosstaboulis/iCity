//
//  Pharmacy.swift
//  iCity
//
//  Created by Angelos Staboulis on 8/4/24.
//

import SwiftUI
import MapKit
struct Pharmacy: View {
    @State var pharmacy:PharmacyModel
    @StateObject var pharmacyViewModel = PharmacyViewModel()
    @State var coordinate:CLLocationCoordinate2D
    var body: some View {
        VStack{
            Form{
                Section("Pharmacy Open / Details"){
                    VStack{
                        Text("Pharmacist").frame(width:300,height:45,alignment:.leading)
                        Text(pharmacy.fullname).frame(width:300,height:45,alignment:.leading)
                        Text("Address").frame(width:300,height:45,alignment:.leading)
                        Text(pharmacy.address).frame(width:300,height:45,alignment:.leading)
                        Text("Phone").frame(width:300,height:45,alignment:.leading)
                        Text(pharmacy.phone).frame(width:300,height:45,alignment:.leading)
                    }
                }
                VStack{
                    Map{
                        Marker(coordinate: coordinate) {
                            Text("Pharmacy")
                        }
                    }.onAppear(perform: {
                        Task{
                            coordinate = await Helper.shared.getCoordinates(pharmacy: pharmacy.address)
                        }
                    }).frame(width:300,height:300)
                }.frame(width:300,height:300)
            }
        }.onAppear {
            pharmacyViewModel.createPharmacy()
            pharmacy = pharmacyViewModel.fetchPharmacy()
        }
    }
}

#Preview {
    Pharmacy(pharmacy: .init(id: 0, fullname: "", address: "", phone: "", date: ""), coordinate: .init())
}
