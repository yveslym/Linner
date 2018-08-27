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
import CountdownLabel

class TaskDetailViewController: UIViewController {

    var post: Post!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var taskDuration: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskMap: MKMapView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var countDown: CountdownLabel!
    
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
       
       
        LineServices.create(post: post) { (line) in
            print("taken")
            if line?.isTaken == true{
                self.doneButton.isEnabled = false
            }
        }
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
       
        
        countDownTime()
    }
    func countDownTime(){
        let now = Date()
        let endTime = post.date.toDate()
       
        let minuteCount = Double(endTime.minutes(from: now))
        let day = endTime.days(from: now)
        
        //self.countDown = CountdownLabel(frame: self.countDown.frame, minutes: minuteCount!) // you can use NSDate as well
        //countDown.addTime(time: minuteCount)
        
        if day <= 1{
       countDown.setCountDownDate(targetDate: endTime as NSDate)
        
       // countDown.animationType = .Pixelate
        self.countDown.start()
        }else{
            self.countDown.text = post.date
        }
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
                    self.taskMap.setCenter(annotation.coordinate, animated: true)
                    let viewRegion = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000)
                   
                    self.taskMap.setRegion(viewRegion, animated: true)
                }
            }
        })
    }
}
