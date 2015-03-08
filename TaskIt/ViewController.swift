//
//  ViewController.swift
//  TaskIt
//
//  Created by Anthony Armstrong on 1/20/15.
//  Copyright (c) 2015 openinformant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var incompleteTaskArray:[TaskModel] = []
    var completeTaskArray:[TaskModel] = []
    var baseArray:[[TaskModel]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


    }

    // called when a viewController reappears as the main viewController presented to the screen AFTER initial load.
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.baseArray[0] = baseArray[0].sorted { (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }


        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - TableView Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.baseArray.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseArray[section].count
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "To Do"
        } else {
            return "Completed"
        }

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TaskTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! TaskTableViewCell

        let task = self.baseArray[indexPath.section][indexPath.row] as TaskModel

        cell.taskLabel.text = task.task
        cell.subTaskLabel.text = task.subtask
        cell.dateLabel.text = Date.toString(date: task.date)

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        let thisTask = self.baseArray[indexPath.section][indexPath.row]     //grab the selected item from the array
        var newTask:TaskModel

        //handle moving TaskModels from completed to uncompleted and back
        if indexPath.section == 0 {
            newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, isCompleted: true)
            self.baseArray[1].append(newTask)       //add item to complete array

        } else {
            newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, isCompleted: false)
            self.baseArray[0].append(newTask)       //add item to complete array
        }

        self.baseArray[indexPath.section].removeAtIndex(indexPath.row)  //remove item from incomplete array

        self.tableView.reloadData()

    }

    //MARK: - Helper Functions

    @IBAction func addButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showAddTask", sender: self)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.

        if (segue.identifier == "showTaskDetail"){
            let detailVC:TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            detailVC.mainVC = self

            //create the section and row
            let indexSection = self.tableView.indexPathForSelectedRow()?.section
            let indexRow = self.tableView.indexPathForSelectedRow()?.row

            //use the section and row to access the actual TaskModel object
            let thisTask = self.baseArray[indexSection!][indexRow!] as TaskModel
            detailVC.detailTaskObject = thisTask
        } else if(segue.identifier == "showAddTask"){
            let addTaskVC: AddNewTaskViewController = segue.destinationViewController as! AddNewTaskViewController
            addTaskVC.mainVC = self
        }

    }

    // MARK: - Helpers



}

