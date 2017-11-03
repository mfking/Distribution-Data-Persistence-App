//
//  ViewController.swift
//  Distribution-Data-Persistence-App
//
//  Created by Meghan King on 11/3/17.
//  Copyright © 2017 Meghan King. All rights reserved.
//

import UIKit
import CoreData

import TextFieldEffects
import Popover


class ViewController: UIViewController {

    //button variables
    @IBOutlet weak var AddDeviceButton: UIButton!
    @IBOutlet weak var DeviceListButton: UIButton!
    
    //Device List popover variables
    fileprivate var devices = ["Change Name", "Refresh", "Delete Device", "Meghan", "King", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "end"]
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.down),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //function to open list of devices (names) that ave been added (local data)
    @IBAction func openDeviceList(_ sender: Any) {
        var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 100))

        if((Double)(self.devices.endIndex * 45) < Double(self.view.frame.height) - 100){
            let height = self.devices.endIndex * 45
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
        return self.devices.endIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.devices[(indexPath as NSIndexPath).row]
        return cell
    }
}

