//
//  CreateLinePostViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/23/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class CreateLinePostViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToMain(_ sender: UIButton){
        
         dismiss(animated: true, completion: nil)
    }
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        //let sourceViewController = sender.source
        // Use data from the view controller which initiated the unwind segue
    }

}

// - MARK: Handle Line Logic
extension CreateLinePostViewController{
    @IBAction func datePickerButtonTapped(_ sender: UIButton){
    }
    
}



