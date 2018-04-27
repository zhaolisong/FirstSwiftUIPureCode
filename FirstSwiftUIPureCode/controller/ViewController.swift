import UIKit

// 访问限制符：open/public/internal/fileprivate/private
// private : 只在作用域内访问
// fileprivate : 只在定义的文件内访问
// internal : 在源代码所在的整个模块都可以访问
// public : 可以被任何人访问; 但其他module中不可以override和继承
// open : 可以被任何人使用，包括override和继承
open class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableRowNumberOfSection1 = 10;
    var tableRowNumberOfSection2 = 20;
    // 声明 tableview
    var tableView : UITableView?
    

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyViewVC"
        // 加载 tableview
        setViews()
    }
    // 创建 setViews
    func setViews() {
        self.edgesForExtendedLayout=[]
        //初始化tableview并设置frame
        self.tableView = UITableView(frame:self.view!.frame)
        
        //设置tableview的代理对象
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //单元格复用
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier:"cell"/*为了提供表格显示性能，已创建完成的单元需重复使用*/)
        
        //将tableview添加到view试图上
        self.view?.addSubview(self.tableView!)

        //decelerationRate 属性调整 UIScrollView、UITableView、UICollectionView 滚动数据
        //方式1  使用系统定义的常量值:
        //  UIScrollViewDecelerationRateNormal：正常减速（默认值，0.998）
        //  UIScrollViewDecelerationRateFast：快速减速（0.99）
        //方式2  设置自定义值:
        //  decelerationRate 类型为 CGFloat，其范围是（0.0，1.0）
        self.tableView!.decelerationRate = 0.8
        
        //创建表头标签
        let frame = CGRect(x:0, y:0, width:self.view.bounds.size.width, height:30)
        let headerLabel = UILabel(frame: frame)
        headerLabel.backgroundColor = UIColor.black
        headerLabel.textColor = UIColor.white
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.text = "常见 UIKit 控件"
        headerLabel.font = UIFont.italicSystemFont(ofSize: 20)
        self.tableView!.tableHeaderView = headerLabel
        
        // FileManager.default 文件操作
    }
    
    
    //表视图有2个分区
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    //表视图分区里的行数
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section==0 ? tableRowNumberOfSection1 : tableRowNumberOfSection2;
    }
    //返回指定分区的头部
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section==0 ? "section001" : "section002"
    }
    //返回指定分区的尾部
    public func tableView(_ tableView:UITableView, titleForFooterInSection section:Int)->String? {
        return "有\(section==1 ? tableRowNumberOfSection1 : tableRowNumberOfSection2)个控件"
    }
    //修改删除按钮的文字
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删"
    }
    //滑动删除必须实现的方法
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("删除\(indexPath.row)")
        if (indexPath.section==1) {
            tableRowNumberOfSection1 = tableRowNumberOfSection1-1
        } else {
            tableRowNumberOfSection2 = tableRowNumberOfSection2-1
        }

        self.tableView?.deleteRows(at: [indexPath], with: .top)
    }
    //滑动删除
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete;
    }
    // UITableViewDelegate 方法，处理列表项的选中事件
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        let itemString = String(format:"0000%i", indexPath.row+1)
        let allertController = UIAlertController(title: "提示：", message: "你选中了【\(itemString)】", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        allertController.addAction(okAction)
        self.present(allertController, animated: true, completion: nil)
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //同一形式的单元格重复使用，在声明时已注册("cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        if (indexPath.section==0) {
            let image = UIImage(named:"heart.png")
            cell.imageView?.image = image
        }
        else {
            cell.detailTextLabel?.text = String(format:"这里是【00%i--00%i】介绍", indexPath.section+1, indexPath.row+1)
        }
        cell.textLabel!.text = String(format:"00%i--00%i", indexPath.section+1, indexPath.row+1)
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
        if (indexPath.row==2) {
            let pageScrollVC = PageScrollViewController()
            self.navigationController?.pushViewController(pageScrollVC, animated: true)
        }
        if (indexPath.row==3) {
            let gravityVC = GravityViewController()
            self.navigationController?.pushViewController(gravityVC, animated: true)
        }
        if (indexPath.row==4) {
            let mvvmVC = MvvmViewController()
            self.navigationController?.pushViewController(mvvmVC, animated: true)
        }
        return indexPath;
    }

    override open func didReceiveMemoryWarning() {
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

