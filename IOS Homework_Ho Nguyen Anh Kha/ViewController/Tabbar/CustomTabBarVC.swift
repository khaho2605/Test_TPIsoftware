//
//  CustomTabBarVC.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 9/5/24.
//

import Foundation

import UIKit

final class CustomTabBarVC: UITabBarController {
    
    private var normalColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
    private var selectedColor = UIColor(red: 255/255, green: 136/255, blue: 97/255, alpha: 1)
    
    private lazy var tabBarTabs = [CustomTabBarItem]()
    
    private var customTabBar: CustomTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        setupHierarchy()
        setupLayoutConstraints()
        setupProperties()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupCustomTabBar() {
        //Home tab
        let profileTab = CustomTabBarItem(
            index: 0,
            title: "Profile",
            icon: UIImage(systemName: "house")?.withTintColor(normalColor, renderingMode: .alwaysOriginal),
            selectedIcon: UIImage(systemName: "house.fill")?.withTintColor(selectedColor, renderingMode: .alwaysOriginal),
            viewController: HomeViewController())
        
        //Account Tab
        let accountTab = CustomTabBarItem(
            index: 1,
            title: "Account",
            icon: UIImage(systemName: "person.crop.circle")?.withTintColor(self.normalColor, renderingMode: .alwaysOriginal),
            selectedIcon: UIImage(systemName: "person.crop.circle.fill")?.withTintColor(selectedColor, renderingMode: .alwaysOriginal),
            viewController: AccountViewController())
        
        //Location Tab
        let locationTab = CustomTabBarItem(
            index: 2,
            title: "Location",
            icon: UIImage(systemName: "map")?.withTintColor(normalColor, renderingMode: .alwaysOriginal),
            selectedIcon: UIImage(systemName: "map.fill")?.withTintColor(selectedColor, renderingMode: .alwaysOriginal),
            viewController: LocationViewController())
       
        //Service Tab
        let serviceTab = CustomTabBarItem(
            index: 3,
            title: "Service",
            icon: UIImage(systemName: "person.2")?.withTintColor(normalColor, renderingMode: .alwaysOriginal),
            selectedIcon: UIImage(systemName: "person.2.fill")?.withTintColor(selectedColor, renderingMode: .alwaysOriginal),
            viewController: ServiceViewController())
        
        tabBarTabs = [profileTab, accountTab, locationTab, serviceTab]
        
        self.customTabBar = CustomTabBar(tabBarTabs: tabBarTabs, onTabSelected: { [weak self] index in
            self?.selectTabWith(index: index)
        })
    }
    
    private func setupHierarchy() {
        view.addSubview(customTabBar)
    }
    
    private func setupLayoutConstraints() {
        customTabBar.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.safeAreaLayoutGuide.rightAnchor,
                            paddingLeft: 24,
                            paddingRight: 24,
                            height: 50)
    }
    
    private func setupProperties() {
        tabBar.isHidden = true
        customTabBar.addShadow()
        
        self.selectedIndex = 0
        let controllers = tabBarTabs.map { item in
            return item.viewController
        }
        self.setViewControllers(controllers, animated: true)
    }
    
    private func selectTabWith(index: Int) {
        self.selectedIndex = index
    }
}
