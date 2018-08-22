//
//  TestViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import Firebase


class TestViewController: UIViewController {

    var posts = [Post]()
    var lines = [Line]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createPost(){
        let user = Auth.auth().currentUser
        
       
        let post = Post(clientID: (user?.uid)!, clientName: (user?.email!)!, postID: "", date: Date().timeString(), location: "24 marshal street, san francisco, CA 94102")
        PostServices.create(post: post) { (post) in
            self.posts.append(post)
        }
    }
    func loginUser(){
       
        
        InstanceID.instanceID().instanceID { (result, error) in
           
            Auth.auth().createUser(withEmail: "yves9@mail.com", password: "12345678", completion: { (auth, _) in
                
                let user = User(fn: "yves", ln: "son", un: "yveslym", deviceToken: (result?.token)!, accountType: "client",email: (Auth.auth().currentUser?.email!)!)
                
                UserServices.create("", user: user, completion: { (created) in
                    print(created)
                })
            })
        }
    }
    
    func createLine(){
        if !posts.isEmpty{
            
            let post = posts.removeFirst()
            LineServices.create(post: post) { (line) in
                if let line = line{
                    self.lines.append(line)
                }
            }
        }
    }
    @IBAction func login(_ sender: UIButton){
        loginUser()
    }
    @IBAction func createPost(_ sender: UIButton){
        createPost()
    }
    
    @IBAction func creatLine(_ sender: UIButton){
        createLine()
    }
    
}









