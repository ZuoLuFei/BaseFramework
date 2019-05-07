/*******************************************************************************
 # File        : KCBaseViewController.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/10
 # Corporation : ****
 # Description : 控制器基类
 -------------------------------------------------------------------------------
 ******************************************************************************/

import UIKit
import RxCocoa
import RxSwift

open class KCBaseViewController: UIViewController {

    private var naviTitleLab: UILabel?

    var disposeBag = DisposeBag()

    var clearNavigationBar: Bool = false {
        didSet {
            guard clearNavigationBar else { return }
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }

    override open var title: String? {
        didSet {
            _updateTitle(title)
        }
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /**
     * 配置导航栏右按钮，传入按钮名
     */
    @discardableResult
    func configRightNavigationItem(_ title: String, _ actionBlock: (() -> Void)? = nil) -> UIButton {
        let btn = UIButton()
        btn.contentHorizontalAlignment = .right
        btn.hc_SetTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.rx.controlEvent(.touchUpInside).asObservable().subscribe(onNext: { (_) in
            actionBlock?()
        }).disposed(by: disposeBag)

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        container.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(0)
            make.trailing.equalTo(container.snp.trailing).offset(4)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: container)

        return btn
    }

    func configRightNavigationImageItem(_ icon: String, _ actionBlock: (() -> Void)? = nil) {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        btn.setImage(UIImage(named: icon), for: .normal)
        btn.contentHorizontalAlignment = .right
        btn.rx.controlEvent(.touchUpInside).asObservable().subscribe(onNext: { (_) in
            actionBlock?()
        }).disposed(by: disposeBag)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        _configUI()
    }

    deinit {
        KCLog.info("\(self) 释放")
    }

    /**
     * 处理导航返回事件
     */
    @objc func handleBack() {
        navigationController?.popViewController()
    }
}

// MARK: - UI
extension KCBaseViewController {
    private func _configUI() {
        _configCommonUI()

        if self != navigationController?.viewControllers.first {
            _configNaviBack()
        }
    }

    private func _configCommonUI() {
//        view.kcBackgroundColor = .pageBg

        let color = UIColor.hex(value: 0x171f29)
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: color, size: CGSize(width: 20, height: 20)), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        self.rt_disableInteractivePop = false
    }

    private func _configNaviBack() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: container)

        let naviBack = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        naviBack.setImage(UIImage(named: "navi_back"), for: .normal)
        naviBack.contentHorizontalAlignment = .left
        naviBack.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        container.addSubview(naviBack)
    }

    private func _updateTitle(_ title: String?) {
        guard let title = title else { return }

        if naviTitleLab == nil {
            let titleLab = UILabel()
            titleLab.frame = CGRect(x: 0, y: 0, width: 180, height: 44)
            titleLab.textColor = UIColor.black
            titleLab.font = UIFont.pingFangMediumWith(size: 18)
            titleLab.textAlignment = .center
            navigationItem.titleView = titleLab
            self.naviTitleLab = titleLab
        }

        naviTitleLab?.text = title
    }
}

// MARK: - Data
extension KCBaseViewController {
}

// MARK: - 私有方法
extension KCBaseViewController {
}
