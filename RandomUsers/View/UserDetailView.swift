//
//  UserDetailView.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 11/02/23.
//

import SwiftUI

struct UserDetailView<Model>: View where Model: RandomUsersViewModelProtocol {
    
    @ObservedObject var viewModel: Model
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
