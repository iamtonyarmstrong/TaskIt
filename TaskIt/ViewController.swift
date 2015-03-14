//
//  ViewController.swift
//  TaskIt
//
//  Created by Anthony Armstrong on 1/20/15.
//  Copyright (c) 2015 openinformant. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

    let moc = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Get the fetchedResultsController from the helper function below and perform a fetch operation
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)


    }

    // called when a viewController reappears as the main viewController presented to the screen AFTER initial load.
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)



        /* self.baseArray[0] = baseArray[0].sorted { (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        self.tableView.reloadData()
        */
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - TableView Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
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
        var cell: TaskTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as TaskTableViewCell

        let task = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel

        cell.taskLabel.text = task.task
        cell.subTaskLabel.text = task.subTask
        cell.dateLabel.text = Date.toString(date: task.date)

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        var thisTask:TaskModel = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel     //grab the selected item from CoreData


        //handle moving TaskModels from completed to uncompleted and back
        if indexPath.section == 0 {
            thisTask.isCompleted = true
        } else {
            thisTask.isCompleted = false
        }

        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()

    }

    //MARK: - Helper Functions

    @IBAction func addButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showAddTask", sender: self)
    }


    // Create a fetch request and sort Descriptor
    func taskFetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let completedDescriptor = NSSortDescriptor(key: "isCompleted", ascending: true)
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor, completedDescriptor]

        return fetchRequest
    }


    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }

    // 
    func getFetchResultsController() -> NSFetchedResultsController {
       fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: moc, sectionNameKeyPath: "isCompleted", cacheName: nil)

        return fetchedResultsController

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.

        if (segue.identifier == "showTaskDetail"){
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController

            //create the section and row
            let indexPath = self.tableView.indexPathForSelectedRow()?

            //use the section and row to access the actual TaskModel object
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            detailVC.detailTaskObject = thisTask
        } else if(segue.identifier == "showAddTask"){
            let addTaskVC: AddNewTaskViewController = segue.destinationViewController as AddNewTaskViewController
        
        }

    }

    // MARK: - Helpers



}

