//
//  KakaoTabbarController.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/22.
//

import UIKit

class KakaoTabbar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class KakaoTabbarController: UITabBarController {
    
    var defaultIndex = 0 {
        didSet {
            self.selectedIndex = defaultIndex
        }
    }
    
    private let clientTabbar = KakaoTabbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.selectedIndex = defaultIndex
        self.setValue(clientTabbar, forKey: "tabBar")
        object_setClass(self.tabBar, KakaoTabbar.self)
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.layer.cornerRadius = 20.adjusted
        self.tabBar.itemPositioning = .centered
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }
}

extension KakaoTabbarController : UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let friendViewController = FriendListViewController()
        let friendNavigationController =  UINavigationController(rootViewController: friendViewController)
        friendNavigationController.navigationBar.isHidden = true
        
        let chatViewController = PhotoGridViewController()
        let chatNavigationController = UINavigationController(rootViewController: chatViewController)
        chatNavigationController.navigationBar.isHidden = true
        
        let sharpViewController = SharpViewController()
        let sharpNavigationController = UINavigationController(rootViewController: sharpViewController)
        sharpNavigationController.navigationBar.isHidden = true
        
        let shopViewController = ShopViewController()
        let shopNavigationController = UINavigationController(rootViewController: shopViewController)
        shopNavigationController.navigationBar.isHidden = true
        
        let moreViewController = MoreViewController()
        let moreNavigationController = UINavigationController(rootViewController: moreViewController)
        moreNavigationController.navigationBar.isHidden = true
        
        
        let viewControllers = [
            friendNavigationController,
            chatNavigationController,
            sharpNavigationController,
            shopNavigationController,
            moreNavigationController
        ]
        
        self.setViewControllers(viewControllers, animated: true)
        
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = UIColor.white
        tabBar.barStyle = UIBarStyle.default
        tabBar.barTintColor = UIColor.white
        
        
        let imageNames = [
            "iconTabPersonUnfilled",
            "iconTabChatUnfilled",
            "iconTabSharpUnfilled",
            "iconTabShopUnfilled",
            "iconTabMoreUnfilled"
        ]
        
        let imageSelectedNames = [
            "iconTabPersonFilled",
            "iconTabChatFilled",
            "iconTabSharpFilled",
            "iconTabShopFilled",
            "iconTabMoreFilled"
        ]
        
        
        for (index, value) in (tabBar.items?.enumerated())! {
            let tabBarItem: UITabBarItem = value as UITabBarItem
            
            tabBarItem.image = UIImage(named: imageNames[index])?.withRenderingMode(.alwaysOriginal)
            tabBarItem.selectedImage = UIImage(named: imageSelectedNames[index])?.withRenderingMode(.alwaysOriginal)
            tabBarItem.accessibilityIdentifier = imageNames[index]
        }
    }
}
