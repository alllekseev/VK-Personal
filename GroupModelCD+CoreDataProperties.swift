//
//  GroupModelCD+CoreDataProperties.swift
//  VK Personal
//
//  Created by Олег Алексеев on 28.09.2023.
//
//

import Foundation
import CoreData


extension GroupModelCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupModelCD> {
        return NSFetchRequest<GroupModelCD>(entityName: "GroupModelCD")
    }

    @NSManaged public var caption: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var photoData: Data?
    @NSManaged public var photoUrl: URL?

}

extension GroupModelCD : Identifiable {

}
