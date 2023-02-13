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

extension APIModule: DataFetcher {
    
    func fetchRandomUsers() -> AnyPublisher<RandomUsers, APIError> {
        return fetchRequest(with: Endpoint.randomUsers.url, session: sessionManager)
    }
    
    func fetchImage(endpoint: Endpoint) -> AnyPublisher<Data, APIError> {
        guard let url = endpoint.url else {
            return Fail(error: APIError.requestError(message: "Invalid URL")).eraseToAnyPublisher()
        }
        return sessionManager.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
             .networkError(message: error.localizedDescription)
          }
          .map { $0.data }
          .eraseToAnyPublisher()
    }
    
    func fetchRequest<T>(with url: URL?, session: URLSession) -> AnyPublisher<T, APIError> where T: Decodable {
        guard let url = url else {
            return Fail(error: APIError.requestError(message: "Invalid URL")).eraseToAnyPublisher()
        }
        return sessionManager.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
             .networkError(message: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { response in
              self.decode(response.data)
          }
          .eraseToAnyPublisher()
    }
    
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
      let decoder = JSONDecoder()

      return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}
