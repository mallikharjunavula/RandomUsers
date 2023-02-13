//
//  TitleView.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 11/02/23.
//

import Foundation
import SwiftUI

struct UsersTitleView<Model>: View where Model: RandomUsersViewModelProtocol{
    
    private var title: String
    @State private var imageURL: String
    @ObservedObject private var viewModel: Model
    
    init(title: String, imageURL: String, viewModel: Model) {
        self.title = title
        self.imageURL = imageURL
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 20.0) {
            Image(uiImage: (UIImage(data: (viewModel.imageList[imageURL] ?? Data()) ?? Data()) ?? UIImage(named: "placeholder")) ?? UIImage())
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.blue, lineWidth: 1)
                    )
            Text(title)
                .padding(8.0)
                .font(.bold(.custom("Helvetica", size: 18.0))())
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        UsersTitleView(title: "My Name", imageURL: "Empty", viewModel: RandomUsersViewModel(apiFetcher: APIModule()))
    }
}
