/*******************************************************************************
 # File        : KCWebView.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/3
 # Corporation : ****
 # Description : 公共webView，封装了刷新启动以及暂停
 ******************************************************************************/

import UIKit
import WebKit

class KCWebView: WKWebView {

    weak var loadingContainer: UIView!
    weak var loadingView: UIActivityIndicatorView!

    init() {
        super.init(frame: CGRect.zero, configuration: WKWebViewConfiguration())
        self.navigationDelegate = self
        _initUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadUrl(_ url: String) {
        guard let validUrl = URL.init(string: url) else { return }
        load(URLRequest(url: validUrl))
    }

    private func _initUI() {
        let loadingContainer = UIView()
        self.loadingContainer = loadingContainer
        self.addSubview(loadingContainer)
        loadingContainer.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
//        loadingContainer.kcBackgroundColor = KCTheme.Color.splitLine

        let loadingView = UIActivityIndicatorView()
        self.loadingView = loadingView
        loadingContainer.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        loadingView.startAnimating()
    }
}

extension KCWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        loadingContainer.isHidden = true
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {

    }
}
