/*******************************************************************************
 # File        : UIScrollView+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

extension UIScrollView {
    func setRefreshHeader(_ action: (() -> Void)?) {
        let header = MJRefreshNormalHeader(refreshingBlock: {
            action?()
        })
        header?.activityIndicatorViewStyle = .white
        self.mj_header = header
    }

    func setRefreshFooter(_ action: (() -> Void)?) {
        self.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            action?()
        })
    }

    func endHeaderRefresh() {
        mj_header.endRefreshing()
    }

    func endFooterRefresh(_ noMoreData: Bool = false) {
        if noMoreData {
            self.mj_footer.endRefreshingWithNoMoreData()
        } else {
            self.mj_footer.endRefreshing()
        }
    }

    func beginRefreshing() {
        mj_header.beginRefreshing()
    }
}
