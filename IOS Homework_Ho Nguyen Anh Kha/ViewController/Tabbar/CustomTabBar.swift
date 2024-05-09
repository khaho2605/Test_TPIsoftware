//
//  CustomTabBar.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 9/5/24.
//

import UIKit

class CustomTabBar: UIStackView {
    
    //Tab Bar Items
    private let tabBarTabs: [CustomTabBarItem]
    
    private var customTabItemViews: [CustomTabItemView] = []
    
    var onTabSelected: ((Int) -> Void)
    
    init(tabBarTabs: [CustomTabBarItem], onTabSelected: @escaping ((Int) -> Void)) {
        self.tabBarTabs = tabBarTabs
        self.onTabSelected = onTabSelected
        super.init(frame: .zero)
        
        setupTabBartabs()
        setupHierarchy()
        setupProperties()
                
        self.setNeedsLayout()
        self.layoutIfNeeded()
        selectItem(index: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBartabs() {
        self.tabBarTabs.forEach { tabBarItem in
            customTabItemViews.append(CustomTabItemView(with: tabBarItem, callback: { index in
                self.selectItem(index: index)
            }))
        }
    }
    
    private func setupHierarchy() {
        addArrangedSubviews(customTabItemViews)
    }
    
    private func setupProperties() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .center
        
        self.backgroundColor = UIColor.white
        setupCornerRadius(25)
        
        customTabItemViews.forEach { tab in
            tab.anchor(top: self.topAnchor, bottom: self.bottomAnchor)
            tab.clipsToBounds = true
        }
    }
    
    private func selectItem(index: Int) {
        customTabItemViews.forEach { item in
            item.isSelected = item.index == index
        }
        onTabSelected(index)
    }
}
