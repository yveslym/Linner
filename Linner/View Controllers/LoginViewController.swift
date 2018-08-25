//
//  LoginViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    // sign in button
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var facebookButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
       // GIDSignIn.sharedInstance().signIn()
        setUpGoogleButton()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
extension LoginViewController: FBSDKLoginButtonDelegate{
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard (FBSDKAccessToken.current()) != nil else {return}
         let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if error != nil {
                // ...
                return
            }
            // User is signed in
            UserServices.loginWithFacebook(sender: self, completion: { (user) in
                if user != nil{
                    User.setCurrent(user!, writeToUserDefaults: true)
                     self.performSegue(withIdentifier: "client", sender: nil)
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
    
}

/// authenticate with google
extension LoginViewController: GIDSignInUIDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        // ...
    
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if error == nil {
               self.presentAlert(title: "Login Error", message: "coun't register please try again!!!")
                return
            }
            // User is signed in
            // register user
            UserServices.loginWithGoogle(googleUser: user, completion: { (user) in
                if user != nil{
                    self.performSegue(withIdentifier: "client", sender: nil)
                }
                else{
                    self.presentAlert(title: "Login Error", message: "coun't register please try again!!!")
                }
            })
        }
    }
    func setUpGoogleButton(){
        self.googleButton.colorScheme = .dark
        self.googleButton.style = .standard
       
        
        self.facebookButton.delegate = self
        self.facebookButton.readPermissions = ["public_profile", "email"]
    }
}
