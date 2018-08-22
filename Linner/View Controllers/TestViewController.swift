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
        
        let address = Address(street: "22 marshal Street", zipcode: "12345", country: "USA", city: "SF")
        let post = Post(clientID: (user?.uid)!, clientName: (user?.email!)!, postID: "", date: Date(), location: address)
        PostServices.create(post: post) { (post) in
            print(post.postId ?? "no id")
        }
    }
    func loginUser(){
        let user = User(fn: "yves", ln: "son", un: "yveslym", deviceToken: "", accountType: "client")
        
        InstanceID.instanceID().instanceID { (result, error) in
            user.deviceToken = result?.token
            Auth.auth().createUser(withEmail: "yves9@mail.com", password: "12345678", completion: { (auth, _) in
                UserServices.create("", user: user, completion: { (created) in
                    print(created)
                })
            })
        }
    }
    @IBAction func login(_ sender: UIButton){
        loginUser()
    }
    @IBAction func createPost(_ sender: UIButton){
        createPost()
    }
}









