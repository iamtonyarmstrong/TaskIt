//
//  AddNewTaskViewController.swift
//  TaskIt
//
//  Created by Anthony Armstrong on 1/28/15.
//  Copyright (c) 2015 openinformant. All rights reserved.
//

import UIKit

class AddNewTaskViewController: UIViewController, UITextFieldDelegate {

    var mainVC:ViewController!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var addSubtaskTextField: UITextField!
    @IBOutlet weak var addDatePicker: UIDatePicker!
    @IBOutlet weak var saveTaskButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveTaskButtonTapped(sender: UIButton) {
        let task:TaskModel = TaskModel(task:self.addTaskTextField.text, subtask: self.addSubtaskTextField.text, date: self.addDatePicker.date, isCompleted:false)
        mainVC.incompleteTaskArray.append(task)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    // Hide the keyboard when touched outside of the text fields or date picker
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
