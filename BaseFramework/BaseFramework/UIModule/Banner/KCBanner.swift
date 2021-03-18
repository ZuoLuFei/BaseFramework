/*******************************************************************************
 # File        : KCBanner.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/8/21
 # Corporation : ****
 # Description : banner 自动滚动视图
 ******************************************************************************/

import UIKit

class KCBanner: UIView, UIScrollViewDelegate {
    private lazy var scrollView = UIScrollView()
    private lazy var totalLab = UILabel()
    private lazy var indexLab = UILabel()
    private lazy var imgIVs: [UIImageView] = [UIImageView(), UIImageView(), UIImageView()]
    private var bannerSize: CGSize = CGSize.zero

    private var datas: [String] = []
    private var timer: Timer?

    private var index: Int = 0

    var itemBlock: ((_ index: Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        _initUI(frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     * 设置banner数据源
     */
    func setDatas(_ datas: [String]) {
        self.datas = datas
        _updateUI()

        timer?.invalidate()

        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(_autoScroll), userInfo: nil, repeats: true)

        if let timer = timer {
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        }
    }

    @objc private func _autoScroll() {
        let x = bannerSize.width * 2
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.scrollView.contentOffset = CGPoint(x: x, y: 0)
        }, completion: { (_) in
            self.scrollViewDidEndDecelerating(self.scrollView)
        })
    }

    private func _initUI(_ frame: CGRect) {
        self.bannerSize = frame.size
        self.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false

        for (i, imgIV) in imgIVs.enumerated() {
            scrollView.addSubview(imgIV)
            imgIV.frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: frame.width, height: frame.height)
        }

        self.addSubview(totalLab)
        totalLab.snp.makeConstraints { (make) in
            make.trailing.equalTo(-12)
            make.bottom.equalTo(-13)
        }
        totalLab.font = UIFont.pingFangWith(size: 12)
//        totalLab.kcTextColor = .tipWord

        self.addSubview(indexLab)
        indexLab.snp.makeConstraints { (make) in
            make.trailing.equalTo(totalLab.snp.leading)
            make.bottom.equalTo(totalLab.snp.bottom)
        }
        indexLab.font = UIFont.pingFangWith(size: 14)
//        indexLab.kcTextColor = .keyWord

        let tap = UITapGestureRecognizer(target: self, action: #selector(_handleTap))
        self.addGestureRecognizer(tap)
    }

    @objc private func _handleTap() {
        itemBlock?(index)
    }

    private func _updateUI() {
        scrollView.contentSize = CGSize(width: bannerSize.width * CGFloat(datas.count), height: bannerSize.height)

        imgIVs[0].image = UIImage(named: datas[(index - 1 + datas.count) % datas.count])
        imgIVs[1].image = UIImage(named: datas[index])
        imgIVs[2].image = UIImage(named: datas[(index + 1) % datas.count])

        scrollView.contentOffset = CGPoint(x: bannerSize.width, y: 0)

        totalLab.text = "/\(datas.count)"
        indexLab.text = "\(index + 1)"
    }

    // scroll view delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.x != bannerSize.width else { return }

        if scrollView.contentOffset.x == 0 {
            index = (index - 1 + datas.count) % datas.count
        } else {
            index = (index + 1) % datas.count
        }
        _updateUI()

        scrollView.contentOffset = CGPoint(x: bannerSize.width, y: 0)

        indexLab.text = "\(index + 1)"
    }
}
