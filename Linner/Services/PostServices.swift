//
//  PostServices.swift
//  Linner
//
//  Created by Yves Songolo on 8/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase
struct PostServices{
    static func create(post: Post, completion: @escaping (Post) -> ()){
        let ref = Constant.newPost
        post.postId = ref.key
        ref.setValue(post.toDictionary())
        completion(post)
        
    }
    // method to retrieve all the line posted
    static func show(completion: @escaping([Post]?)->()){
        var posts = [Post]()
        let ref = Constant.postRef
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                snapshot.children.forEach({ (snap) in
                    let snap = snap as! DataSnapshot
                    let post = Post(snapshot: snap )
                    posts.append(post)
                    // let p = try! JSONDecoder().decode(Post.self, withJSONObject: snap.value)
                })
                completion(posts)
            }
            else{
                completion(nil)
            }
        }
    }
    static func archviePost(post: Post, completion: @escaping(Bool)-> ()){
        let ref = Constant.archivePost.child(post.postId!)
        ref.setValue(post.toDictionary()) { (_, _) in
            let postRef = Constant.postRef.child(post.postId!)
            postRef.removeValue()
        }
    }
}
