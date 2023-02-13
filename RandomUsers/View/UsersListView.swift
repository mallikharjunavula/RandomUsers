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
    }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(viewModel: RandomUsersViewModel(apiFetcher: APIModule()))
    }
}
