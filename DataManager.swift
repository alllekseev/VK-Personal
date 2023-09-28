//
//  DataManager.swift
//  VK Personal
//
//  Created by Олег Алексеев on 27.09.2023.
//

import Foundation
import CoreData
import OSLog

// CRUD
final class DataManager {
    let logger = Logger()

    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { (_, error)  in
            if let error {
                self.logger.error("\(error.localizedDescription)")
            }
        }
        return persistentContainer
    }()

    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nsError = error as NSError
                logger.error("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func delete(object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }

    // MARK: - Friends
    func addFriends(friends: [Friend]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendModelCD")
        for friend in friends {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [friend.id])
            let result = try? context.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }

            let friendModel = FriendModelCD(context: context)
            friendModel.id = Int32(friend.id)
            friendModel.name = friend.name
            friendModel.surname = friend.surname
            friendModel.photoUrl = friend.photoUrl
            friendModel.photoData = friend.photoData
            friendModel.onlineStatus = Int16(friend.onlineStatus.rawValue)
        }
        saveContext()
        addFriendDate()
    }

    func fetchFriends() -> [Friend] {
        let fetchRequest: NSFetchRequest<FriendModelCD> = FriendModelCD.fetchRequest()

        guard let friends = try? context.fetch(fetchRequest) else {
            return []
        }

        var newFriends: [Friend] = []
        friends.forEach { friend in
            newFriends.append(Friend(id: Int(friend.id),
                                     onlineStatus: OnlineStatus(rawValue: Int(friend.onlineStatus))
                                        ?? OnlineStatus.offline,
                                     photoUrl: friend.photoUrl,
                                     photoData: friend.photoData))
        }
        return newFriends
    }

    func addFriendDate() {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendDate")
        let date = FriendDate(context: context)
        date.date = Date()
        saveContext()
    }

    func fetchFriendDate() -> Date? {
        let fetchRequest: NSFetchRequest<FriendDate> = FriendDate.fetchRequest()
        guard let date = try?
                context.fetch(fetchRequest) else {
            return nil
        }
        return date.first?.date
    }

    //MARK: - Groups

    func addGroupDate(groups: [Group]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupModelCD")
        for group in groups {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [group.id])
            let result = try? context.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }

            let friendModel = GroupModelCD(context: context)
            friendModel.id = Int32(group.id)
            friendModel.name = group.name
            friendModel.caption = group.description
            friendModel.photoUrl = group.photoUrl
            friendModel.photoData = group.photoData
        }
        saveContext()
        addGroupDate()
    }

    func fetchGroups() -> [Group] {
        let fetchRequest: NSFetchRequest<GroupModelCD> = GroupModelCD.fetchRequest()

        guard let groups = try? context.fetch(fetchRequest) else {
            return []
        }

        var newGroups: [Group] = []
        groups.forEach { group in
            newGroups.append(Group(id: Int(group.id),
                                   photoUrl: group.photoUrl,
                                   photoData: group.photoData,
                                   name: group.name,
                                   description: group.caption))
        }
        return newGroups
    }

    func addGroupDate() {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendDate")
        let date = GroupDate(context: context)
        date.date = Date()
        saveContext()
    }

    func fetchGroupDate() -> Date? {
        let fetchRequest: NSFetchRequest<GroupDate> = GroupDate.fetchRequest()
        guard let date = try?
                context.fetch(fetchRequest) else {
            return nil
        }
        return date.first?.date
    }
}
