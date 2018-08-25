//
//  MyTaskViewController.swift
//  Linner
//
//  Created by Yves Songolo on 8/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class MyTaskViewController: UIViewController {

    // - Mark: IBOutlet
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var tableSwitcher: UISegmentedControl!
    
    // - Mark: Properties
    private var posts = [Post](){
        didSet{
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        }
    }
    private var lines = [Line](){
        didSet{
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        }
    }
    
    var selectedCell : CellSelection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.retrieveLine()
        self.retrieveLinePost()
    }
    
    //- Mark: Methods
    
    private func retrieveLinePost(){
        PostServices.show { (post) in
            if let post = post {
               self.posts = post
            }
        }
    }
    private func retrieveLine(){
        LineServices.show { (line) in
            if let line = line{
                self.lines = line
            }
        }
    }

}

// - Mark: Table view life cycle

extension MyTaskViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        
        switch section{
        case 0:
            selectedCell = .line
            return lines.count
        case 1:
            selectedCell = .post
            return posts.count
        default: return 0
            
            }
        }
   // }
    
    func setUpLineCell(cell: LineTableViewCell, line: Line) -> UITableViewCell{
        cell.lineTitle.text = line.title
        cell.lineDate.text = line.date
        cell.linnerName.text = line.linnerName
        
        switch line.onGoing{
        case true:
            cell.startTime.text = line.startTime.toDate().timeString()
            cell.endTime.text = "not finish"
            cell.duration.text = "N/A"
        case false:
            cell.startTime.text = line.startTime.toDate().timeString()
            cell.endTime.text = line.endTime.toDate().timeString()
            cell.duration.text = "\(line.lineTime) min "
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch selectedCell {
        case .line:
            let cell = tableView.dequeueReusableCell(withIdentifier: "line", for: indexPath) as! LineTableViewCell
            let line = lines[indexPath.row]
            return setUpLineCell(cell: cell, line: line)
            
        case .post:
            let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
            cell.postDate.text = post.date
            cell.postTitle.text = post.title
            cell.postLocation.text = post.location
            
            return cell
            
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
            cell.postDate.text = post.date
            cell.postTitle.text = post.title
            cell.postLocation.text = post.location
            return cell
        }
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
}

enum CellSelection: String{
    case line
    case post
}


