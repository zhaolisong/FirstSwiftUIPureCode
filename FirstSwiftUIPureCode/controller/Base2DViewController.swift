//
//  Base2DViewController.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/22.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

class Base2DViewController: UIViewController {
    // 声明 tableview
    var base2DView : Base2DUIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Base2DViewVC"
        //关闭导航栏半透明效果，这样布局就会从导航栏下面开始了
        self.navigationController?.navigationBar.isTranslucent = false
        // 加载 tableview
        setViews()
    }
    // 创建 setViews
    func setViews() {
        //初始化tableview并设置frame
        self.base2DView = Base2DUIView(frame:self.view!.frame)
                
        //将tableview添加到view试图上
        self.view?.addSubview(self.base2DView!)
        
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
