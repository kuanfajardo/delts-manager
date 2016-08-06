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
    @IBOutlet weak var slaveLabel: UILabel!
    @IBOutlet weak var slaveTitleLabel: UILabel!
    
    // MARK: Properties
    var duty: Duty?
    var role: Int?
    
    @IBAction func statusImagePressed(sender: UIButton) {
        // TODO: complete when available
        // TODO: make button area smaller
        print("duty status pressed")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dutyLabel.text = duty?.name
        self.dateLabel.text = duty?.dateString
        self.descriptionLabel.text = ""
        self.slaveLabel.text = duty?.slave
        
        if self.role == 0 {
            self.slaveTitleLabel.hidden = true
            self.slaveLabel.hidden = true
        }
        
        // TODO: Implement status enum here
        //self.statusImageView.image = UIImage(named: duty?.status)
        self.statusImageView.image = Constants.Photos.BlackCircle
        
        /*
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Duties", style: .Plain, target: self, action: #selector(backPressed))*/
    }
    
    func backPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}


