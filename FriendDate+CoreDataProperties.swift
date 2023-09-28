//
//  FriendDate+CoreDataProperties.swift
//  VK Personal
//
//  Created by Олег Алексеев on 27.09.2023.
//
//

import Foundation
import CoreData


extension FriendDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendDate> {
        return NSFetchRequest<FriendDate>(entityName: "FriendDate")
    }

    @NSManaged public var date: Date?

}

extension FriendDate : Identifiable {

}
