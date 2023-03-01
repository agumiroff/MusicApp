//
//  MainTabBarController.swift
//  MusicApp
//
//  Created by G G on 06.12.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .clear
        tabBar.isTranslucent = true
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        setupApperance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupApperance(){
        let positionOnX      = 20.0
        let positionOnY      = 10.0
        let tabbarAppearance = CAShapeLayer()
        let bezierPath       = UIBezierPath(
            roundedRect: CGRect(
            x: positionOnX,
            y: positionOnY,
            width: tabBar.bounds.width - 2 * positionOnX,
            height: tabBar.bounds.height + positionOnY),
            cornerRadius: 10)
        
        tabBar.layer.insertSublayer(tabbarAppearance, at: 0)
        tabbarAppearance.path   = bezierPath.cgPath
        tabBar.itemWidth        = tabBar.bounds.width/4
        tabBar.tintColor        = .orange
        tabBar.backgroundColor  = .gray
    }
}
