//
//  PartyDetailTableViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 8/3/16.
//  Copyright © 2016 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class PartyDetailTableViewController: UITableViewController, UITextFieldDelegate, MGSwipeTableCellDelegate {
    // MARK: Properties
    var event: Event?
    var segControl: UISegmentedControl?
    var segment: String {
        return (self.segControl!.titleForSegmentAtIndex((self.segControl?.selectedSegmentIndex)!))!
    }
    var numInvites: Int {
        return event!.invites.count
    }
    var invites: [Invite] {
        return event!.invites
    }
    var isKeyboardShowing = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segControl = UISegmentedControl(items: ["Invites", "Duties"])
        self.segControl!.addTarget(self, action: #selector(segmentChanged), forControlEvents: .ValueChanged)
        self.segControl!.tintColor = Constants.Colors.deltsDarkPurple
        self.segControl!.selectedSegmentIndex = 0
        self.navigationItem.titleView = self.segControl
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardDidShow), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardDidHide), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardDidShow() {
        self.isKeyboardShowing = true
    }
    
    func keyboardDidHide() {
        self.isKeyboardShowing = false
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        switch self.segment {
        case "Invites":
            loadInvites()
            break
        case "Duties":
            loadDuties()
            break
        default:
            break
        }
        
        reloadViews()
        self.tableView.reloadData()
    }
    
    func reloadViews() {
        /*switch self.segment {
         case "Duties":
         let tableView = UITableView()
         tableView.delegate = self
         self.view = tableView
         case "Invites": break
         //
         default:
         return
         }*/
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if self.segment == "Invites" {
            guard indexPath.row < self.numInvites else {
                guard indexPath.row < self.numInvites + 1 else {
                    let identifier = Constants.Identifiers.TableViewCells.PlainCell
                    let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
                    
                    if indexPath.row % 2 == 0 {
                        cell.backgroundColor = Constants.Colors.deltsPurple
                    } else {
                        cell.backgroundColor = Constants.Colors.deltsYellow
                    }
                    
                    cell.userInteractionEnabled = false
                    
                    return cell
                }
                
                let identifier = Constants.Identifiers.TableViewCells.NewInviteCell
                let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
                
                if indexPath.row % 2 == 0 {
                    cell.backgroundColor = Constants.Colors.deltsPurple
                } else {
                    cell.backgroundColor = Constants.Colors.deltsYellow
                }
                
                return cell
            }
            
            let identifier = Constants.Identifiers.TableViewCells.InviteCell
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PartyInviteTableViewCell
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = Constants.Colors.deltsPurple
            } else {
                cell.backgroundColor = Constants.Colors.deltsYellow
            }
            
            // right buttons
            let deleteButton = MGSwipeButton(title: "", icon: UIImage(named: Constants.Photos.Punt), backgroundColor: UIColor.redColor())
            cell.rightButtons = [deleteButton]
            cell.rightSwipeSettings.transition = .Rotate3D
            cell.delegate = self
            
            let invite = self.invites[indexPath.row]
            
            cell.invite = invite
            cell.inviteTextField.text = invite.inviteName
            cell.inviteTextField.delegate = self
            cell.deltTextField.text = invite.deltName
            cell.deltTextField.delegate = self
            if invite.inviteName == "" {
                cell.inviteTextField.becomeFirstResponder()
            }

            cell.selectionStyle = .None
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(15, self.numInvites + 1)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        guard isKeyboardShowing == false else {
            tableView.becomeFirstResponder()
            return
        }
        
        guard indexPath.row == numInvites else {
            return
        }
        
        addInvite()
        return
    }
    
    func addInvite() {
        self.event!.invites.append(Invite(invite: ""))
        self.tableView.reloadData()
    }
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text?.characters.count > 0 {
            textField.resignFirstResponder()
            self.event!.invites.removeLast()
            self.event!.invites.append(Invite(invite: textField.text!))
            //textField.userInteractionEnabled = false
            //self.tableView.reloadData()
            //self.tableView.userInteractionEnabled = true
            //print(invites)
            return true
        } else {
            //textField.text = "Loser"
            textField.resignFirstResponder()
            return true
        }
        
    }

    
    // MARK: - Navigation
    
    
    // Go to detail event view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
    }
    
    // MARK: Data Loading
    func loadInvites() {
        //
    }
    
    func loadDuties() {
        //
    }

    // MARK: MGSwipeTableCellDelegate
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        switch self.segment {
        case "Invites":
            print("delete invite")
            deleteInvite()
            break
        default:
            break
        }
        
        return true
    }
    
    
    // Actions
    func deleteInvite() {
        //
    }
}
