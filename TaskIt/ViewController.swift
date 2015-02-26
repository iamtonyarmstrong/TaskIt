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
    var taskArray:[Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let date1 = Date.from(year: 2015, month: 01, day: 30)
        let date2 = Date.from(year: 2015, month: 02, day: 01)
        let date3 = Date.from(year: 2015, month: 02, day: 15)

        let taskOne:TaskModel = TaskModel(task:"Study French", subtask:"Verbs", date:date1)
        let taskTwo:TaskModel = TaskModel(task:"Study Calculus", subtask:"Differentials", date:date2)
        let taskThree:TaskModel = TaskModel(task:"Go grocery shopping", subtask:"Publix", date:date3)

        self.taskArray = [taskOne, taskTwo, taskThree]

    }

    // called when a viewController reappears as the main viewController presented to the screen AFTER initial load.
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

//        func sortByDate(#taskOne:TaskModel, taskTwo:TaskModel) -> Bool{
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }

        taskArray.sorted { (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
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
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TaskTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! TaskTableViewCell

        let task = self.taskArray[indexPath.row] as! TaskModel

        cell.taskLabel.text = task.task
        cell.subTaskLabel.text = task.subtask
        cell.dateLabel.text = Date.toString(date: task.date)

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }

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
            let indexRow = self.tableView.indexPathForSelectedRow()?.row
            let thisTask = self.taskArray[indexRow!]as! TaskModel
            detailVC.detailTaskObject = thisTask
        } else if(segue.identifier == "showAddTask"){
            let addTaskVC: AddNewTaskViewController = segue.destinationViewController as! AddNewTaskViewController
            addTaskVC.mainVC = self
        }

    }

    // MARK: - Helpers



}

