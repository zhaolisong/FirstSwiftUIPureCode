//
//  Base2DTextViewController.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/23.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

class Base2DTextViewController: ViewController {
    // 声明 tableview
    var base2DTextView : Base2DTextUIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Base2DTextViewVC"
        // 加载 tableview
        setViews()
    }

    // 创建 setViews
    override func setViews() {
        //初始化tableview并设置frame
        self.base2DTextView = Base2DTextUIView(frame:self.view!.frame)
        
        //将tableview添加到view试图上
        self.view?.addSubview(self.base2DTextView!)
        
        //延时调用
//        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(3/*second*/)) {
//            self.dismiss(animated: true, completion: nil)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
