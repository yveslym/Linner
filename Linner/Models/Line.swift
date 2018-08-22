//
//  Line.swift
//  Linner
//
//  Created by Yves Songolo on 8/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase

class Line: Decodable{
    let clientId: String
    let linnerId: String
    var startTime: String
    var endTime: String
    var isCompleted: Bool
    var onGoing: Bool
    var isTaken: Bool
    var lineTime: String
    let location: String
    let date: String
    var lineId: String?
    
    init(post: Post){
        clientId = post.clientId
        linnerId = (Auth.auth().currentUser?.uid)!
        startTime = ""
        endTime = ""
        isCompleted = false
        onGoing = false
        lineTime = "0"
        location = post.location
        date = post.date
        isTaken = true
    }
    
    func toDictionary()-> [String:Any]{
        return ["clientId":clientId,
                "linnerId":linnerId,
                "startTime":startTime,
                "endTime":endTime,
                "isCompleted":isCompleted,
                "onGoing":onGoing,
                "isTaken":isTaken,
                "lineTime":lineTime,
                "location":location,
                "date":date,
                "lineId":lineId ?? ""]
    }
}

