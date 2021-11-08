//
//  RootTabBarController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppTabs()
        tabBar.barStyle = UIBarStyle.black
    }
    
    private func configureAppTabs() {
        var tabBarControllers: [UINavigationController] = []
        
        for appTab in AppTab.allCases {
            tabBarControllers.append(tabNavigationController(forTab: appTab))
        }
        
        viewControllers = tabBarControllers
    }
    
    private func tabNavigationController(forTab tab: AppTab) -> UINavigationController {
        let controller = UINavigationController(rootViewController: tab.rootViewController)
        controller.tabBarItem.title = tab.title
        return controller
    }
}
