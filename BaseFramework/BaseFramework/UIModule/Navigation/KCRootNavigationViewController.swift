/*******************************************************************************
 # File        : KCRootNavigationViewController.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/8/27
 # Corporation : ****
 # Description : 对RTRootNavigationController的封装
 ******************************************************************************/

import UIKit

class KCRootNavigationViewController: RTRootNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}

extension KCRootNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
