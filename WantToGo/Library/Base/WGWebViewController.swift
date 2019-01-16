//
//  WGWebViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/25.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import WebKit
import URLNavigator

class WGWebViewController: WGViewController {
    
    var webView : WKWebView!
    var urlString: String?
    var progBar : UIProgressView?
    

    // MARK: Initializing
    init(navigator: NavigatorType, urlStr: String) {
    
        self.urlString = urlStr
        super.init(navigator: navigator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadWebView()
        self.loadProgress()

    }
    
    func loadWebView() -> Void {
        //创建wkwebview
        self.webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        //创建网址
        let url = NSURL(string: self.urlString! as String)
        //创建请求
        let request = NSURLRequest(url: url! as URL)
        //加载请求
        self.webView.load(request as URLRequest)
        //添加wkwebview
        self.view.addSubview(self.webView)
    }
    
    deinit {
        self.webView = nil
        self.progBar = nil
    }
    
    func loadProgress() -> Void {
        
        self.progBar = UIProgressView(frame: CGRect.init(x: 0, y: CGFloat(STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT), width: self.view.frame.width, height: 30))
        self.progBar?.progress = 0.0
        self.progBar?.tintColor = KMainColor
        self.webView.addSubview(self.progBar!)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progBar?.alpha = 1.0
            self.progBar?.setProgress(Float(self.webView.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            if(self.webView.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseInOut, animations: {() -> Void in
                    self.progBar?.alpha = 0.0
                }, completion: { (finished:Bool) -> Void in
                    self.progBar?.progress = 0
                })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
}

