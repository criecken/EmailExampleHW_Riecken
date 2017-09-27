//
//  RootTVC.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

protocol CellSelectedDelegate {
    func read(email: Email)
}
protocol UpdateEmails {
    func update(newEmails : Array<Email>, currentEmails : Array<Email> , updateRow : String)
    
}

class RootTVC: UITableViewController {
    
    var selectedRow = String()
    var emails = [Email]()
    var label = String()
    var changedEmails = [Email]()
    
    var delegate: CellSelectedDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        self.navigationItem.rightBarButtonItem?.title = label 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return emails.count
            
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: react to user selecting row
        //I want the detail view controller to update based on the row that I selected
        

        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let currentEmail = emails[indexPath.row]
        cell.textLabel?.text = currentEmail.subject
        cell.detailTextLabel?.text = currentEmail.sender
        print("set")

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if label == "Send"{
            return false
        }
        else {
            return true
        }
        
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        var editingStyle = editingStyle
        switch label {
        case "Delete":
            editingStyle = .delete
       
        case "Send":
            editingStyle = .insert
            
        default:
            self.navigationItem.rightBarButtonItem?.title = "Why?"
            
        }
        if editingStyle == .delete {
            // Delete the row from the data source
            changedEmails.append(emails[indexPath.row])
            emails.remove(at: indexPath.row)
            print(emails.count)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            emails.append(Email(sender: "Me@asu.edu", subject: "Please help me with code", contents: "I cannot seem to figure out my problem", recipient: "prof@asu.edu"))
            changedEmails.append(emails[indexPath.row+1])
            tableView.insertRows(at: [indexPath], with: .fade)
    }
    

        
    // Override to support rearranging the table view.
        func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
        

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
            let destVC = segue.destination as! MenuTVC
            print("here")
            for i in 0...changedEmails.count {
                if selectedRow == "Sent"{
                    destVC.dataDictionary[selectedRow]?.append(changedEmails[i])
                }
                else {
                    destVC.dataDictionary[selectedRow] = emails
                    destVC.dataDictionary["Trash"]?.append(changedEmails[i])
                }
            }
            
    }
        

}
}
