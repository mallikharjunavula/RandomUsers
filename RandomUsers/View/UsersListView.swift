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
                    CustomSearchBar()
                        .frame(height: 35.0)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.mediumGrey))
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20.0)
                                .stroke(Color.darkGrey, lineWidth: 2) )
                        .padding([.leading, .trailing], 8.0)
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
    
    //HStack for the Searchbar and back button inside searchbar
    func CustomSearchBar() -> some View {
        return HStack {
            TextField("Search", text: $searchText, onCommit: {
                isEditing = false
            })
                .onChange(of: searchText) { _ in
                    updateFilters()
                }
                .onTapGesture {
                    isEditing = true
                }
                .offset(x: 10.0)
            // Add the delete button along with SearchBar
            if isEditing {
                Button(action: {
                        searchText = ""
                    },
                     label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    })
                    .padding(.trailing, 8.0)
                }
            }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(viewModel: RandomUsersViewModel(apiFetcher: APIModule()))
    }
}
