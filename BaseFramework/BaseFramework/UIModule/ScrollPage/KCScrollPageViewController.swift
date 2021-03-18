/*******************************************************************************
 # File        : KCScrollPageViewController.swift
 # Project     : KCUIKit
 # Author      : &&&&
 # Created     : 2018/8/20
 # Corporation : ****
 # Description : 横向滚动容器类，控制标题切换逻辑，子VC切换逻辑

 实例代码:

 let pageVC = KCScrollPageViewController(.equal)  // 顶部title的样式，通过传入的枚举类型决定，默认是左对齐样式，目前还支持均分样式
 let titles = ["BTC", "ETH", "USDT", "NEO", "KCS"]
 let vcs = [
     KCTradeFeedListViewController(),
     KCTradeFeedListViewController(),
     KCTradeFeedListViewController(),
     KCTradeFeedListViewController(),
     KCTradeFeedListViewController()
 ]
 pageVC.update(titles: titles,
 vcs: vcs)
 self.addChildViewController(pageVC)

 view.addSubview(pageVC.view)

 ******************************************************************************/

import UIKit

/**
 * 页面切换时的协议
 */
protocol KCScrollable: NSObjectProtocol {
    func scrollPageDidScrollToCurrent()  // 滚动到当前页面
    func scrollPageDidLeaveCurrent()     // 离开当前页面
}

/**
 * KCScrollPageViewController 代理方法
 */
protocol KCScrollPageViewControllerDelegate: NSObjectProtocol {
    func scrollPageViewControllerDidScroll(_ index: Int) // 页面切换代理
}

class KCScrollPageViewController: UIViewController {
    private(set) lazy var titleScrollView = UIScrollView()
    private lazy var vcScrollView = UIScrollView()

    private lazy var titleIndexer: UIView = {
        let indexer = UIView()
        indexer.backgroundColor = UIColor.hex(value: 0x0F7DFF)
        indexer.frame = CGRect(x: 0, y: 38, width: 10, height: 2)
        indexer.layer.cornerRadius = 1
        return indexer
    }()
    private lazy var titleItemViews: [UIButton] = []

    private var titleViewType: TitleViewType = .left

    var titleSubToolBar: UIView? { // 标题滚动视图，下面自定义的扩展工具栏
        didSet {
            guard let toolBar = titleSubToolBar else { return }
            view.addSubview(toolBar)
        }
    }
    var titleContentSpace: CGFloat = 0
    weak var delegate: KCScrollPageViewControllerDelegate?

    var selectedIndex: Int = 0
    var selectedViewController: UIViewController? {
        guard selectedIndex < children.count else { return nil }
        return children[selectedIndex]
    }

    init(_ type: TitleViewType = .left) {
        super.init(nibName: nil, bundle: nil)
        self.titleViewType = type
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // 重新布局子控件的位置
        _resizeSubviews()
    }

    /**
     * 更新标题和vc数据
     */
    func update(titles: [String], vcs: [UIViewController]) {
        guard titles.count == vcs.count else {
            return
        }
        _updateTitles(titles)
        _updateVCs(vcs)

        _scrollToIndex(0)
    }

    /**
     * 定位到下标为index的vc
     */
    func scrollToIndex(_ index: Int) {
        _scrollToIndex(index)
    }

    private func _updateTitles(_ titles: [String]) {
        titleScrollView = UIScrollView()
        titleScrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40)
        titleScrollView.showsHorizontalScrollIndicator = false

        titleItemViews = []
        for (index, title) in titles.enumerated() {
            let titleBtn = UIButton()
            titleBtn.titleLabel?.font = UIFont.pingFangWith(size: 16)
//            titleBtn.kcSetTitle(title, for: .normal)
            titleBtn.setTitle(title, for: .normal)
            titleBtn.setTitleColor(UIColor.hex(value: 0x929FB3), for: .normal)
            titleBtn.tag = index
            titleBtn.addTarget(self, action: #selector(_handleClickTitle(_:)), for: .touchUpInside)
            titleScrollView.addSubview(titleBtn)
            titleItemViews.append(titleBtn)
        }

        if titleViewType == .left {
            var x: CGFloat = 0
            for (i, titleBtn) in titleItemViews.enumerated() {
                let title = titles[i]
                let titleWidth = _titleWidth(title)
                titleBtn.frame = CGRect(x: x, y: 0, width: titleWidth + 32, height: 40)
                x += (titleWidth + 42) //(titleWidth + 32 + 10)
            }
            titleScrollView.contentSize = CGSize(width: x - 10, height: 40)
        } else {
            let width = Screen.width / CGFloat(titleItemViews.count)
            for (i, titleBtn) in titleItemViews.enumerated() {
                titleBtn.frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: 40)
            }
            titleScrollView.contentSize = CGSize(width: Screen.width, height: 40)
        }

        view.addSubview(titleScrollView)

