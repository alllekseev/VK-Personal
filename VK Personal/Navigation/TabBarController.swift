//
//  TabBarController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case friends
    case groups
    case photos
}

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
    }

    private func configureAppearance() {
        tabBar.tintColor = Colors.main
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = true


        let controllers: [NavBarController] = Tabs.allCases.map { tab in
            let controller = NavBarController(
                rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(
                title: Strings.TabBar.title(for: tab),
                image: Icons.TabBarIcons.icon(for: tab),
                tag: tab.rawValue)
            
            return controller
        }

        setViewControllers(controllers, animated: false)

        
    }

    private func getController(for tab: Tabs) -> UIViewController {
        switch tab {
        case .friends: return FriendsTableViewController(style: .insetGrouped)
        case .groups: return GroupsTableViewController(style: .insetGrouped)
        case .photos: return PhotosCollectionViewController(collectionViewLayout: UICollectionViewLayout())
        }
    }
}
