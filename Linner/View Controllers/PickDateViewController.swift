//
//  PickDateViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/23/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class PickDateViewController: UIViewController {

    var linePost: Post!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
        
    }
   
    @IBAction func doneButtonTapped(_ sender: Any) {
        linePost.date = datePicker.date.toString()
        dismiss(animated: true, completion: nil)
    }
}




