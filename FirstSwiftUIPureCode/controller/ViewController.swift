//
//  ViewController.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/16.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // 声明 tableview
    var tableView : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyViewVC"
        // 加载 tableview
        setViews()
    }
    // 创建 setViews
    func setViews() {
        //初始化tableview并设置frame
        self.tableView = UITableView(frame:self.view!.frame)
        
        //设置tableview的代理对象
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        
        //将tableview添加到view试图上
        self.view?.addSubview(self.tableView!)
        //decelerationRate 属性调整 UIScrollView、UITableView、UICollectionView 滚动数据
        //使用
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 200; }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel!.text = String(format:"0000%i", indexPath.row+1)
        return cell
        
    }

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print(indexPath.section);
        print(indexPath.row)
        if (indexPath.row==0) {
            let base2DVC = Base2DViewController()
            //////////////////////////////
            // 第一种跳转方式（有三种返回方式）
            //////////////////////////////
                self.navigationController?.pushViewController(base2DVC , animated: true)
            //方式一：跳转到前一个页面
            //    self.navigationController?.popViewController(animated: true)
            //方式二：返回至指定的 ViewController
            //    self.navigationController?.popToViewController(FirstViewController(), animated: true)
            //方式三：返回至最初的ViewController
            //解释：通过pushView跳转firsView->secondView->thirdView，当在thirdView执行下面语句，则调回firtView
            //    self.navigationController?.popToRootViewController(animated: true)

            //////////////////////////////
            // 第二种跳转方式（自上而下）
            // 从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
            //////////////////////////////
            //    self.present(base2DVC, animated: true, completion: nil)
            //方式一：跳转到前一个页面
            //前提：通过 View 的 present 跳转的页面才能执行，否则找不到上一页, 同样可以执行关闭此页时的闭包操作
            //    self.dismiss(animated: true, completion: nil)
            //    // 延时调用
            //    DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(3/*second*/)) {
            //        self.dismiss(animated: true, completion: nil)
            //    }
        }
        if (indexPath.row==1) {
            let base2DTextVC = Base2DTextViewController()
            self.navigationController?.pushViewController(base2DTextVC , animated: true)
        }
        return indexPath;
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

extension UITableViewCell {
    func getCurrentViewController()-> UIViewController? {
        let window = UIApplication.shared.keyWindow
        let navigationController = window?.rootViewController
        if navigationController is UINavigationController {
            let navigation = navigationController as! UINavigationController
            return navigation.topViewController!
        }
        return nil
    }
}

