/*******************************************************************************
 # File        : KCWebViewController.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/27
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

class KCWebViewController: KCBaseViewController {

    private weak var webView: KCWebView!

    private var url: String = ""

    init(_ title: String, _ url: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.url = url
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?._configUI()
        }
    }
}

// MARK: - 初始化UI
extension KCWebViewController {
    private func _configUI() {
        let webView = KCWebView()
        self.webView = webView
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        webView.loadUrl(url)
    }
}
