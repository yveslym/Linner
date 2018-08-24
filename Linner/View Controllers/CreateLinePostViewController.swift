//
//  CreateLinePostViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/23/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import FirebaseAuth
class CreateLinePostViewController: UIViewController {
    
    @IBOutlet weak var pickdateButton: UIButton!
    @IBOutlet weak var lineTitle: UITextField!
    @IBOutlet weak var lineAddress: UITextField!
    @IBOutlet weak var lineTimeDuration: UISegmentedControl!
    @IBOutlet weak var lineDescription: UITextView!
    
    
    // - MARK: Properties
    
    var linePost: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linePost = Post()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToMain(_ sender: UIButton){
         dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pickerVC = segue.destination as! PickDateViewController
        pickerVC.linePost = self.linePost
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        //let sourceViewController = sender.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if linePost.date != ""{
            self.pickdateButton.titleLabel?.text = linePost.date
        }
    }

}

// - MARK: Handle Line Logic
extension CreateLinePostViewController{
    @IBAction func datePickerButtonTapped(_ sender: UIButton){
        self.performSegue(withIdentifier: "date", sender: nil)
    }
    @IBAction func doneButtonTapped(_ sender: UIButton){
        postTask { (posted) in
            if posted{
                print("posted")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func postTask(completion: @escaping(Bool)->()){
        guard let lineTitle = lineTitle.text, let lineAddress = lineAddress.text, let lineDescription = lineDescription.text else {return}
        let durartion = lineTimeDuration.selectedSegmentIndex
        let user = Auth.auth().currentUser
        linePost.location = lineAddress
        linePost.title = lineTitle
        linePost.description = lineDescription
        linePost.duration = String("\(durartion + 1)")
        linePost.clientName = (user?.displayName)!
        linePost.clientId = (user?.uid)!
        if linePost.date == ""{
            self.presentAlert(title: "Date missing", message: "Please add date line")
            return
        }
        
        PostServices.create(post: linePost) { (post) in
            print("post created")
            completion(true)
        }
    }
    
}



