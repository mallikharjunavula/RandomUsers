//
//  TitleView.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 11/02/23.
//

import Foundation
import SwiftUI

struct UsersTitleView<Model>: View where Model: RandomUsersViewModelProtocol{
    
    @ObservedObject private var viewModel: Model
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("HelloWorld")
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        UsersTitleView(title: "My Name", imageURL: "Empty", viewModel: RandomUsersViewModel(apiFetcher: APIModule()))
    }
}
