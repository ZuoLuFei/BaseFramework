/*******************************************************************************
 # File        : KCActionSheet.swift
 # Project     : Dialog
 # Author      : &&&&
 # Created     : 2018/8/17
 # Corporation : ****
 # Description : 模仿系统的UIActionSheet, KCBaseDialog子类
 ******************************************************************************/

import UIKit

class KCActionSheet: KCBaseDialog, UITableViewDataSource, UITableViewDelegate {
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero)
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
//        view.kcBackgroundColor = KCTheme.Color.moduleBg
        view.register(UINib(nibName: "KCActionSheetCell", bundle: nil), forCellReuseIdentifier: "cell")
        return view
    }()

    private let cellHeight: CGFloat = 48
    private var datas: [Any] = []
    private var complection: ((_ index: Int) -> Void)?

    private var selectedIndex: Int = 0

    /**
     * datas目前支持两种类型：[String] or [(icon: String, title: String)]
     * 文本弹窗 和 图文弹窗
     */
    static func show(_ datas: [Any], selectedIndex: Int = 0, complection: ((_ index: Int) -> Void)? = nil) {
        let instance = KCActionSheet()
        instance.datas = datas
        instance.complection = complection
        instance.selectedIndex = selectedIndex
        instance.show()
    }

    override func show() {
        let tableViewHeight = cellHeight * CGFloat(datas.count) + Screen.bottomDangerAreaHeight
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: tableViewHeight)

        let screenHeight = UIScreen.main.bounds.size.height
        var frame = tableView.frame
        frame.origin.y = screenHeight * 2 - tableViewHeight
        frame.size.height = tableViewHeight
        contentView.frame = frame
        contentView.addSubview(tableView)

        super.show()
    }

    // MARK: - table view dataSource & delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? KCActionSheetCell else {
            return UITableViewCell()
        }
        if let data = datas[indexPath.row] as? String {
            cell.iconIV.isHidden = true
            cell.titleLab.textAlignment = .center
            cell.titleLab.text = data
            cell.titleLeadingConstraint.constant = 16
        } else if let data = datas[indexPath.row] as? (String, String) {
            cell.iconIV.isHidden = false
            cell.iconIV.image = UIImage(named: data.0)
            cell.titleLab.textAlignment = .left
            cell.titleLab.text = data.1
            cell.titleLeadingConstraint.constant = 44 //16 + 28
        } else {
            cell.iconIV.isHidden = true
            cell.titleLab.text = ""
        }

        cell.titleLab.textColor = indexPath.row == selectedIndex ? .red : .black
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        complection?(indexPath.row)
        hide()
    }
}
