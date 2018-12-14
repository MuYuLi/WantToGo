//
//  WGTaDiscoverCell.swift
//  WantToGo
//
//  Created by Muyuli on 2018/12/3.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGTaDiscoverCell: UITableViewCell {
    
    let authorViewHeight = 60
    let contentImageViewHeight = 320
    let tipsViewHeight = 50
    let commentViewHeight = 20
    
    var authorView : WGTaDiscoverAuthorView?
    var contentImageView : WGTaDiscoverContentView?
    var commentView : WGTaDiscoverCommentView?
    var tipsView : WGTaDiscoverTipsView?
    
    var comment0 : WGTaDiscoverCommentView?
    var comment1 : WGTaDiscoverCommentView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.authorView = WGTaDiscoverAuthorView.init(frame: CGRect.zero)
        
        self.contentImageView = WGTaDiscoverContentView.init(frame: CGRect.zero)
        
        self.tipsView = WGTaDiscoverTipsView.init(frame: CGRect.zero)
        
        self.comment0 = WGTaDiscoverCommentView.init(frame: CGRect.zero)
        self.comment1 = WGTaDiscoverCommentView.init(frame: CGRect.zero)
        
        self.contentView.addSubview(self.authorView!)
        self.contentView.addSubview(self.contentImageView!)
        self.contentView.addSubview(self.tipsView!)
        
        self.contentView.addSubview(self.comment0!)
        self.contentView.addSubview(self.comment1!)
        
        self.authorView?.snp.makeConstraints({ (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(authorViewHeight)
        })
        
        self.contentImageView?.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.authorView!.snp.bottom)
            make.height.equalTo(contentImageViewHeight)
        })
        
        self.tipsView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(tipsViewHeight)
        })
    }
    
    
    func loadUI(model : WGTaDiscoverDataModel) -> Void {
        
        self.authorView?.authorAvatarImageV?.kf.setImage(with: URL.init(string: model.authorAvatarURL!))
        self.authorView?.authorNameLabel?.text = model.authorName
        self.authorView?.authorTagLabel?.text = model.authorTag
        
        self.contentImageView?.postTitleLabel?.text = model.postTitle

        self.contentImageView?.snp.remakeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.authorView!.snp.bottom)
            make.height.equalTo(contentImageViewHeight)
        })
        
        if model.contents!.count > 0 {
            
            let contentModel = (model.contents! as NSArray).object(at: 0) as! WGTaDiscoverContentsItem
            
            self.contentImageView?.contentImageV?.kf.setImage(with: URL.init(string: contentModel.content!))
            
            if CGFloat(contentModel.imgHeight! - contentModel.imgWidth!) > 0 {
                self.contentImageView?.contentImageV?.contentMode = .center
            }else {
                self.contentImageView?.contentImageV?.contentMode = .scaleToFill
            }
            
            if model.contents!.count > 1 {
                let contentModel1 = (model.contents! as NSArray).object(at: 1) as! WGTaDiscoverContentsItem
                self.contentImageView?.contentLabel?.text = contentModel1.content
            }else {
                self.contentImageView?.contentLabel?.text = ""
                self.contentImageView?.snp.remakeConstraints({ (make) in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(self.authorView!.snp.bottom)
                    make.height.equalTo(280)
                })
            }
        }
        
        if model.comments!.count > 0 {
            self.comment0?.isHidden = false
            self.comment1?.isHidden = false
            let commentModel0 = (model.comments! as NSArray).object(at: 0) as! WGTaDiscoverCommentsItem
            self.comment0?.headerImageV?.kf.setImage(with: URL.init(string: commentModel0.avaPath!))
            self.comment0?.nameLabel?.text = commentModel0.nick!
            self.comment0?.commentLabel?.text = commentModel0.content!
            
            self.comment0?.snp.remakeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(self.contentImageView!.snp.bottom).offset(5)
                make.height.equalTo(commentViewHeight)
            })
        
            if model.comments!.count > 1 {
                let commentModel1 = (model.comments! as NSArray).object(at: 1) as! WGTaDiscoverCommentsItem
                self.comment1?.headerImageV?.kf.setImage(with: URL.init(string: commentModel1.avaPath!))
                self.comment1?.nameLabel?.text = commentModel1.nick!
                self.comment1?.commentLabel?.text = commentModel1.content!
                
                self.comment1?.snp.remakeConstraints({ (make) in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(self.comment0!.snp.bottom)
                    make.height.equalTo(commentViewHeight)
                })
            }else{
                self.comment1?.isHidden = true
            }
        }else {
            self.comment0?.isHidden = true
            self.comment1?.isHidden = true
        }
        
        
        self.tipsView?.commentNumLabel?.text = "\(model.commentNum!)"
        self.tipsView?.favorNumLabel?.text = "\(model.favorNum!)"
        self.tipsView?.createAtLabel?.text = "\(model.createAt!)"
    }
    
    
    class func getHeight(model : WGTaDiscoverDataModel) -> CGFloat {
        
        var height : CGFloat = 430
        
        if model.comments!.count > 1 {
            height = height + 40
        }else if model.comments!.count > 0 {
            height = height + 20
        }
        if model.contents?.count == 1 {
            height = height - 40
        }
        
        return height
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

/// 作者视图
class WGTaDiscoverAuthorView : WGView {
    
    var contentView : UIView?
    
    var authorAvatarImageV : UIImageView?//头像
    var authorNameLabel : UILabel?//昵称
    var authorTagLabel : UILabel?//描述
    
    var attentionButton : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = KBackgroudColor
        self.contentView = UIView.init(frame: CGRect.zero)
        self.contentView?.backgroundColor = UIColor.white
        self.authorAvatarImageV = UIImageView.init(frame: CGRect.zero)
        self.authorAvatarImageV?.clipsToBounds = true
        self.authorAvatarImageV?.layer.cornerRadius = 15
        self.authorAvatarImageV?.layer.borderWidth = 1
        self.authorAvatarImageV?.layer.borderColor = UIColor.gray.cgColor
        
        self.authorNameLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.black, font:UIFont.systemFont(ofSize: 14))
        
        self.authorTagLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 12))
        
        self.attentionButton = UIButton.creatButton(frame: CGRect.zero, target: self, action: #selector(self.attentionAction(_ : )), bgImage: UIImage.init(), tag: 101)
        
        let lineV = UIView.init(frame: CGRect.zero)
        lineV.backgroundColor = KBackgroudColor
        
        self.addSubview(self.contentView!)
        self.contentView?.addSubview(self.authorAvatarImageV!)
        self.contentView?.addSubview(self.authorNameLabel!)
        self.contentView?.addSubview(self.authorTagLabel!)
        self.contentView?.addSubview(self.attentionButton!)
        self.contentView?.addSubview(lineV)
        
        self.contentView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        })
        
        self.authorAvatarImageV?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        })
        
        self.authorNameLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.authorAvatarImageV!.snp.centerY)
            make.left.equalTo(self.authorAvatarImageV!.snp.right).offset(15)
        })
        
        self.authorTagLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.authorAvatarImageV!.snp.centerY)
            make.left.equalTo(self.authorNameLabel!)
        })
        
        lineV.snp.makeConstraints { (make) in
            make.bottom.equalTo((self))
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    
    @objc func attentionAction(_ sender: UIButton) -> Void {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


/// 内容视图
class WGTaDiscoverContentView: WGView {
    
    var postTitleLabel : UILabel?//标题
    var contentImageV : UIImageView?//大图
    var contentLabel : UILabel?//大图下的描述
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.contentImageV?.clipsToBounds = true
        
        self.postTitleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.black, font:UIFont.systemFont(ofSize: 16, weight: .bold),textAligent:.left)
        
        self.contentLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 14),textAligent:.left)
        self.contentLabel?.numberOfLines = 2
        
        self.addSubview(self.contentImageV!)
        self.addSubview(self.postTitleLabel!)
        self.addSubview(self.contentLabel!)
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(240)
        })
        
        self.postTitleLabel?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()
            make.bottom.equalTo(self.contentImageV!.snp.top)
            make.right.equalToSuperview().offset(-15)
        })
        
        self.contentLabel?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalToSuperview()
        })

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


