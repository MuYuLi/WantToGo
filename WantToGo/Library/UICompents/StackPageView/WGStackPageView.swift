//
//  WGStackPageView.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/11.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit


protocol StackViewDataSource{
    func stackViewPrev(currentViewController:UIViewController?) -> ContentImageViewController?
    func stackViewNext(currentViewController:UIViewController?) -> ContentImageViewController?
}


class WGStackPageView: UIView {

    var parentViewController:UIViewController!
    
    var prevContainer : PageView?
    var currentContainer = PageView()
    var nextContainer : PageView?
    
    var dataSource:StackViewDataSource?

    var dataArray : Array<String>? {
        didSet {
            
     
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        clipsToBounds = true
        self.currentContainer = PageView()
        self.currentContainer.backgroundColor = UIColor.red
        self.currentContainer.frame = bounds
        addSubview(self.currentContainer)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(gesture:)))
        
        addGestureRecognizer(pan)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.currentContainer.frame = bounds
    }
    
    
    @objc func panAction(gesture:UIPanGestureRecognizer){
        let p = gesture.translation(in: self)
        if gesture.state == .began {
            if let prev = dataSource?.stackViewPrev(currentViewController: self.currentContainer.viewController) {
                parentViewController.addChild(prev)
                prevContainer = PageView()
                prevContainer?.frame = self.currentContainer.bounds
                prevContainer?.viewController = prev
                prevContainer?.center = CGPoint.init(x: -bounds.width/2, y: bounds.height/2)
                addSubview(prevContainer!)
                prev.didMove(toParent: parentViewController)
            }
            if let next = dataSource?.stackViewNext(currentViewController: self.currentContainer.viewController) {
                parentViewController.addChild(next)
                nextContainer = PageView()
                nextContainer?.frame = self.currentContainer.bounds
                nextContainer?.viewController = next
                insertSubview(nextContainer!, belowSubview: self.currentContainer)
                next.didMove(toParent: parentViewController)
            }
            
            self.currentContainer.alpha = 0.5
            
        }else if gesture.state == .changed {
            if p.x < 0 {
                self.currentContainer.center.x = bounds.width/2 + p.x
                prevContainer?.center.x = -bounds.width/2
            }else if p.x > 0 {
                self.currentContainer.center.x = bounds.width/2
                let prevPosX = -bounds.width/2 + p.x
                if prevPosX < bounds.width/2 {
                    prevContainer?.center.x = prevPosX
                }else{
                    prevContainer?.center.x = bounds.width/2
                }
            }
        }else if gesture.state == .ended {
            self.currentContainer.alpha = 1
            UIView.animate(withDuration: 0.5, delay: 0,
                           options: [.curveEaseOut], animations: { () -> Void in
                            
                            if p.x < -kMainScreenWidth/2 && self.nextContainer != nil {
                                self.currentContainer.center.x = -kMainScreenWidth/2
                            }else if p.x > kMainScreenWidth/2 && self.prevContainer != nil {
                                self.prevContainer?.center.x = kMainScreenWidth/2
                            }else{
                                self.prevContainer?.center.x = -kMainScreenWidth/2
                                self.currentContainer.center.x = kMainScreenWidth/2
                            }
                            
            }, completion: { (_) -> Void in
                
                if p.x < -kMainScreenWidth/2 && self.nextContainer != nil {
                    self.currentContainer.viewController?.willMove(toParent: nil)
                    self.prevContainer?.viewController?.willMove(toParent: nil)
                    self.currentContainer.viewController?.removeFromParent()
                    self.prevContainer?.viewController?.removeFromParent()
                    self.currentContainer.viewController = self.nextContainer?.viewController
                }else if p.x > kMainScreenWidth/2 && self.prevContainer != nil {
                    self.currentContainer.viewController?.willMove(toParent: nil)
                    self.nextContainer?.viewController?.willMove(toParent: nil)
                    self.currentContainer.viewController?.removeFromParent()
                    self.nextContainer?.viewController?.removeFromParent()
                    self.currentContainer.viewController = self.prevContainer?.viewController
                }
         
                self.prevContainer?.removeFromSuperview()
                self.prevContainer = nil
           
                self.nextContainer?.removeFromSuperview()
                self.nextContainer = nil
                
                self.currentContainer.center = CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2)
                
            })
        }
    }

}


class PageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    var viewController : ContentImageViewController? {
        didSet{
    
            let v = viewController?.view
            v?.frame = bounds
            v?.removeFromSuperview()
            for sv in subviews {
                sv.removeFromSuperview()
            }
            addSubview(v!)
        }
    }
}



class ContentImageViewController : UIViewController {
    
    var imageName : String? {
        didSet {
            imageV?.image = UIImage.init(named: imageName!)
        }
    }
    var imageV : UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageV = UIImageView.init(frame: self.view.bounds)
        self.view.addSubview(imageV!)
//        imageV?.image = UIImage.init(named: imageName?)
        
        //        self.imageV?.kf.setImage(with: URL.init(string: imageName!))
    }
    
}
