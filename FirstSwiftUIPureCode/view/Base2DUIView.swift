//
//  Base2DUIView.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/18.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

class Base2DUIView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        //获取画笔上下文
        let context:CGContext =  UIGraphicsGetCurrentContext()!
        context.setAllowsAntialiasing(true) //抗锯齿设置
        context.setFillColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor)
        context.fill(rect)
        
        //绘制点 或 实心圆
        context.fillEllipse( in: CGRect(x: 10, y: 10, width: 2, height: 2))
        context.fillEllipse( in: CGRect(x: 15, y: 10, width: 1, height: 1))
        context.fillEllipse( in: CGRect(x: 20, y: 10, width: 0.5, height: 0.5))
        
        //绘制直线
        context.setStrokeColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1 );//设置画笔颜色方法一
        context.setLineWidth(1);//线条宽度
        context.move(to: CGPoint(x: 10, y: 40))//开始点位置
        context.addLine(to: CGPoint(x: 100, y: 40))//结束点位置
        context.strokePath();
        
        //绘制虚线
        context.setLineWidth(1);
        let dashArray: [CGFloat] = [2, 6,4,2 ]
        context.setLineDash(phase: 1, lengths: dashArray )
        context.move(to: CGPoint(x: 120, y: 40))//开始点位置
        context.addLine(to: CGPoint(x: 180, y: 40))//结束点位置
        context.strokePath();
        
        context.setLineDash(phase: 1, lengths: [1,1] )//还原点类型
        context.move(to: CGPoint(x: 200, y: 40))//开始点位置
        context.addLine(to: CGPoint(x: 260, y: 40))//结束点位置
        context.strokePath();
        
        //绘制曲线
        context.setLineDash(phase: 0, lengths: [1,0] )//还原点类型
        
        context.move(to: CGPoint(x: 10, y: 80))//开始点位置
        context.addCurve(to: CGPoint(x: 150, y: 80), control1: CGPoint(x: 50, y: 90), control2: CGPoint(x: 90, y: 70))
        context.strokePath();
        
        context.move(to: CGPoint(x: 160, y: 80))//开始点位置
        context.addQuadCurve(to: CGPoint(x: 250, y: 80), control: CGPoint(x: 200, y: 65))
        context.strokePath();
        
        //画圆
        context.setLineWidth(0.5);//线条宽度
        context.setStrokeColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1);
        context.addEllipse(in: CGRect(x: 10, y: 120, width: 20, height: 20)); //画圆 x,y左上角坐标
        context.strokePath() //关闭路径
        
        //画圆弧，单位弧度，clockwise: 顺时针计算，弧度 = 角度 * π ／ 180 x,y中心点坐标
        context.setStrokeColor( UIColor.red.cgColor );//设置画笔颜色方法二
        context.addArc(center: CGPoint(x: 50, y: 130), radius: 10, startAngle: 0, endAngle: CGFloat(90 * Double.pi/180), clockwise: true )
        context.strokePath() //关闭路径
        context.addArc(center: CGPoint(x: 70, y: 130), radius: 10, startAngle: 0, endAngle: CGFloat(90 * Double.pi/180), clockwise: false )
        context.strokePath() //关闭路径
        
        //绘制矩形
        context.setStrokeColor( UIColor.gray.cgColor );
        context.addRect(CGRect(x: 100, y: 120, width: 30, height: 20 ))
        context.strokePath();
        
        //字符串 x,y左上角坐标
        let strTxt:String = "你好！"
        strTxt.draw(at: CGPoint(x: 10, y: 160), withAttributes: nil )
        
        let textAttributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey(rawValue: kCTForegroundColorAttributeName as String as String) : UIColor.blue.cgColor,
            NSAttributedStringKey(rawValue: kCTFontAttributeName as String as String) : UIFont.systemFont(ofSize: 8 )
        ]
        strTxt.draw(at: CGPoint(x: 80, y: 160), withAttributes: textAttributes )
        
        //绘制图片
        let path = Bundle.main.path(forResource: "pic_icon", ofType: "png")
        let srcImage = UIImage(contentsOfFile: path!)
        srcImage?.draw(at: CGPoint(x: 10, y: 200))
        srcImage?.draw(in: CGRect(x: 200, y: 200, width: 50, height: 50 ))
    }
}
