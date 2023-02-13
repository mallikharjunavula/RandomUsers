//
//  RandomUsersListApp.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 10/02/23.
//

import SwiftUI

@main
struct RandomUsersListApp: App {
    let viewModel = RandomUsersViewModel(apiFetcher: APIModule())
    var body: some Scene {
        WindowGroup {
            UsersListView(viewModel: RandomUsersViewModel(apiFetcher: APIModule()))
        }
    }
}
