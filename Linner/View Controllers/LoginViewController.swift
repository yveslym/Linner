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

class LoginViewController: UIViewController {
    // sign in button
    @IBOutlet weak var googleButton: GIDSignInButton!
    
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
// authenticate with google
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
            if let error = error {
                print(error.localizedDescription)
                return
            }
            // User is signed in
            // ...
        }
    }
    func setUpGoogleButton(){
        self.googleButton.colorScheme = .dark
        self.googleButton.style = .wide
    }
}
