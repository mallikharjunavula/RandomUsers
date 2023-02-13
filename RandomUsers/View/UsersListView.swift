//
//  ContentView.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 10/02/23.
//

import SwiftUI

struct UsersListView<Model>: View where Model: RandomUsersViewModelProtocol {
    
    @State private var searchText = ""
    @StateObject private var viewModel: Model
    @State var filteredUsers: [User] = []
    @State var pick : Int = 0
    @State var filterResultsEmpty = false
    
    init(viewModel: Model) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                //Hstack for whole Searchbar and Cancel Button
                HStack{
                    CustomSearchBar()
                        .frame(height: 35.0)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.mediumGrey))
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20.0)
                                .stroke(Color.darkGrey, lineWidth: 2) )
                        .padding([.leading, .trailing], 8.0)
                    //Add the Cancel Button trailing to SearchBar to end editing
                    if isEditing {
                        Text("Cancel")
                            .foregroundColor(Color.black)
                            .onTapGesture {
                                searchText = ""
                                isEditing = false
                                hideKeyboard()
                            }
                            .padding(.trailing, 5.0)
                    }
                }
                // View for Filter button
                HStack {
                    Spacer()
                    CustomPicker()
                        .padding(.trailing, 30.0)
                }
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
    
    // Picker View for the filterOptions based on gender
    func CustomPicker() -> some View {
        return Picker(selection: $pick, label: Text("")) {
                Text("All").tag(0).foregroundColor(.cyan)
                Text("Male").tag(1).foregroundColor(.cyan)
                Text("Female").tag(2).foregroundColor(.cyan)
            }
            .frame(width: 60.0)
            .onChange(of: pick) { _ in updateFilters() }
            .overlay( RoundedRectangle(cornerRadius: 20.0)
                .stroke(Color.lightGrey, lineWidth: 3.0))
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
    
    var resultsData: [User] {
        if filterResultsEmpty {
            return []
        } else if filteredUsers.count != 0 {
            return filteredUsers
        } else {
            return viewModel.randomUsers
        }
    }
    
    func updateFilters() {
        guard !(searchText.isEmpty) else {
            filteredUsers = viewModel.randomUsers
            updateGenderResults()
            return
        }
        filteredUsers = viewModel.randomUsers.filter{ $0.userModel.name.fullName.contains(searchText) }
        updateGenderResults()
    }
    
    func updateGenderResults() {
        switch pick {
        case 1: filteredUsers = filteredUsers.filter { $0.userModel.gender == "male" }
        case 2: filteredUsers = filteredUsers.filter { $0.userModel.gender == "female" }
        default: break
        }
        filterResultsEmpty = filteredUsers.count == 0
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct User: Identifiable {
    public var id = UUID()
    var userModel: UserModel
    
    public init(user: UserModel) {
        self.userModel = user
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(viewModel: RandomUsersViewModel(apiFetcher: APIModule()))
    }
}
