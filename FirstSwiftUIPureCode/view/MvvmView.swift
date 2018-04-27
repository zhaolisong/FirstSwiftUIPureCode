//
//  MVVMView.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/26.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit



class MvvmView: UIView {

    fileprivate lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        btn.setTitle("hello", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.titleLabel?.textColor = UIColor.white
        btn.backgroundColor = UIColor.orange
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        return btn
    }()

    var mvvmViewModel:MvvmViewModel!
    
    init(viewModel : MvvmViewModel) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.frame = frame;
        self.mvvmViewModel = viewModel
        // 添加子视图
        setupSubViews()
        // 绑定 ViewModel，使用“通知”或KVO
        bindingViewModel()
        // 请求数据
        self.mvvmViewModel.requestData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func testDomain() {}

    deinit {
        self.mvvmViewModel.removeObserver(self, forKeyPath: "color")
    }
}


private var mvvmContext = 0


fileprivate extension MvvmView {
    func setupSubViews() {
        // 添加子视图
        addSubview(button)
    }

    func bindingViewModel() {
        // 使用“通知”，监听数据属性变化
        /*NotificationCenter.default.addObserver(forName: NSNotification.Name.init(kMyTextViewUpdateUI), object: nil, queue: OperationQueue.main) { [weak self] notify in
            guard let strongSelf = self else {
                return
            }
            strongSelf.backgroundColor = strongSelf.textViewModel.color
        }*/

        // 使用“KVO”，监听数据属性变化
        self.mvvmViewModel.addObserver(self,
            forKeyPath: "color",
            options: [.old, .new],
            context: &mvvmContext)
    }

    // @objc 的作用
    // 1、
    // 2、允许这个函数在“运行时”通过oc的消息机制调用
    // 可以使用@objc修饰的类型包括：
    // 1、未嵌套的类
    // 2、协议
    // 3、非泛型枚举（仅限于原始值为整形的类型）
    // 4、类和协议中的属性和方法
    // 5、构造器和析构器
    // 6、下标
    @objc func buttonClick() {
        print("hello")
        self.mvvmViewModel.requestData()
    }
}

extension MvvmView {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "color" {
            self.backgroundColor = mvvmViewModel.color
        }
    }
}
