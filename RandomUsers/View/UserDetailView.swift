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
    
    let columns = [
            GridItem(.fixed(100)),
            GridItem(.flexible()),
        ]
    
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
            LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(fetchData(), id: \.self) { item in  //Find why we need id: \.self
                        Text(item).frame(alignment: .center)
                    }
                }
                .padding(.horizontal)
        }
        .navigationBarTitle(userModel.name.fullName, displayMode: .inline)
        .onAppear {
            if viewModel.imageList[userModel.picture.large] == nil {
                viewModel.fetchImage(imageURL: userModel.picture.large)
            }
        }
    }
    
    func fetchData() -> [String] {
        return ["Name:", userModel.name.fullName, "Gender:" , userModel.gender,
                "Location:", userModel.location.description, "Email:", userModel.email,
                "Phone:", userModel.phone]
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
