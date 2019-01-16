//
//  MYLStackPageView.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/14.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

public protocol MYLStackPageViewDelegate : AnyObject {
    func scrollviewToLastPage() -> Void
    func scrollviewScrollIndex(_ index: NSInteger) -> Void
}


class MYLStackPageView: UIView {
    
    var imageVCArray = NSMutableArray()
    var currentIndex = 0 {
        didSet{
            self.delegate?.scrollviewScrollIndex(currentIndex)
        }
    }
    
    var prevContainer : PageView?
    var currentContainer = PageView()
    var nextContainer : PageView?
    
    var parentViewController : UIViewController?
    
    var lastIndex = -1
    
    public weak var delegate : MYLStackPageViewDelegate?
    
    init(frame: CGRect, dataSource : Array<String>?, parentViewController: UIViewController) {
        super.init(frame: frame)
        self.backgroundColor = .black

        self.setImageVCArray(dataSource)
        let imageVC = imageVCArray.firstObject as! ContentImageViewController

        currentContainer.backgroundColor = UIColor.red
        currentContainer.frame = bounds
        currentContainer.addSubview(imageVC.view)
        addSubview(currentContainer)
        
        clipsToBounds = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(gesture:)))
        addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.delegate = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.currentContainer.frame = bounds
    }
    
    
    func initContainer() -> Void {
        
        self.prevContainer = PageView.init(frame: self.bounds)
        self.currentContainer = PageView.init(frame: self.bounds)
        self.nextContainer = PageView.init(frame: self.bounds)
        
        self.currentContainer.center = self.center
        self.prevContainer?.center.x = -self.bounds.width / 2
        self.nextContainer?.center.x =  self.bounds.width + self.bounds.width / 2
    }
    
    func setImageVCArray(_ imageNameArr : Array<String>?) -> Void {
        for imageName in imageNameArr! {
            let imageVC = ContentImageViewController()
            imageVC.view.frame = self.bounds
            imageVC.imageName = imageName
            imageVCArray.add(imageVC)
        }
    }
    
    @objc func panAction(gesture:UIPanGestureRecognizer){
        let p = gesture.translation(in: self)
        if gesture.state == .began {
        
            if self.imageVCArray.count - 1 > self.currentIndex && self.currentIndex > 0 {
                
                let preImageVC = self.imageVCArray.object(at: currentIndex - 1) as! ContentImageViewController
                self.parentViewController?.addChild(preImageVC)
                self.prevContainer = PageView()
                self.prevContainer?.frame = self.currentContainer.bounds
                self.prevContainer?.viewController = preImageVC
                self.prevContainer?.center = CGPoint.init(x: -bounds.width/2, y: bounds.height/2)
                addSubview(self.prevContainer!)
                preImageVC.didMove(toParent: parentViewController)
                
                let nextImageVC = self.imageVCArray.object(at: currentIndex + 1) as! ContentImageViewController
                self.parentViewController?.addChild(nextImageVC)
                self.nextContainer = PageView()
                self.nextContainer?.frame = self.currentContainer.bounds
                self.nextContainer?.center = CGPoint.init(x: bounds.width/2, y: bounds.height/2)
                self.nextContainer?.viewController = nextImageVC
                nextImageVC.didMove(toParent: parentViewController)
                
            }else if self.currentIndex == 0 {
                let nextImageVC = self.imageVCArray.object(at: currentIndex + 1) as! ContentImageViewController
                self.parentViewController?.addChild(nextImageVC)
                self.nextContainer = PageView()
                self.nextContainer?.frame = self.currentContainer.bounds
                self.nextContainer?.center = CGPoint.init(x: bounds.width/2, y: bounds.height/2)
                self.nextContainer?.viewController = nextImageVC
                
                nextImageVC.didMove(toParent: parentViewController)
                
            }else if self.currentIndex == self.imageVCArray.count - 1 {
                let preImageVC = self.imageVCArray.object(at: currentIndex - 1) as! ContentImageViewController
                self.parentViewController?.addChild(preImageVC)
                self.prevContainer = PageView()
                self.prevContainer?.frame = self.currentContainer.bounds
                self.prevContainer?.viewController = preImageVC
                self.prevContainer?.center = CGPoint.init(x: -bounds.width/2, y: bounds.height/2)
                addSubview(self.prevContainer!)
                preImageVC.didMove(toParent: parentViewController)
                
            }
            
            if self.nextContainer != nil {
                insertSubview(self.nextContainer!, belowSubview: self.currentContainer)
            }
            if self.prevContainer != nil {
                insertSubview(self.prevContainer!, aboveSubview: self.currentContainer)
            }
            
        }else if gesture.state == .changed {
            if p.x < 0 {//
                self.currentContainer.center.x = bounds.width/2 + p.x
                self.prevContainer?.center.x = -bounds.width/2

            }else if p.x > 0 {
             
                let prevPosX = -bounds.width/2 + p.x
                if prevPosX < bounds.width/2 {
                    self.prevContainer?.center.x = prevPosX
                }else{
                    self.prevContainer?.center.x = bounds.width/2
                }
            }
            
        }else if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut
                ], animations: {
                    
                    if p.x < -kMainScreenWidth/2 && self.nextContainer != nil {
                        self.currentContainer.center.x = -kMainScreenWidth/2
                    }else if p.x > kMainScreenWidth/2 && self.prevContainer != nil {
                        self.prevContainer?.center.x = kMainScreenWidth/2
                        self.currentContainer.center.x = kMainScreenWidth/2 + kMainScreenWidth
                    }else{
                        self.prevContainer?.center.x = -kMainScreenWidth/2
                        self.currentContainer.center.x = kMainScreenWidth/2
                    }
                    
            }) { (success) in
                
                if p.x < -kMainScreenWidth/2 && self.nextContainer != nil {
                    self.currentContainer.viewController?.willMove(toParent: nil)
                    self.prevContainer?.viewController?.willMove(toParent: nil)
                    self.currentContainer.viewController?.removeFromParent()
                    self.prevContainer?.viewController?.removeFromParent()
                    self.currentContainer.viewController = self.nextContainer?.viewController

                    if self.currentIndex < self.imageVCArray.count - 1 {
                        self.currentIndex += 1
                    }else {
                        print("wertyuytrertytre")
                    }
                    
                    
                }else if p.x > kMainScreenWidth/2 && self.prevContainer != nil {
                    self.currentContainer.viewController?.willMove(toParent: nil)
                    self.nextContainer?.viewController?.willMove(toParent: nil)
                    self.currentContainer.viewController?.removeFromParent()
                    self.nextContainer?.viewController?.removeFromParent()
                    self.currentContainer.viewController = self.prevContainer?.viewController
                    if self.currentIndex > 0 {
                        self.currentIndex -= 1
                    }else {
                        print("wertyuytrertytre")
                    }
                }
           
                self.prevContainer?.removeFromSuperview()
                self.prevContainer = nil
                
                self.nextContainer?.removeFromSuperview()
                self.nextContainer = nil
                
                self.currentContainer.center = CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2)
               
                if self.currentIndex == self.imageVCArray.count - 1 && p.x < -100 {
                    
                    self.lastIndex += 1
                    
                    if self.lastIndex > 0 {
                        self.delegate?.scrollviewToLastPage()
                    }
                }
                if self.currentIndex < self.imageVCArray.count - 1 {
                    self.lastIndex = -1
                }
            }
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
    }
    
    deinit {

    }
    
}
