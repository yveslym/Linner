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
    var clientId: String
    var clientName: String
    var postId: String?
    var date: String
    var location: String
    var isArchived: Bool
    var description: String
    var title: String
    var duration: String
    
    init(clientID: String, clientName: String,postID: String, date: String, location: String, title: String, description: String, duration: String){
        self.clientId = clientID
        self.clientName = clientName
        self.date = date
        self.location = location
        self.isArchived = false
        self.postId = ""
        self.title = title
        self.description = description
        self.duration = duration
        
    }
    init(){
        self.clientId = ""
        self.clientName = ""
        self.date = ""
        self.location = ""
        self.isArchived = false
        self.postId = ""
        self.title = ""
        self.description = ""
         self.duration = ""
        
    }
    
    init(snapshot: DataSnapshot){
        let value = snapshot.value as! [String:Any]
        self.clientId = value["clientId"] as! String
        self.clientName = value["clientName"] as! String
        self.postId = snapshot.key
        self.location = value["location"] as! String
        self.date = value["date"] as! String
        self.isArchived = value["isArchived"] as! Bool
        self.postId = snapshot.key
        self.title = value["title"] as! String
        self.description = value["description"] as! String
         self.duration = value["duration"] as! String
    }
    
    func toDictionary() -> [String: Any]{
        return ["clientId":clientId,
                "clientName":clientName,
                "location":location,
                "isArchived":isArchived,
                "date":date,
                "duration":duration,
                "description":description,
                "title":title]
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
