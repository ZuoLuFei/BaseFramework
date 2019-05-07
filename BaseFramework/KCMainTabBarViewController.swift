/*******************************************************************************
 # File        : KCMainTabBarViewController.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/8/20
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

class KCMainTabBarViewController: UITabBarController {
    private let titles = [
        "首页",
        "行情",
        "资产",
        "我的"
    ]

//    private let defaultImgs = [
//        "tab_home_normal",
//        "tab_market_normal",
//        "tab_assets_normal",
//        "tab_discovery_normal",
//        "tab_mine_normal"
//    ]
//
//    private let selectedImgs = [
//        "tab_home_selected",
//        "tab_market_selected",
//        "tab_assets_selected",
//        "tab_discovery_selected",
//        "tab_mine_selected"
//    ]

    private var tabVCs: [UIViewController] = [
        ViewController(),
        ViewController(),
        ViewController(),
        ViewController()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        _configUI()
    }

    func changeCurrentTab(_ index: Int) {
        self.selectedIndex = index
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// 配置tabBarController
extension KCMainTabBarViewController {
    private func _configUI() {
        tabVCs = tabVCs.map({ (vc) -> KCRootNavigationViewController in
            let root = KCRootNavigationViewController(rootViewController: vc)
            return root
        })
        for (index, vc) in tabVCs.enumerated() {
            let item = UITabBarItem()
            item.title = titles[index]
//            item.image = UIImage(named: defaultImgs[index])?.withRenderingMode(.alwaysOriginal)
//            item.selectedImage = UIImage(named: selectedImgs[index])?.withRenderingMode(.alwaysOriginal)

            vc.tabBarItem = item
        }
        self.setViewControllers(tabVCs, animated: false)
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.isTranslucent = false
        self.delegate = self
    }
}

// MARK: - UITabBarControllerDelegate
extension KCMainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
