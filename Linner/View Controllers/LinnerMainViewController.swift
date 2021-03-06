//
//  LinnerMainViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/25/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
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
    
    var uid = String()
    
    // - MARK: Method
    
    
    private func retrieveLinePost(){
        
        PostServices.show { (post) in
            if let post = post {
                let filtredPost = post.filter({$0.clientId != self.uid})
                self.posts = filtredPost
            }
        }
    }
    
    private func observePost(){
        PostServices.observeNewPostEntry { (post) in
            if post.clientId != self.uid{
            self.posts.append(post)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uid = (Auth.auth().currentUser?.uid)!
        retrieveLinePost()
        observePost()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.posts[indexPath.row]
        self.performSegue(withIdentifier: "next", sender: post)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let post = sender as! Post
        let vc = segue.destination as! TaskDetailViewController
        vc.post = post
    }
    
}