        titleScrollView.addSubview(titleIndexer)
        var frame = titleIndexer.frame
        frame.origin.x = titleItemViews[0].center.x - frame.size.width / 2
        titleIndexer.frame = frame
    }

    private func _updateVCs(_ vcs: [UIViewController]) {
        let width = UIScreen.main.bounds.size.width

        vcScrollView = UIScrollView()
        vcScrollView.frame = CGRect(x: 0, y: 40, width: width, height: 0)
        vcScrollView.isPagingEnabled = true
        vcScrollView.delegate = self
        vcScrollView.showsHorizontalScrollIndicator = false

        for (index, vc) in vcs.enumerated() {
            self.addChild(vc)

            vcScrollView.addSubview(vc.view)
            vc.view.snp.makeConstraints { (make) in
                make.top.equalTo(0)
                make.leading.equalTo(width * CGFloat(index))
                make.width.equalTo(width)
                make.height.equalTo(vcScrollView.snp.height)
            }
        }

        vcScrollView.contentSize = CGSize(width: CGFloat(vcs.count) * width, height: 0)
        view.addSubview(vcScrollView)
    }

    private func _titleWidth(_ title: String) -> CGFloat {
        return NSAttributedString(string: DEF_LOCALIZED_STRING(key: title), attributes: [.font: UIFont.pingFangWith(size: 16)])
            .boundingRect(with: CGSize(width: 300, height: 40), options: [.usesLineFragmentOrigin], context: nil)
            .size
            .width
    }

    private func _resizeSubviews() {
        var headerHeight: CGFloat = 40 + titleContentSpace
        if let toolBar = titleSubToolBar {
            headerHeight += toolBar.frame.height
        }

        let height = view.bounds.size.height - headerHeight

        var size = vcScrollView.contentSize
        size.height = height
        vcScrollView.contentSize = size

        var frame = vcScrollView.frame
        frame.origin.y = headerHeight
        frame.size.height = height
        vcScrollView.frame = frame
    }

    @objc private func _handleClickTitle(_ btn: UIButton) {
        _scrollToIndex(btn.tag)
    }

    private func _scrollToIndex(_ index: Int, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.3 : 0, animations: { [weak self] in
            self?._titleScrollToIndex(CGFloat(index))
            self?._pageScrollToIndex(CGFloat(index))
        }, completion: { [weak self] (_) in
            self?._updateTitle(index)
        })
    }

    private func _titleScrollToIndex(_ index: CGFloat) {
        var center: CGFloat = 0
        if index <= 0 {
            center = titleItemViews[0].center.x
        } else if index >= CGFloat(titleItemViews.count - 1) {
            center = titleItemViews[titleItemViews.count - 1].center.x
        } else {
            let low = Int(floor(index))
            let lowCenter = titleItemViews[low].center.x
            center = (titleItemViews[low + 1].center.x - lowCenter) * (index - floor(index)) + lowCenter
        }

        var frame = titleIndexer.frame
        frame.origin.x = center - titleIndexer.frame.size.width / 2
        titleIndexer.frame = frame

        let maxOffsetX = titleScrollView.contentSize.width - titleScrollView.frame.width
        if maxOffsetX > 0 {
            let delta = titleIndexer.center.x - titleScrollView.contentOffset.x
            var offset = titleScrollView.contentOffset

            if delta < 0 {
                let newX = offset.x + delta - 200
                offset.x = newX > 0 ? newX : 0
            } else if delta > titleScrollView.frame.width {
                let newX = offset.x + delta + 200
                offset.x = newX < maxOffsetX ? newX : maxOffsetX
            }
            titleScrollView.setContentOffset(offset, animated: true)
        }
    }

    private func _updateTitle(_ target: Int) {
        for (index, item) in titleItemViews.enumerated() {
//            item.kc_setTitleColorPicker(index == target ? .main : .tipWord, forState: .normal)
            item.setTitleColor(index == target ? .black : .red, for: UIControl.State.normal)
        }
        delegate?.scrollPageViewControllerDidScroll(target)

        var targetVC: KCScrollable?
        for (i, child) in children.enumerated() {
            guard let child = child as? KCScrollable else { continue }

            if i != target {
                child.scrollPageDidLeaveCurrent() // 将其他页面标记为离开
            } else {
                targetVC = child
            }
        }
        targetVC?.scrollPageDidScrollToCurrent()

        self.selectedIndex = target
    }

    private func _pageScrollToIndex(_ index: CGFloat) {
        var offset = vcScrollView.contentOffset
        offset.x = index * vcScrollView.bounds.size.width
        vcScrollView.contentOffset = offset
    }
}

extension KCScrollPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        _titleScrollToIndex(index)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        _updateTitles(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        _updateTitles(scrollView)
    }

    private func _updateTitles(_ scrollView: UIScrollView) {
        let target = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        _updateTitle(target)
    }
}

extension KCScrollPageViewController {
    enum TitleViewType: Int {
        case left      // title 左对齐
        case equal     // title 均分
    }
}
