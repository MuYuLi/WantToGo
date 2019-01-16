//
//  WGThemeSelectImageView.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/15.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

typealias HomeButtonActionBlock = () -> Void
typealias ScrollviewToLastPageBlock = () -> Void

class WGThemeSelectImageView: UIView, MYLStackPageViewDelegate {
    func scrollviewScrollIndex(_ index: NSInteger) {
        self.pageControlView?.currentPage = index
        
        self.initThread()
    
    }
    
    func scrollviewToLastPage() {
        if self.scrollviewToLastPageBlock != nil {
            self.scrollviewToLastPageBlock?()
        }
    }
    
    var imageArray : [String]?
    
    var stackView: MYLStackPageView!
    
    var pageControlView : UIPageControl?
    var contenTitleLabel : UILabel?
    
    var homeButtonActionBlock : HomeButtonActionBlock?
    var scrollviewToLastPageBlock : ScrollviewToLastPageBlock?
    
    
    
    init(frame : CGRect, parentViewController: UIViewController) {
        
        super.init(frame:CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: kMainScreenHeight))
        self.initStackView(parentViewController: parentViewController)
        self.initUIData()
        
        initThread()
    }
    
    func initThread() -> Void {
        let thread = Thread.init(target: self, selector: #selector(self.animationLabel), object: nil)
        
        thread.start()
    }
    
    
    @objc func animationLabel() -> Void {
        
        let string = "君不见，黄河之水天上来，奔流到海不复回。\n君不见，高堂明镜悲白发，朝如青丝暮成雪。"
        
        for i in 0 ... string.count {
            
            self.perform(#selector(self.refreshUI), on: .main, with: string.prefix(i), waitUntilDone: true)
            Thread.sleep(forTimeInterval: 0.01)
            
        }
    }
    
    @objc func refreshUI(_ contentStr : String) -> Void {
        
        self.contenTitleLabel?.text = contentStr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initStackView(parentViewController: UIViewController) -> Void {
        self.imageArray = [
            "1.jpg","7.jpg","3.jpg","5.jpg","6.jpg",
        ]
        
        self.stackView = MYLStackPageView.init(frame: self.bounds, dataSource: self.imageArray, parentViewController: parentViewController)
        self.stackView.delegate = self
        self.addSubview(stackView)
        
    }
    
    func initUIData() -> Void {
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = grayLineColor
        self.addSubview(bottomLine)
        
        let wgHomeBtn = UIButton.creatButton(frame: .zero, target: self, action: #selector(self.homeBtnAction), bgImage: UIImage.init(named: "img_xiangqu"))
        self.addSubview(wgHomeBtn)
        
        let homeBtn = UIButton.creatButton(frame: .zero, target: self, action: #selector(self.homeBtnAction), bgImage: UIImage.init(named: "btn_home"))
        self.addSubview(homeBtn)
        
        self.pageControlView = UIPageControl()
        self.pageControlView?.currentPage = 0
        self.pageControlView?.numberOfPages = self.imageArray!.count
        self.addSubview(self.pageControlView!)
        
        self.contenTitleLabel = UILabel.createLabel(frame: .zero, text: "12345678765434567876543", textColor: .white, font: font15, backColor: .clear, textAlignment: .left)
        self.contenTitleLabel?.numberOfLines = 0
        self.addSubview(self.contenTitleLabel!)
        
        wgHomeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(STATUS_BAR_HEIGHT)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize.init(width: 36, height: 20))
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-TAB_BAR_HEIGHT-20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        homeBtn.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(self.snp.bottom).offset(-(TAB_BAR_HEIGHT+20)/2)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize.init(width: 24, height: 28))
        }
        
        self.pageControlView?.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(homeBtn)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize.init(width: 80, height: 20))
        }
        
        self.contenTitleLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(bottomLine.snp.top).offset(-15)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        })
    }
    
    @objc func homeBtnAction() -> Void {
        
        if self.homeButtonActionBlock != nil {
            self.homeButtonActionBlock?()
        }
    }
    
    deinit {

    }
    
}
