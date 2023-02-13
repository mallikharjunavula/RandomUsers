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

extension RandomUsersViewModel: RandomUsersViewModelProtocol {
    
    func fetchRandomUsers() {
        dataFetcher.fetchRandomUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure(let apiError):
                    print(apiError)
                    self?.randomUsers = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] usersResponse in
                print(usersResponse)
                self?.randomUsers = usersResponse.results.map{ User(user: $0) }
            }
            .store(in: &disposables)
    }
    
    func fetchImage(imageURL: String) {
        dataFetcher.fetchImage(endpoint: .fetchImage(imageUrl: imageURL))
            .receive(on: DispatchQueue.main)
            .sink { value in
                switch value {
                case .failure(let apiError):
                    print(apiError)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] usersResponse in
                print(usersResponse)
                self?.imageList[imageURL] = usersResponse
            }
            .store(in: &disposables)
    }
}
