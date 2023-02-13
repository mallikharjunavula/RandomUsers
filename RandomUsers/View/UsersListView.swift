//
//  ContentView.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 10/02/23.
//

import SwiftUI

struct UsersListView<Model>: View where Model: RandomUsersViewModelProtocol {
    
    @StateObject private var viewModel: Model
    
    init(viewModel: Model) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("HelloWorld")
        NavigationView {
                // List of the RandomUsers
                List {
                    ForEach(resultsData) { user in
                        NavigationLink {
                            UserDetailView(userModel: user.userModel, viewModel: viewModel)
                        } label: {
                            UsersTitleView(title: user.userModel.name.fullName, imageURL: user.userModel.picture.large, viewModel: viewModel)
                        }
                    }
                }
                //Can remove the White space on the top of the List by uncommenting below
                //.listStyle(.plain)
            }
            .navigationBarTitle("List")
        }
        .onAppear {
            viewModel.fetchRandomUsers()
        }
    }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(viewModel: RandomUsersViewModel(apiFetcher: APIModule()))
    }
}
