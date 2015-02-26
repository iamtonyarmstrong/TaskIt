//
//  Date.swift
//  TaskIt
//
//  Created by Anthony Armstrong on 1/26/15.
//  Copyright (c) 2015 openinformant. All rights reserved.
//

import Foundation

class Date {

    class func from(#year:Int, month:Int, day:Int) -> NSDate {

        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day

        // create a date object using NSCalendar
        var gregorianCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components)

        return date!
    }

    class func toString(#date: NSDate) -> String {

        // create a date formatter
        let dateStringFormatter:NSDateFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "YYYY-MM-dd"

        // make a string representing the date using the date formatter
        let dateString = dateStringFormatter.stringFromDate(date)

        return dateString
    }

}
