//
//  TaskTableViewController.swift
//  Task
//
//  Created by iGuest on 5/25/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit
import Firebase

class TaskTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var rootRef: DatabaseReference!
    
    @IBOutlet weak var tableview: UITableView!
    var tasks: [String] = []
    
    var firstTime = true
    var backFromAddTask = false
    
    override func viewWillAppear(_ animated: Bool) {
        if firstTime {
            self.showMessagePrompt("Welcome!")
            firstTime = false
        }
        
        if backFromAddTask {
            self.showMessagePrompt("Add Success!")
            backFromAddTask = false
            
            self.tableview.reloadData()
        }
    }
    
    @IBAction func AddTask(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc: AddTaskViewController = sb.instantiateViewController(withIdentifier: "addTask") as! AddTaskViewController
        vc.vc = self
        self.present(vc, animated: true, completion: {() in
            self.backFromAddTask = true
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        self.tableview.tableFooterView = UIView()
        
        rootRef = Database.database().reference()
        refreshTable()
    }
    
    func refreshTable() {
        rootRef.child("tasks").observeSingleEvent(of: .value, with: { (snap) in
            let value = snap.value as? NSDictionary
            self.tasks = value!.allKeys as! [String]
            self.tableview.reloadData()
        })
    }
    
    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: { () in
            self.dismiss(animated: true, completion: nil)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        // Configure the cell...
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc: ViewController = sb.instantiateViewController(withIdentifier: "home") as! ViewController
        vc.task = tasks[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            rootRef.child("tasks/\(tasks[indexPath.row])").setValue(nil)
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
