//
//  GravityViewController.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/24.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit
import CoreMotion

class GravityViewController: ViewController {
    
    var ball : UIImageView!
    var speedX : UIAccelerationValue = 0
    var speedY : UIAccelerationValue = 0
    var motionManager: CMMotionManager = CMMotionManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //放一个小球在中央
        let path = Bundle.main.path(forResource: "pic_icon", ofType: "png")
        let srcImage = UIImage(contentsOfFile: path!)
        ball = UIImageView(image:srcImage)
        ball.frame = CGRect(x:0, y:0, width:50, height:50)
        ball.center = self.view.center
        self.view.addSubview(ball)

        // 设置通知频率
        motionManager.accelerometerUpdateInterval = 1/60

        // 如果加速器可用
        if motionManager.isAccelerometerAvailable {
            // 建立一个监听队列
            let queue = OperationQueue.current
            // 更新监听队列，并设置回调函数用于接受加速度通知
            motionManager.startAccelerometerUpdates(to: queue!, withHandler/*回调函数*/: {
                (accelerometerData/*accelerometerData.acceleration相关属性可以获取x、y、z各个方向的加速度*/, error) in
                //动态设置小球位置
                self.speedX += accelerometerData!.acceleration.x
                self.speedY +=  accelerometerData!.acceleration.y
                var posX=self.ball.center.x + CGFloat(self.speedX)
                var posY=self.ball.center.y - CGFloat(self.speedY)
                //碰到边框后的反弹处理
                if posX<0 {
                    posX=0;
                    //碰到左边的边框后以0.4倍的速度反弹
                    self.speedX *= -0.4
                    
                }else if posX > self.view.bounds.size.width {
                    posX=self.view.bounds.size.width
                    //碰到右边的边框后以0.4倍的速度反弹
                    self.speedX *= -0.4
                }
                if posY<0 {
                    posY=0
                    //碰到上面的边框不反弹
                    self.speedY=0
                } else if posY>self.view.bounds.size.height{
                    posY=self.view.bounds.size.height
                    //碰到下面的边框以1.5倍的速度反弹
                    self.speedY *= -1.5
                }
                self.ball.center = CGPoint(x:posX, y:posY)
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
