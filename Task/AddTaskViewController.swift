//
//  AddTaskViewController.swift
//  Task
//
//  Created by iGuest on 5/25/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit
import Firebase

class AddTaskViewController: UIViewController {
    
    var rootRef: DatabaseReference!
    

    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var DetailField: UITextField!
    @IBOutlet weak var DueOnField: UITextField!
    
    @IBAction func AddBtnClick(_ sender: UIButton) {
        if let title = TitleField.text {
            let path = "tasks\(title)/"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            
            rootRef.child(path + "title").setValue(title)
            rootRef.child(path + "detail").setValue(DetailField.text)
            rootRef.child(path + "create_on").setValue(dateFormatter.string(from: Date()))
            rootRef.child(path + "due_on").setValue(DueOnField.text)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rootRef = Database.database().reference()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
