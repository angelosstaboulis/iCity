//
//  Register.swift
//  iCity
//
//  Created by Angelos Staboulis on 6/4/24.
//

import SwiftUI

struct Register: View {
    @State var users:Users
    @StateObject var usersViewModel = UsersViewModel()
    var body: some View {
        VStack{
            VStack{
                Text("iCity").font(.largeTitle)
                VStack{
                    VStack{
                        Image("icity").resizable().frame(width:100,height:95)
                    }.padding(27)
                    VStack{
                        Text("LastName").frame(width:200,alignment: .leading)
                        TextField("Enter your LastName", text: $users.lastname).frame(width:200,alignment: .leading)
                    }.padding(27)
                    VStack{
                        Text("FirstName").frame(width:200,alignment: .leading)
                        TextField("Enter your FirstName", text: $users.firstname).frame(width:200,alignment: .leading)
                    }.padding(27)
                    VStack{
                        Text("Email").frame(width:200,alignment: .leading).autocapitalization(.none)
                        TextField("Enter your Email", text: $users.email).frame(width:200,alignment: .leading).autocapitalization(.none)
                    }.padding(27)
                    VStack{
                        Text("Password").frame(width:200,alignment: .leading)
                        TextField("Enter your Password", text: $users.password).frame(width:200,alignment: .leading)
                    }.padding(27)
                    VStack{
                        Button(action: {
                            usersViewModel.createUser(model: users)
                        }, label: {
                            Text("Create Account").foregroundStyle(.white)
                        }).background {
                            RoundedRectangle(cornerRadius: 22.0).frame(width:300,height:45)
                                .foregroundStyle(.blue)
                        }.padding(15)

                    }
                    
                }.frame(height:670,alignment:.center)
                
                Spacer()
            }.frame(maxWidth: .infinity)
        }
    }
}

