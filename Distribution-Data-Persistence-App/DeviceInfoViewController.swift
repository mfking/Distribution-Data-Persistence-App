//
//  DeviceInfoViewController.swift
//  Distribution-Data-Persistence-App
//
//  Created by Meghan King on 11/3/17.
//  Copyright © 2017 Meghan King. All rights reserved.
//

import UIKit

class DeviceInfoViewController: UIViewController {

    @IBOutlet weak var mfaCode: UILabel!
    @IBOutlet weak var serNum: UILabel!
    @IBOutlet weak var deviceName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deviceName.text = selected
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
