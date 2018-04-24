//
//  ScrollViewController.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/24.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

class PageScrollViewController: ViewController {
    let numOfPages = 4
    let pageWidth = 320
    let pageHeight = 360

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PageScrollVC"

        //scrollView的初始化
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        //为了让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        scrollView.contentSize = CGSize(width: pageWidth * numOfPages, height: pageHeight)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        //添加子页面
        for i in 0 ..< numOfPages{
            let onePage = OnePageViewController(number:(i+1))
            onePage.view.frame = CGRect(x:pageWidth*i, y:100, width:pageWidth, height:pageHeight)
            scrollView.addSubview(onePage.view)
        }
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class OnePageViewController : ViewController {
    var number:Int!
    let colorMap=[
        1:UIColor.black,
        2:UIColor.orange,
        3:UIColor.blue,
        4:UIColor.purple
    ]
    
    init(number initNumber:Int) {
        self.number = initNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad(){
        let numberLabel = UILabel(frame:CGRect(x:130, y:50, width:50, height:30))
        numberLabel.text = "第\(number!)页"
        numberLabel.textColor = UIColor.white
        self.view.addSubview(numberLabel)
        self.view.backgroundColor = colorMap[number]
    }
    
}
