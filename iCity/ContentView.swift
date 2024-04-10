//
//  ContentView.swift
//  iCity
//
//  Created by Angelos Staboulis on 6/4/24.
//

import SwiftUI

struct ContentView: View {
    @State var users:Users
    @StateObject var usersViewModel = UsersViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                Text("iCity").font(.largeTitle)
                VStack{
                    VStack{
                        Image("icity").resizable()
                    }.padding(27)
                    VStack{
                        Text("Email").frame(width:200,alignment: .leading)
                        TextField("Enter your Email", text: $users.email).frame(width:200,alignment: .leading).autocapitalization(.none)
                       
                    }.padding(27)
                    VStack{
                        Text("Password").frame(width:200,alignment: .leading)
                      
                        SecureField("Enter your Password", text: $users.password).frame(width:200,alignment: .center).autocapitalization(.none)
                        
                    }.padding(27)
                    VStack{
                        NavigationLink {
                            if usersViewModel.openSelected(users: users){
                                MainMenu()
                            }
                            
                        } label: {
                            Text("Login").foregroundStyle(.white)
                                
                        }.background {
                            RoundedRectangle(cornerRadius: 22.0).frame(width:300,height:45)
                                .foregroundStyle(.blue)
                        }.padding(15)
                        VStack{
                            NavigationLink {
                                Register(users: .init(id: 0, lastname: "", firstname: "", email: "", password: ""))
                            } label: {
                                Text("Register").foregroundStyle(.blue)
                            }

                           
                        }
                    }
                  
                }.frame(height:670,alignment:.center)
               
                Spacer()
            }.frame(maxWidth: .infinity)
           
           
        }
    }
}

#Preview {
    ContentView(users: .init(id: 0, lastname: "", firstname: "", email: "", password: ""))
}
