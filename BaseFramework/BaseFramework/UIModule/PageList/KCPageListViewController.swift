/*******************************************************************************
 # File        : KCPageListViewController.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/6
 # Corporation : ****
 # Description : 列表页面基类，封装的tableView，以及空数据占位视图
 ******************************************************************************/

import UIKit

protocol KCPageListViewControllerDelegate: NSObjectProtocol {
    func pageListViewControllerDidScroll(_ scrollView: UIScrollView)
}

class KCPageListViewController: KCBaseViewController {
    weak var tableView: UITableView!
    weak var emptyView: KCEmptyView?

    weak var pageListDelegate: KCPageListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        _configUI()
        _configData()
    }
}

// MARK: - 初始化UI
extension KCPageListViewController {
    private func _configUI() {
        _initTableView()
        _initEmptyView()
    }

    private func _initTableView() {
        let tableView = UITableView(frame: CGRect.zero)
        view.addSubview(tableView)
        self.tableView = tableView
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    private func _initEmptyView() {
        let emptyView = KCEmptyView()
        self.emptyView = emptyView
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        emptyView.isHidden = true
    }
}

extension KCPageListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageListDelegate?.pageListViewControllerDidScroll(scrollView)
    }
}

// MARK: - 初始化Data
extension KCPageListViewController {
    private func _configData() {
    }
}
