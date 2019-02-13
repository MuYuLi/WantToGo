//
//  WGGuangCatrgoryController.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/11.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import URLNavigator

class WGGuangCategoryController: WGViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var outCategoryId : String?
    var categoryname : String?
    var page : NSInteger = 0
    
    var collectionView : UICollectionView!
    
    var categoryList : Array<WGGuangCategoryDataListItem>? {
        didSet {
            self.collectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.categoryname!
        self.initSubViews()
        self.loadListData()
    }

    
    init(navigator: NavigatorType, categoryid: String, categoryname: String) {
        self.outCategoryId = categoryid
        self.categoryname = categoryname
        
        super.init(navigator: navigator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initSubViews() -> Void {

        let layout = UICollectionViewFlowLayout.init()
        
        layout.itemSize = CGSize.init(width: (kMainScreenWidth-50)/2, height: 240)
        //水平间隔
        layout.minimumInteritemSpacing = 0.0
        //垂直行间距
        layout.minimumLineSpacing = 15.0
        
        layout.sectionInset = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 15)
        
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: kMainScreenHeight), collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(WGGuangCategoryListCell.self, forCellWithReuseIdentifier:"WGGuangCategoryListCell")
        self.collectionView.contentSize = CGSize.init(width: kMainScreenWidth, height: kMainScreenHeight)
//        self.collectionView.clipsToBounds = false
//        self.collectionView.isPagingEnabled = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
    }
    
    //MARK: ---------    UICollectionDelegate && UICollectionDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WGGuangCategoryListCell", for: indexPath) as! WGGuangCategoryListCell
        
        
        let listItem = self.categoryList?[indexPath.row]
//            as! WGGuangCategoryDataListItem
        
        cell.loadUIWithData(listItem!)
        
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! MYLCardCollectionCell
//
//        self.currentImageVFrame = cell.imageV?.bounds
//
//        if self.selectItemBlock != nil {
//            self.selectItemBlock!(indexPath.row,self.currentImageVFrame!)
//        }
    }

    
    
    
    func loadListData() -> Void {
        let dict = NSMutableDictionary()
        dict.setValue(self.outCategoryId, forKey: "outCategoryId")
        dict.setValue("\(self.page)", forKey: "page")

        NetworkRequest(.guangCategoryListApi(Dict: dict as! [String : Any])) { (response) -> (Void) in
        
            if let categoryListModel = WGGuangCategoryListModel.deserialize(from: response){
                if categoryListModel.code == SuccessCode {
                    self.categoryList = categoryListModel.data?.records!
                }
            }
            
        }
    }

}
