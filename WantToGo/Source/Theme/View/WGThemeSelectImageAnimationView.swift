//
//  WGThemeSelectImageAnimationView.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/15.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import Kingfisher

class WGThemeSelectImageAnimationView: UIView {
    
    var themeAnimationImageView : UIImageView?
    var themeSelectImageView : WGThemeSelectImageView?
    
    var resultsFrame : CGRect?
    var currentFrame : CGRect?
    init(currentFrame: CGRect, resultsFrame: CGRect, imageName: String, parentViewController: UIViewController) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: kMainScreenHeight))
        
        self.resultsFrame = resultsFrame
        self.currentFrame = currentFrame
        
        self.themeAnimationImageView = UIImageView.init(frame: currentFrame)
        self.themeAnimationImageView?.center = self.center
        
        self.themeAnimationImageView?.kf.setImage(with: URL(string: imageName))
        self.addSubview(self.themeAnimationImageView!)
        
        self.themeSelectImageView = WGThemeSelectImageView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: kMainScreenHeight),parentViewController:parentViewController)
        self.themeSelectImageView?.center = CGPoint.init(x: 1.5 * kMainScreenWidth , y: kMainScreenHeight/2)
        self.addSubview(self.themeSelectImageView!)
        self.themeSelectImageView?.homeButtonActionBlock = { [weak self] () -> Void in
            guard let strongSelf = self else { return }
            strongSelf.showShrinkImageAnimation()
            
        }
    }
    
    func dismissAnimation() -> Void {
        
        UIView.animate(withDuration: 0.3, animations: {

            self.themeSelectImageView?.center = CGPoint.init(x: -kMainScreenWidth/2 , y: kMainScreenHeight/2)

        }) { (true) in
            self.isHidden = true
            
            self.themeSelectImageView?.stackView.imageVCArray.removeAllObjects()
            
            self.removeFromSuperview()
        }
    }
    
    func showShrinkImageAnimation() -> Void {
        UIView.animate(withDuration: 0.5, animations: {
            
            self.themeSelectImageView?.center = CGPoint.init(x: 1.5*kMainScreenWidth , y: kMainScreenHeight/2)
            self.themeAnimationImageView?.center =  CGPoint.init(x: kMainScreenWidth/2 , y: kMainScreenHeight/2)
        
        }) { (true) in
            
            UIView.animate(withDuration: 0.3, animations: {
                self.themeAnimationImageView?.frame =  self.currentFrame!
                self.themeAnimationImageView?.center = self.center
                
            }) { (true) in
                
                self.isHidden = true
                
                self.themeSelectImageView?.stackView.imageVCArray.removeAllObjects()
              
                self.removeFromSuperview()
            }
            
        }
    }
    
    
    func showEnlargeImageAnimation() -> Void {
        
        let rootVC = UIApplication.shared.delegate as! AppDelegate
        rootVC.window?.addSubview(self)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.themeAnimationImageView?.frame =  self.resultsFrame!
            self.themeAnimationImageView?.center = CGPoint.init(x: kMainScreenWidth/2, y: kMainScreenHeight/2)
     
        }) { (true) in
       
            UIView.animate(withDuration: 0.3, animations: {
    
                self.themeSelectImageView?.center = CGPoint.init(x: kMainScreenWidth/2 , y: kMainScreenHeight/2)
                self.themeAnimationImageView?.center =  CGPoint.init(x: -kMainScreenWidth/2 , y: kMainScreenHeight/2)
                
            }) { (true) in
                
                
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
