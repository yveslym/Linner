//
//  Constant Database.swift
//  Linner
//
//  Created by Yves Songolo on 8/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase

struct Constant{
    static let ref = Database.database().reference()
    static let lineRef = Database.database().reference().child("Lines")
     static let user = Database.database().reference().child("Users")
     static let postRef = Database.database().reference().child("LinePost")
     static let newPost = Database.database().reference().child("LinePost").childByAutoId()
     static let archivePost = Database.database().reference().child("archivePost")
    
    
}
