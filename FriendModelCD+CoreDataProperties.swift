//
//  FriendModelCD+CoreDataProperties.swift
//  VK Personal
//
//  Created by Олег Алексеев on 27.09.2023.
//
//

import Foundation
import CoreData


extension FriendModelCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendModelCD> {
        return NSFetchRequest<FriendModelCD>(entityName: "FriendModelCD")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var photoData: Data?
    @NSManaged public var photoUrl: URL?
    @NSManaged public var surname: String?
    @NSManaged public var onlineStatus: Int16

}

extension FriendModelCD : Identifiable {

}
