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
        tabBar.barTintColor = Colors.mainInactive
        tabBar.backgroundColor = .white

        tabBar.layer.borderColor = Colors.textPlaceholder.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true


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
        case .friends: return FriendsTableViewController()
        case .groups: return GroupsTableViewController()
        case .photos: return PhotosCollectionViewController(
            collectionViewLayout: UICollectionViewFlowLayout())
        }
    }
}
