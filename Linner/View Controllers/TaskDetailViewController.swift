//
//  TaskDetailViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/25/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class TaskDetailViewController: UIViewController {

    var post: Post!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var taskDuration: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskMap: MKMapView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func returnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        postTitle.text = post.title
        posterName.text = post.clientName
        taskDescription.text = post.description
        self.imageVIew.kf.setImage(with: URL(string: post.posterImage)!)
        addressToCoordinatesConverter(address: post.location)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addressToCoordinatesConverter(address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) -> Void in
            if error == nil {
                if placemarks!.count != 0 {
                    let annotation = MKPointAnnotation()
                   
                    annotation.coordinate = (placemarks?.first?.location?.coordinate)!
                   // self.taskMap.showAnnotations([annotation], animated: true)
                    self.taskMap.addAnnotation(annotation)
//                    self.taskMap.selectedAnnotations(annotation, animated: true)
                    self.taskMap.selectAnnotation(annotation, animated: true)
                }
            }
        })
    }
}
