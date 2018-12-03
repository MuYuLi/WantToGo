//
//  UIView+Create.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

extension UILabel {
    
    class func createLabel(frame: CGRect, text: String, textColor: UIColor, font: UIFont, backColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        
        let label = UILabel()
        label.textAlignment = textAlignment
        label.frame = frame
        label.backgroundColor = UIColor.clear
        label.text = text;
        label.backgroundColor = backColor;
        label.font = font;
        label.textColor = textColor;
        return label
    }
    
    class func createLabel(frame: CGRect, text: String, textColor: UIColor, font: UIFont, backColor: UIColor) -> UILabel {
        return self.createLabel(frame: frame, text: text, textColor: textColor, font: font, backColor: backColor, textAlignment: NSTextAlignment.center)
    }
    class func createLabel(frame: CGRect, text: String, textColor: UIColor, font: UIFont, textAligent: NSTextAlignment) -> UILabel {
        return self.createLabel(frame: frame, text: text, textColor: textColor, font: font, backColor:UIColor.clear, textAlignment: textAligent)
    }
    
    class func createLabel(frame: CGRect, text: String, textColor: UIColor, font: UIFont) -> UILabel {
        return self.createLabel(frame: frame, text: text, textColor: textColor, font: font, backColor: UIColor.clear, textAlignment: NSTextAlignment.center)
    }
    class func createLabel(frame: CGRect, text: String, textColor: UIColor) -> UILabel {
        return self.createLabel(frame: frame, text: text, textColor: textColor, font: UIFont.systemFont(ofSize: 14), backColor: UIColor.clear, textAlignment: NSTextAlignment.center)
    }
    
}



extension UIButton {
    
    class func creatButton(frame : CGRect, target : Any, action : Selector, title : String, font : UIFont, titleColor : UIColor, bgImage : UIImage, backColor : UIColor, tag : NSInteger) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.frame = frame
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        button.titleLabel?.font = font
        button.setTitleColor(titleColor, for: .normal)
        
        button.setBackgroundImage(bgImage, for: .normal)
        
        button.backgroundColor = backColor
        button.tag = tag
        return button
    }
    
    class func creatButton(frame : CGRect, target : Any, action : Selector, title : String, font : UIFont, titleColor : UIColor, bgImage : UIImage, tag : NSInteger) -> UIButton {
        
        return self.creatButton(frame: frame, target: target, action: action, title: title, font: font, titleColor: titleColor, bgImage: bgImage, backColor: UIColor.clear, tag: tag)
    }
    
    
    class func creatButton(frame : CGRect, target : Any, action : Selector, bgImage : UIImage, tag : NSInteger) -> UIButton {
        
        return self.creatButton(frame: frame, target: target, action: action, title: "", font: UIFont.systemFont(ofSize: 14), titleColor: UIColor.black, bgImage: bgImage, backColor: UIColor.clear, tag: tag)
    }
    
    class func creatButton(frame : CGRect, target : Any, action : Selector, title : String, font : UIFont, titleColor : UIColor, backColor : UIColor, tag : NSInteger) -> UIButton {
        return self.creatButton(frame: frame, target: target, action: action, title: title, font: font, titleColor: titleColor, bgImage: UIImage.init(named: "")!, backColor: backColor, tag: tag)
    }

}
