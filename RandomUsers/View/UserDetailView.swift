//
//  UserDetailView.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 11/02/23.
//

import SwiftUI

struct UserDetailView<Model>: View where Model: RandomUsersViewModelProtocol {
    
    var userModel: UserModel
    @ObservedObject var viewModel: Model
    
    var body: some View {
        VStack {
            Image(uiImage: (UIImage(data: (viewModel.imageList[userModel.picture.large] ?? Data()) ?? Data()) ?? UIImage(named: "placeholder")) ?? UIImage())
                .resizable()
                .frame(width: 150.0, height: 150.0)
                .cornerRadius(30.0)
            Text("")
                .frame(height: 10.0)
            Divider()
            Text("")
                .frame(height: 25.0)
        }
        .navigationBarTitle(userModel.name.fullName, displayMode: .inline)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
