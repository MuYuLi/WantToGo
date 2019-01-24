//
//  WGSearchTextField.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/23.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

class WGSearchTextField: UIView, UITextFieldDelegate {

    var textField : UITextField?

    var leftV : UIImageView?
    var rightV : UIImageView?
    
    var leftImageName : String? {
        didSet {
            self.leftV?.image = UIImage.init(named: leftImageName!)
        }
    }
    var rightImageName : String? {
        didSet {
            self.rightV?.image = UIImage.init(named: rightImageName!)
        }
    }
    
    var leftVFrame : CGRect? {
        didSet {
            self.leftV?.frame = leftVFrame ?? CGRect.init(x: 0, y: 0, width: 20, height: 20)
        }
    }
    var rightVFrame : CGRect? {
        didSet {
            self.rightV?.frame = rightVFrame ?? CGRect.init(x: 0, y: 0, width: 20, height: 20)
        }
    }

    var placeholdString : String? {
        didSet {
            self.textField?.placeholder = placeholdString
        }
    }
    var textColor : UIColor? {
        didSet {
            self.textField?.textColor = textColor
        }
    }
    
    var textFont : UIFont? {
        didSet {
            self.textField?.font = textFont
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textField = UITextField.init(frame: frame)
        self.addSubview(self.textField!)
        self.textField?.delegate = self
        self.textField?.font = UIFont.systemFont(ofSize: 12)
        self.leftV = UIImageView.init(frame: .init(x: 0, y: 0, width: 30, height: 30))
        
        self.textField?.leftView = self.leftV
        self.textField?.leftViewMode = .always
        self.rightV = UIImageView.init(frame: .init(x: 0, y: 0, width: 30, height: 30))
        self.textField?.rightViewMode = .always
        self.textField?.rightView = self.rightV
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

}
