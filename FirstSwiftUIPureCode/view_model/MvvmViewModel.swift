//
//  MvvmViewModel.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/26.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

class MvvmViewModel: NSObject {
    var mvvmModel : MvvmModel!
    @objc dynamic var color : UIColor? //使用KVO监听的属性用dynamic关键字修饰

    override init() {
        super.init()
        self.mvvmModel = MvvmModel()
        self.mvvmModel.addObserver(self, forKeyPath: "color", options: [.old, .new], context: nil)
    }

    //模拟请求网络数据,在数据变化时实现自动更新UI
    public func requestData() {
        self.mvvmModel.requestData()
    }

    deinit {
        self.mvvmModel.removeObserver(self, forKeyPath: "color")
    }
}

extension MvvmViewModel {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if  keyPath == "color" {
            //这里只是介绍 Model 的作用，将逻辑判断放在VM中,减少了 Controller 中的代码量
            if self.mvvmModel.colorName == "green" {
                color = UIColor.green
            }
            else {
                color = mvvmModel.color
            }
        }
        //实现 VM 与 V 绑定的方式,使用通知或者 KVO
        //NotificationCenter.default.post(name: NSNotification.Name.init(kMyTextViewUpdateUI), object: nil)
    }
}


