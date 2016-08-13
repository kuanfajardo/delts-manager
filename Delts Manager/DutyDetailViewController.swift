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
        
        
        self.statusImageView.image = imageFromStatus((self.duty?.status)!)
        
    }

    func imageFromStatus(status: DutyStatus) -> UIImage {
        switch status {
        case .Complete:
            return Constants.Photos.GreenCircle
        case .Punted:
            return Constants.Photos.RedCircle
        case .Pending:
            return Constants.Photos.YellowCircle
        case .Incomplete:
            return Constants.Photos.WhiteCircle
        }
    }
}


