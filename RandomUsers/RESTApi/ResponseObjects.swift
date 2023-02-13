//
//  ResponseObjects.swift
//  RandomUsersList
//
//  Created by Mallikharjuna avula on 10/02/23.
//

import Foundation

struct RandomUsers: Codable {
    var results: [UserModel]
    var info: ResponseInfo
}

struct ResponseInfo: Codable {
    var seed: String
    var results: Int
    var page: Int
    var version: String
}

struct UserModel: Codable {
    var gender: String
    var name: UserName
    var location: UserLocation
    var email: String
    var login: LoginDetails
    var dob: DateOfBirth
    var registered: Registered
    var phone: String
    var cell: String
    var id: Identifier
    var picture: PictureDetails
    var nat: String
}

struct UserName: Codable {
    var title: String
    var first: String
    var last: String
    
    var fullName: String {
        return "\(first) \(title) \(last)"
    }
}

struct StreetDetails: Codable, CustomStringConvertible {
    var number: Int
    var name: String
    
    var description: String {
        return "St.No: \(number), \(name)"
    }
}

struct Coordinates: Codable {
    var latitude: String?
    var longitde: String?
}

struct TimeZone: Codable {
    var offset: String
    var description: String
}

class UserLocation: Codable, CustomStringConvertible {
    var street: StreetDetails
    var city: String
    var state: String
    var country: String
    var postcode: String?
    var coordinates: Coordinates
    var timezone: TimeZone
    
    var description: String {
        return "\(street),\n \(city), \(state), \(country), \(postcode ?? "")"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(StreetDetails.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)
        coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        timezone = try container.decode(TimeZone.self, forKey: .timezone)

        let postcodeString = try? container.decode(String.self, forKey: .postcode)
        let postcodeInt = try? container.decode(Int.self, forKey: .postcode)
        self.postcode = postcodeString ?? String(postcodeInt ?? 0)
    }
}

struct LoginDetails: Codable {
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha256: String
}

struct DateOfBirth: Codable {
    var date: String
    var age: Int
}

struct Registered: Codable {
    var date: String
    var age: Int
}

struct Identifier: Codable {
    var name: String
    var value: String?
}

struct PictureDetails: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}
