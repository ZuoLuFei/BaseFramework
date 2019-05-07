/*******************************************************************************
 # File        : KRActivityIndicatorView.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/19
 # Corporation : ****
 # Description :
 <#Description Logs#>
 ******************************************************************************/

import UIKit

class KRActivityIndicatorView: UIView {

    private var indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    func startAnimating() {

        indicatorView.center = CGPoint(x: CGFloat(self.bounds.size.width * 0.5),
                                       y: CGFloat(self.bounds.size.height * 0.5))
        self.addSubview(indicatorView)
        indicatorView.startAnimating()
    }

    func stopAnimating() {
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
//        self.removeFromSuperview()
    }

}
