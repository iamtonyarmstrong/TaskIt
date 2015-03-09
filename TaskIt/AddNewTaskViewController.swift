//
//  AddNewTaskViewController.swift
//  TaskIt
//
//  Created by Anthony Armstrong on 1/28/15.
//  Copyright (c) 2015 openinformant. All rights reserved.
//

import UIKit
import CoreData

class AddNewTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var mainVC:ViewController!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var addSubtaskTextField: UITextField!
    @IBOutlet weak var addDatePicker: UIDatePicker!
    @IBOutlet weak var saveTaskButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addTaskTextField.delegate = self
        self.addSubtaskTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveTaskButtonTapped(sender: UIButton) {

        // Instatiate Core Data objects for creating TaskModels
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task:TaskModel = TaskModel(entity:entityDescription!, insertIntoManagedObjectContext:managedObjectContext!)

        // Get user-entered values and save to TaskModel instance
        task.task = self.addTaskTextField.text
        task.subTask = self.addSubtaskTextField.text
        task.date = self.addDatePicker.date
        task.isCompleted = false

        // Save the context - the context is what you're actually saving
        appDelegate.saveContext()

        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil

        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!

        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    // Hide the keyboard when touched outside of the text fields or date picker
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    // Hidr keyboard when user taps ENTER key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return self.view.endEditing(true)
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
