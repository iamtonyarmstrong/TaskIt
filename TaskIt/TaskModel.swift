//
//  TaskModel.swift
//  TaskIt
//
//  Created by Anthony Armstrong on 3/8/15.
//  Copyright (c) 2015 openinformant. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var isCompleted: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subTask: String
    @NSManaged var task: String

}
