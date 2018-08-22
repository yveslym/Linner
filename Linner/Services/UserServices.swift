//
//  UserServices.swift
//  Linner
//
//  Created by Yves Songolo on 8/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase


struct UserServices{
    // method to create new user
    static func create(_ password: String, user: User, completion: @escaping(Bool)->()){
        let authUser = Auth.auth().currentUser
      
        let ref = Database.database().reference().child("Users").child((authUser?.uid)!)
        ref.setValue(user.toDictionary()) { (error, _) in
            if error != nil{
                return completion(false)
            }
            completion(true)
        }
    }
    
}

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}


