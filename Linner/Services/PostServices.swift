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
    
    /// method to create new post
    static func create(post: Post, completion: @escaping (Post) -> ()){
        let ref = Constant.postRef.childByAutoId()
        post.postId = ref.key
        ref.setValue(post.toDictionary()) { (_, _) in
             completion(post)
        }
       
        
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
                })
                completion(posts)
            }
            else{
                completion(nil)
            }
        }
    }
    
    /// method to archive post when it's taken
    static func archviePost(post: Post, completion: @escaping(Bool)-> ()){
        let ref = Constant.archivePost.child(post.postId!)
        ref.setValue(post.toDictionary()) { (_, _) in
            let postRef = Constant.postRef.child(post.postId!)
            postRef.removeValue(completionBlock: { (error, _) in
                if error == nil{
                completion(true)
                }
            })
        }
    }
    static func observeNewPostEntry(completion: @escaping(Post) ->()){
        
       let ref = Constant.postRef
        ref.observe(.childAdded) { (snapshot) in
            let post = try! JSONDecoder().decode(Post.self, withJSONObject: snapshot.value!)
            completion(post)
        }
    }
}



