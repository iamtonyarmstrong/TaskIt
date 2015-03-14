//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Anthony Armstrong on 1/25/15.
//  Copyright (c) 2015 openinformant. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var statusLabel: UILabel!

    var detailTaskObject:TaskModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println(self.detailTaskObject!.task)
        self.taskTextField.text = self.detailTaskObject.task
        self.subTaskTextField.text = self.detailTaskObject.subTask
        self.datePicker.date = self.detailTaskObject.date

        var statusTextColor:UIColor
        var statusText = ""

        if self.detailTaskObject.isCompleted == false {
            statusTextColor = UIColor.redColor()
            statusText = "INCOMPLETE"
        } else {
            statusTextColor = UIColor.greenColor()
            statusText = "COMPLETE"
        }

        self.statusLabel.textColor = statusTextColor
        self.statusLabel.text = "Status: " + statusText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {

        // Inside navigation controller, so we have access to navigationController. We can pop 
        // the "top" viewController off the stack to go backwards.
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func doneButtonTapped(sender: AnyObject) {
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        self.detailTaskObject.task = self.taskTextField.text
        self.detailTaskObject.subTask = self.subTaskTextField.text
        self.detailTaskObject.date = self.datePicker.date
        self.detailTaskObject.isCompleted = detailTaskObject.isCompleted

        appDelegate.saveContext()

        self.navigationController?.popViewControllerAnimated(true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
