//
//  Error.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 10/02/23.
//

import Foundation

enum APIError: Error {
    case requestError(message: String)
    case networkError(message: String)
    case parsing(message: String)
    case unknown(message: String)
}
