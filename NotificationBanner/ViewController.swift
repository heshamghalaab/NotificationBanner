//
//  ViewController.swift
//  NotificationBanner
//
//  Created by hesham ghalaab on 5/20/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showBanner(_ sender: UIButton) {
        let banner = NotificationBanner()
        banner.show("No Internet Connection!")
    }
    
}

