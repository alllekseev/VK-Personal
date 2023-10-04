//
//  GroupDate+CoreDataProperties.swift
//  VK Personal
//
//  Created by Олег Алексеев on 27.09.2023.
//
//

import Foundation
import CoreData


extension GroupDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupDate> {
        return NSFetchRequest<GroupDate>(entityName: "GroupDate")
    }

    @NSManaged public var date: Date?

}

extension GroupDate : Identifiable {

}
