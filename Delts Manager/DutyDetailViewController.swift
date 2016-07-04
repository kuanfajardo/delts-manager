//
//  DutyDetailViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/4/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class DutyDetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var dutyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    // MARK: Properties
    var dutyText = ""
    var dateText = ""
    var descriptionText = ""
    var image = UIImage()
    
    var duty: Duty?
    
    @IBAction func statusImagePressed(sender: UIButton) {
        // TODO: complete when available
        // TODO: make button area smaller
        print("status pressed")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dutyLabel.text = duty?.name
        self.dateLabel.text = duty?.dateString
        self.descriptionLabel.text = ""
        
        // TODO: Implement status enum here
        //self.statusImageView.image = UIImage(named: duty?.status)
        self.statusImageView.image = UIImage(named: "first")
        
        guard let controller = self.navigationController else {
            return
        }
        
        // TODO: Fund key
        controller.navigationBar.backItem?.backBarButtonItem?.setTitleTextAttributes(["key": Constants.Colors.deltsPurple], forState: UIControlState.Normal)
    }
}


