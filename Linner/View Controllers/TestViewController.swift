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
        
       
        let post = Post()//Post(clientID: (user?.uid)!, clientName: (user?.email!)!, postID: "", date: Date().toString(), location: "24 marshal street, san francisco, CA 94102")
        PostServices.create(post: post) { (post) in
            self.posts.append(post)
            print(post.postId!)
        }
    }
    func loginUser(){
       
        
        InstanceID.instanceID().instanceID { (result, error) in
           
            Auth.auth().createUser(withEmail: "yves@mail.com", password: "12345678", completion: { (auth, _) in
                
                let user = User(fn: "yves", ln: "son", un: "yveslym", deviceToken: (result?.token)!, accountType: "linner",email: (Auth.auth().currentUser?.email!)!)
                
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
    
    func retrievePost(){
        PostServices.show { (post) in
            if let post = post{
            self.posts = post
            print(post.count)
            }else{
                print("no post in the dsatabase")
            }
        }
    }
    
    func retrieveLine(){
        LineServices.show { (line) in
            if let line = line{
                self.lines = line
                print(line.count)
            }else{
            print("no line in the database")
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
    @IBAction func retrievePosts(_ sender: UIButton){
       retrievePost()
    }
    @IBAction func retrieveLines(_ sender: UIButton){
        retrieveLine()
    }
    @IBAction func startLine(_ sender: UIButton){
        LineServices.startLine(line: lines.first!) { (started) in
            print("line started ", started)
        }
    }
    
    @IBAction func endLine(_ sender: UIButton){
        LineServices.endLine(line: lines.first!) { (line) in
            print(line.toDictionary())
        }
    }
    
    
    
}









