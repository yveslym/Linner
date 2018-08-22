//
//  LineServices.swift
//  Linner
//
//  Created by Yves Songolo on 8/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
struct LineServices{
    /// method to crearte new line and archive the post
    static func create(post: Post, completion: @escaping (Line?)->()){
        let line = Line(post: post)
        let ref = Database.database().reference().child("Lines").childByAutoId()
        line.lineId = ref.key
        ref.setValue(line.toDictionary()) { (error, _) in
            if error == nil{
                PostServices.archviePost(post: post, completion: { (archived) in
                    if archived{
                        return completion(line)
                    }
                    else{
                        print("didn'archived the post")
                        //return completion(false)
                    }
                })
            }
            print("didn't create line")
           return completion(nil)
        }
    }
    
    /// method to retrieve a single linner lines
    static func show(completion: @escaping([Line]?)-> ()){
        let user = Auth.auth().currentUser
        var lines = [Line]()
        let ref = Database.database().reference().child("Lines")
        let query = ref.queryOrdered(byChild: "linnerId").queryEqual(toValue: user?.uid)
        query.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                snapshot.children.forEach({
                    let snap = $0 as! DataSnapshot
                    let line = try! JSONDecoder().decode(Line.self, withJSONObject: snap.value!)
                    lines.append(line)
                })
                return completion(lines)
            }
            else{
                return completion(nil)
            }
        }
    }
    // method to update new when line start
    static func startLine(line: Line, completion: @escaping(Bool) ->()){
        line.onGoing = true
        line.startTime = Date().timeString()
        let ref = Database.database().reference().child("Lines").child(line.lineId!)
        ref.updateChildValues(line.toDictionary()) { (error, _) in
            if error != nil{
                return completion(true)
            }
            return completion(false)
        }
    }
    /// method to retrieve a sing line
    static func showSingleLine(key: String, completion: @escaping(Line)-> ()){
        let ref = Constant.lineRef.child(key)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let line = try! JSONDecoder().decode(Line.self, withJSONObject: snapshot.value!)
            return completion(line)
        }
    }
    /// method to update when it is the end of the line
    static func endLine(line: Line, completion: @escaping(Line)->()){
        line.onGoing = false
        line.isCompleted = true
        line.endTime = Date().timeString()
        line.lineTime = calculateTimeInterval(start: line.startTime.timeDate(), end: line.endTime.timeDate())
        
        let ref = Constant.lineRef.child(line.lineId!)
        ref.updateChildValues(line.toDictionary()) { (_, newRef) in
            showSingleLine(key: line.lineId!, completion: { (newLine) in
                return completion(newLine)
            })
        }
    }
    
    static private func calculateTimeInterval(start: Date, end:Date) -> String{
        let diff = Int(start.timeIntervalSince1970 - end.timeIntervalSince1970)
        let inHours = diff/3600
        let inMin = (diff - inHours * 3600) / 60
        return String(inMin)
    }
}
