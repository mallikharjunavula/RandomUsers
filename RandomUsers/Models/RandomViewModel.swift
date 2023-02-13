//
//  RandomViewModel.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 10/02/23.
//

import Foundation
import Combine

protocol RandomUsersViewModelProtocol: ObservableObject {
    var randomUsers: [User] { get set }
    var imageList: [String: Data?] { get set }
    func fetchRandomUsers()
    func fetchImage(imageURL: String)
    init(apiFetcher: DataFetcher)
}

class RandomUsersViewModel {
    @Published var randomUsers: [User]
    private var dataFetcher: DataFetcher
    private var disposables = Set<AnyCancellable>()
    @Published var imageList = [String : Data?]()
    
    required init(apiFetcher: DataFetcher) {
        dataFetcher = apiFetcher
        randomUsers = []
    }
}
