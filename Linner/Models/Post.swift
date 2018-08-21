//
//  Post.swift
//  Linner
//
//  Created by Yves Songolo on 8/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
class Post: Decodable{
    let clientId: String
    let clientName: String
    let postId: String
    let date: Date
    let location: Address
}

class Address: Decodable{
    let street: String
    let zipCode: String
    let country: String
    let city: String
}