/// 点赞视图
class WGTaDiscoverTipsView: WGView {
    
    var favorNumImageV : UIImageView?//点赞数
    var favorNumLabel : UILabel?//点赞数
    var commentNumImageV : UIImageView?//收藏数
    var commentNumLabel : UILabel?//收藏数
   
    var createAtLabel : UILabel?//时间
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.favorNumImageV = UIImageView.init(frame: CGRect.zero)
        self.favorNumImageV?.image = UIImage.init(named: "btn_favor_add")
        self.favorNumLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 13))
        
        self.commentNumImageV = UIImageView.init(frame: CGRect.zero)
        self.commentNumImageV?.image = UIImage.init(named: "btn_comment")
        self.commentNumLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 13))
        self.createAtLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 11))
        
        self.addSubview(self.favorNumImageV!)
        self.addSubview(self.favorNumLabel!)
        self.addSubview(self.commentNumImageV!)
        self.addSubview(self.commentNumLabel!)
        self.addSubview(self.createAtLabel!)
        
        self.favorNumImageV?.snp.makeConstraints({ (make) in
            
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 10, height: 10))
        })
        
        self.favorNumLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.favorNumImageV!.snp.right).offset(5)
            make.centerY.equalToSuperview()
        })
        
        self.commentNumImageV?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.favorNumLabel!.snp.right).offset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        })
        
        self.commentNumLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.commentNumImageV!.snp.right).offset(5)
            make.centerY.equalToSuperview()
        })
        
        self.createAtLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalToSuperview()
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


/// 评论视图
class WGTaDiscoverCommentView: WGView {
    
    var headerImageV : UIImageView?//头像
    var nameLabel : UILabel?//昵称
    var commentLabel : UILabel?//评论
    
    var createAtLabel : UILabel?//时间
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.headerImageV = UIImageView.init(frame: CGRect.zero)
        self.headerImageV?.clipsToBounds = true
        self.headerImageV?.layer.cornerRadius = 7.5
        self.headerImageV?.layer.borderWidth = 1
        self.headerImageV?.layer.borderColor = UIColor.gray.cgColor
        
        self.nameLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 12), textAligent:.left)
        
        self.commentLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 12), textAligent:.left)
        
        self.addSubview(self.headerImageV!)
        self.addSubview(self.nameLabel!)
        self.addSubview(self.commentLabel!)
    
        self.headerImageV?.snp.makeConstraints({ (make) in
            
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 15, height: 15))
        })
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.headerImageV!.snp.right).offset(5)
            make.centerY.equalToSuperview()
        })
        
        self.nameLabel?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
 
        self.commentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.nameLabel!.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        })
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
