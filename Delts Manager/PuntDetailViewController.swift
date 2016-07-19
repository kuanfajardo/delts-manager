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
    
    // MARK: Properties
    var punt: Punt?
    
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
        
        // TODO: Implement status enum here
        //self.statusImageView.image = UIImage(named: duty?.status)
        self.statusImageView.image = UIImage(named: Constants.Photos.BlackCircle)
        
        guard let controller = self.navigationController else {
            return
        }
        
        // TODO: Fund key
        controller.navigationBar.backItem?.backBarButtonItem?.setTitleTextAttributes(["key": Constants.Colors.deltsPurple], forState: UIControlState.Normal)
    }

}
