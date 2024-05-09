//
//  CustomTabItemView.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 9/5/24.
//

import UIKit

class CustomTabItemView: UIView {
    let index: Int
    private let item: CustomTabBarItem
    private var callback: ((Int) -> Void)
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var isSelected: Bool = false {
        didSet {
            animateItems()
        }
    }
    
    init(with item: CustomTabBarItem, callback: @escaping (Int) -> Void) {
        self.item = item
        self.index = item.index
        self.callback = callback
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayoutConstraints()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        self.addSubview(containerView)
        containerView.addSubviews(nameLabel, iconImageView)
    }
    
    private func setupLayoutConstraints() {
        containerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        containerView.center(inView: self)
        
        nameLabel.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingBottom: 5)
        
        iconImageView.anchor(bottom: nameLabel.topAnchor, width: 24, height: 24)
        iconImageView.centerX(inView: self)
    }
    
    private func setupProperties() {
        nameLabel.configureWith(item.title,
                                color: .white.withAlphaComponent(0.4),
                                alignment: .center,
                                size: 11,
                                weight: .semibold)
        
        iconImageView.image = isSelected ? item.selectedIcon : item.icon
        
        self.addGestureRecognizer(tapGesture)
    }
    
    private func animateItems() {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.nameLabel.textColor = self.isSelected ? UIColor.orange : UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        }
        UIView.transition(with: iconImageView,
                          duration: 0.3,
                          options: .transitionCrossDissolve) { [unowned self] in
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
        }
    }
    
    @objc func handleTapGesture() {
        callback(item.index)
    }
    
}
