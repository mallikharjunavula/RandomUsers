//
//  Networking.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 10/02/23.
//

import Foundation
import Combine

protocol DataFetcher{
    func fetchRandomUsers() -> AnyPublisher<RandomUsers, APIError>
    func fetchImage(endpoint: Endpoint) -> AnyPublisher<Data, APIError>
}

class APIModule {
    private let sessionManager: URLSession
    init(session: URLSession = .shared) {
        self.sessionManager = session
    }
}

enum Endpoint {
    static let base = "https://randomuser.me/api/?results=50"
    
    case randomUsers
    case fetchImage(imageUrl: String)
    
    var stringValue: String {
        switch self {
        case .randomUsers: return Endpoint.base
        case .fetchImage(let imageUrl): return imageUrl
        }
    }
    
    var url: URL? {
        return URL(string: stringValue)
    }
}
    }
}
