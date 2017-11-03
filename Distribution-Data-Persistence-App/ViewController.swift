//
//  ViewController.swift
//  Distribution-Data-Persistence-App
//
//  Created by Meghan King on 11/3/17.
//  Copyright © 2017 Meghan King. All rights reserved.
//

import UIKit
import CoreData

//import TextFieldEffects
import Popover

let RESET = false

class ViewController: UIViewController {

    //button variables
    @IBOutlet weak var AddDeviceButton: UIButton!
    @IBOutlet weak var DeviceListButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serNumField: UITextField!
    @IBOutlet weak var MFAField: UITextField!
    
    //person for cordata
    @objc var people = [Person]()
    @objc var displayStrings = [String]()
    
    //Device List popover variables
    fileprivate var devices = ["Change Name", "Refresh", "Delete Device", "Meghan", "King", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "end"]
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.down),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    
    @objc func lookupName(_ name: String) -> Person?
    {
        for p in people
        {
            if (name == p.name) { return p }
        }
        return nil
    }
    
    @objc func saveName(_ name: String) -> Person
    {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Person", in:managedContext)
        let person = Person(entity: entity!, insertInto: managedContext)
        
        person.name = name
        
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return person
    }

    //function to open list of devices (names) that ave been added (local data)
    @IBAction func openDeviceList(_ sender: Any) {
        var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 100))

        if((Double)(self.people.endIndex * 45) < Double(self.view.frame.height) - 100){
            let height = self.people.endIndex * 45
            tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: height))
        }
        
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.isScrollEnabled = true
        self.popover = Popover(options: self.popoverOptions)
        self.popover.show(tableView, fromView: self.DeviceListButton)
    }
    
    //add device name to local data, and device info to database
    @IBAction func addDevice(_ sender: Any) {
        
        let name = nameField.text
        let sn = serNumField.text
        let mfa = MFAField.text
        
        //Make sure all fields have a value, present error alert if not
        if(name == "" || sn == "" || mfa == ""){
            let alert = UIAlertController(title: "Error",
                                          message: "All fields must have a value",
                                          preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Close",
                                             style: .default,
                                             handler: { (action: UIAlertAction) -> Void in })
            
            alert.addAction(cancelAction)
            
            present(alert,
                    animated: true,
                    completion: nil)
            
        }
        //save the device information
        else {
            //save the device name to core data
            var d = self.lookupName(nameField.text!)
            
            //device with that name is already added
            if(d != nil){
                let alert = UIAlertController(title: "Error",
                                              message: "Device with name" + name! + "already exists",
                                              preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Close",
                                                 style: .default,
                                                 handler: { (action: UIAlertAction) -> Void in })
                
                alert.addAction(cancelAction)
                
                present(alert,
                        animated: true,
                        completion: nil)
            } else {
                d = self.saveName(nameField.text!)
                
                //TO-DO:
                // save the device name and info to the database
                
                //Tell user device has been added
                let alert = UIAlertController(title: name! + " sucessfully added",
                                              message: "Serial Num: " + sn! + "\nMFA code: " + mfa!,
                                              preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Close",
                                                 style: .default,
                                                 handler: { (action: UIAlertAction) -> Void in })
                
                alert.addAction(cancelAction)
                
                present(alert,
                        animated: true,
                        completion: nil)
                
                //clear the text fields
                nameField.text = ""
                serNumField.text = ""
                MFAField.text = ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            people = results as! [Person]
            
            if (RESET)
            {
                for p in people
                {
                    managedContext.delete(p)
                }
                try managedContext.save()
            }
        } catch let error as NSError {
            print("fetch or save failed \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.popover.dismiss()
        //TO DO:
        // add funtionality to buttons within popover
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.people.endIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.people[(indexPath as NSIndexPath).row].name
        return cell
    }
}

