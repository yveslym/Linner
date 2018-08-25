//
//  LinnerMainViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/25/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import Kingfisher
class LinnerMainViewController: UIViewController {

    // - Mark: UIBoutlet
    @IBOutlet weak var postTableView: UITableView!
    
    // - Mark: Properties
    private var posts = [Post](){
        didSet{
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
    }
    private var lines = [Line](){
        didSet{
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
    }
    
    // - MARK: Method
    
    
    private func retrieveLinePost(){
        
        PostServices.show { (post) in
            if let post = post {
                self.posts = post
            }
        }
    }
    
    private func observePost(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// - Mark: Table view life cycle

extension LinnerMainViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.postDate.text = post.date
        cell.postTitle.text = post.title
        cell.postLocation.text = post.location
        cell.lineTaskDuration.text = post.duration
        cell.clientName.text = "posted by: \(post.clientName)"
        cell.postLocation.text = post.location
        
        cell.clientProfilePic.kf.setImage(with: post.posterImage.toURL())
        
        return cell
    }
    
    
}









