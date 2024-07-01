//
//  ContentView.swift
//  iCity
//
//  Created by Angelos Staboulis on 6/4/24.
//

import SwiftUI
import ToastUI
enum RoutePath: Int, Hashable {
    case MainMenu = 0
    case Register = 1
}
struct ContentView: View {
    @State var users:Users
    @State var isPresented:Bool
    @StateObject var usersViewModel = UsersViewModel()
    @EnvironmentObject var routerViewModel:RouteViewModel
    var body: some View {
        NavigationStack(path: $routerViewModel.path){
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
                        Button {
                            if usersViewModel.openSelected(users: users){
                                routerViewModel.push(.MainMenu)
                            }else{
                                isPresented = true
                            }
                        } label: {
                            Text("Login").foregroundStyle(.white)
                        }.background {
                            RoundedRectangle(cornerRadius: 22.0).frame(width:300,height:45)
                                .foregroundStyle(.blue)
                        }.padding(15)
                            .toast(isPresented: $isPresented) {
                                ToastView {
                                    Text("Wrong Credentials!!!!!")
                                    Button {
                                        isPresented.toggle()
                                    } label: {
                                        Text("OK")
                                    }

                                } label: {
                                    
                                }

                        }
                        VStack{
                            Button {
                                routerViewModel.push(.Register)
                            } label: {
                                Text("Register").foregroundStyle(.blue)
                            }

                            
                            
                            
                        }
                    }
                    
                }.frame(height:670,alignment:.center)
                
                Spacer()
            }.frame(maxWidth: .infinity)
                .navigationDestination(for: RoutePath.self) { route in
                    switch route{
                    case .MainMenu:
                        MainMenu()
                    case .Register:
                        Register(users: users)
                    }
                }
        }
    }
}

#Preview {
    ContentView(users: .init(id: 0, lastname: "", firstname: "", email: "", password: ""), isPresented: false)
}
