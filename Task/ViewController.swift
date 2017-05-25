//
//  ViewController.swift
//  Task
//
//  Created by iGuest on 5/24/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    var rootRef: DatabaseReference!
    
    @IBOutlet weak var ititle: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var create_on: UILabel!
    @IBOutlet weak var due_on: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.showMessagePrompt("Welcome!")
        
        rootRef = Database.database().reference()
        let idRef = rootRef.child("tasks/id")
        
        idRef.child("title").observeSingleEvent(of: .value, with: { (snap) in
            self.ititle.text = snap.value as? String
            self.ititle.sizeToFit()
        })
        
        idRef.child("detail").observeSingleEvent(of: .value, with: { (snap) in
            self.detail.text = snap.value as? String
            self.detail.sizeToFit()
        })
        
        idRef.child("create_on").observeSingleEvent(of: .value, with: { (snap) in
            self.create_on.text = snap.value as? String
            self.create_on.sizeToFit()
        })
        
        idRef.child("due_on").observeSingleEvent(of: .value, with: { (snap) in
            self.due_on.text = snap.value as? String
            self.due_on.sizeToFit()
        })

    }
    
    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

