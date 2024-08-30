//
//  User.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import FirebaseFirestoreSwift
import Foundation

struct User: Identifiable, Codable, Hashable {
    @DocumentID var userId: String?
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return userId ?? NSUUID().uuidString
    }
    
    var firstName: String {
        let components = fullname.components(separatedBy: " ")
        return components.first ?? fullname
    }
}

extension User: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
