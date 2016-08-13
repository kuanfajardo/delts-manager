//
//  PuntDetailViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/4/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class PuntDetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var puntLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var givenByLabel: UILabel!
    @IBOutlet weak var slaveLabel: UILabel!
    @IBOutlet weak var slaveTitleLabel: UILabel!
    
    // MARK: Properties
    var punt: Punt?
    var role: Int?
    
    @IBAction func statusImagePressed(sender: UIButton) {
        // TODO: complete when available
        // TODO: make button area smaller
        print("punt status pressed")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.puntLabel.text = punt?.name
        self.dateLabel.text = punt?.dateString
        self.givenByLabel.text = punt?.givenBy
        self.descriptionLabel.text = ""
        self.slaveLabel.text = punt?.slave
        
        if self.role == 0 {
            self.slaveLabel.hidden = true
            self.slaveTitleLabel.hidden = true
        }
        
        // TODO: Implement status enum here
        self.statusImageView.image = imageFromStatus((self.punt?.status)!)
        
        guard let controller = self.navigationController else {
            return
        }
        
        // TODO: Fund key
        controller.navigationBar.backItem?.backBarButtonItem?.setTitleTextAttributes(["key": Constants.Colors.deltsPurple], forState: UIControlState.Normal)
    }
    
    func imageFromStatus(status: PuntStatus) -> UIImage {
        switch status {
        case .JustThere:
            return Constants.Photos.WhiteCircle
        case .Madeup:
            return Constants.Photos.GreenCircle
        case .MakeupRequested:
            return Constants.Photos.YellowCircle
        }
    }

}
