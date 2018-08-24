//
//  User.swift
//  Linner
//
//  Created by Yves Songolo on 8/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

class User: Decodable{
    let firstName: String
    let lastName: String
    let userName: String
    var deviceToken: String?
    let accountType: String
    let email: String
    var profileUrl : String?
    
    init(fn: String, ln: String, un: String, deviceToken: String, accountType: String, email: String, profileUrl: String? = nil){
        self.firstName = fn
        self.lastName = ln
        self.deviceToken = deviceToken
        self.accountType = accountType
        self.userName = un
        self.email = email
        if let url = profileUrl{
            self.profileUrl = url
        }
    }
    func toDictionary() -> [String: Any]{
        return["firstName": firstName,
               "lastName": lastName,
               "deviceToken": deviceToken ?? "",
            "accountType":accountType,
            "userName":userName,
            "profileUrl":profileUrl ?? "",
            "email":email]
    }
}


