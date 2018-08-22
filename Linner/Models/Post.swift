//
//  Post.swift
//  Linner
//
//  Created by Yves Songolo on 8/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase
class Post: Decodable{
    let clientId: String
    let clientName: String
    var postId: String?
    let date: String
    let location: String
    var isArchived: Bool
    
    init(clientID: String, clientName: String,postID: String, date: String, location: String){
        self.clientId = clientID
        self.clientName = clientName
        self.date = date
        self.location = location
        self.isArchived = false
    }
    
    init(snapshot: DataSnapshot){
        let value = snapshot.value as! [String:Any]
        self.clientId = value["clientId"] as! String
        self.clientName = value["clientName"] as! String
        self.postId = snapshot.key
        self.location = value["location"] as! String
        self.date = value["date"] as! String
        self.isArchived = value["isArchived"] as! Bool
    }
    
    func toDictionary() -> [String: Any]{
        return ["clientId":clientId,
                "clientName":clientName,
                "location":location,
                "isArchived":isArchived]
    }
}

class Address: Decodable{
    let street: String
    let zipCode: String
    let country: String
    let city: String
    
    init(street: String, zipcode: String, country: String, city: String){
        self.street = street
        self.city = city
        self.country = country
        self.zipCode = zipcode
    }
    func toDictionary() -> [String: Any]{
        return[
            "street":street,
            "city":city,
            "country": country,
            "zipCode": zipCode
        ]
    }
}
