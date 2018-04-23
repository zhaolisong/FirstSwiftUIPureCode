//
//  Base2DUIView.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/18.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

class Base2DUIView: UIView {

    var cgView:UIView?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        //获取画笔上下文
        let context:CGContext =  UIGraphicsGetCurrentContext()!
        context.setAllowsAntialiasing(true) //抗锯齿设置
        context.setFillColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor)
        context.fill(rect)
        
        //绘制点 或 实心圆
        context.setFillColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        context.fillEllipse( in: CGRect(x: 10, y: 110, width: 2, height: 2))
        context.fillEllipse( in: CGRect(x: 15, y: 110, width: 1, height: 1))
        context.fillEllipse( in: CGRect(x: 20, y: 110, width: 0.5, height: 0.5))
        
        //绘制直线
        context.setStrokeColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1 );//设置画笔颜色方法一
        context.setLineWidth(1);//线条宽度
        context.move(to: CGPoint(x: 10, y: 140))//开始点位置
        context.addLine(to: CGPoint(x: 100, y: 140))//结束点位置
        context.strokePath();
        
        //绘制虚线
        context.setLineWidth(1);
        let dashArray: [CGFloat] = [2, 6, 4, 2]
        context.setLineDash(phase: 1, lengths: dashArray )
        context.move(to: CGPoint(x: 120, y: 140))//开始点位置
        context.addLine(to: CGPoint(x: 180, y: 140))//结束点位置
        context.strokePath();
        
        context.setLineDash(phase: 1, lengths: [1,1] )//还原点类型
        context.move(to: CGPoint(x: 200, y: 140))//开始点位置
        context.addLine(to: CGPoint(x: 260, y: 140))//结束点位置
        context.strokePath();
        
        //绘制曲线
        context.setLineDash(phase: 0, lengths: [1,0] )//还原点类型
        
        context.move(to: CGPoint(x: 10, y: 180))//开始点位置
        context.addCurve(to: CGPoint(x: 150, y: 180), control1: CGPoint(x: 50, y: 190), control2: CGPoint(x: 90, y: 170))
        context.strokePath();
        
        context.move(to: CGPoint(x: 160, y: 180))//开始点位置
        context.addQuadCurve(to: CGPoint(x: 250, y: 180), control: CGPoint(x: 200, y: 165))
        context.strokePath();
        
        //画圆
        context.setLineWidth(0.5);//线条宽度
        context.setStrokeColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1);
        context.addEllipse(in: CGRect(x: 10, y: 220, width: 20, height: 20)); //画圆 x,y左上角坐标
        context.strokePath() //关闭路径
        
        //画圆弧，单位弧度，clockwise: 顺时针计算，弧度 = 角度 * π ／ 180 x,y中心点坐标
        context.setStrokeColor( UIColor.red.cgColor );//设置画笔颜色方法二
        context.addArc(center: CGPoint(x: 50, y: 230), radius: 10, startAngle: 0, endAngle: CGFloat(90 * Double.pi/180), clockwise: true )
        context.strokePath() //关闭路径
        context.addArc(center: CGPoint(x: 70, y: 230), radius: 10, startAngle: 0, endAngle: CGFloat(90 * Double.pi/180), clockwise: false )
        context.strokePath() //关闭路径
        
        //绘制矩形
        context.setStrokeColor( UIColor.gray.cgColor );
        context.addRect(CGRect(x: 100, y: 220, width: 30, height: 20 ))
        context.strokePath();
        
        //字符串 x,y左上角坐标
        let strTxt:String = "你好！你好！你好！"
        strTxt.draw(at: CGPoint(x: 10, y: 260), withAttributes: nil )
//        let swift3TextAttributes = [
//            NSFontAttributeName: textFont,
//            NSForegroundColorAttributeName: textColor,
//            ] as [String : Any]
        let swift4TextAttributes:[NSAttributedStringKey : Any] = [
            NSAttributedStringKey.foregroundColor : UIColor.orange.cgColor,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 6 )
            ]
        strTxt.draw(at: CGPoint(x: 80, y: 260), withAttributes: swift4TextAttributes)
//        context.saveGState()
//        context.textMatrix = CGAffineTransform.identity
//        context.translateBy(x: 0, y: 100)
//        context.scaleBy(x: 1, y: -1)
//        let stringPath = CGMutablePath()
//        stringPath.addEllipse(in: CGRect(x: 50, y: 100, width: 100, height: 50))
//        context.addPath(stringPath);
//        context.strokePath();
//        let attrString = NSAttributedString(string: strTxt)
//        let frameSetter = CTFramesetterCreateWithAttributedString(attrString)
//        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attrString.length), stringPath, nil)
//        CTFrameDraw(frame, context)
//        context.restoreGState()
        
        //绘制图片
        let path = Bundle.main.path(forResource: "pic_icon", ofType: "png")
        let srcImage = UIImage(contentsOfFile: path!)
        srcImage?.draw(at: CGPoint(x: 140, y: 220))
        context.saveGState()             //Transform使用==保存初始状态
        context.translateBy(x: 10, y: 10)//Transform使用==变换1：向左向下本别平移10点
        context.scaleBy(x: 0.5, y: 0.5)  //Transform使用==变换2：缩放成0.0
        context.rotate(by: CGFloat.pi/18)//Transform使用==变换3：旋转10度
        srcImage?.draw(in: CGRect(x: 260, y: 220, width: 50, height: 50 ))
        context.restoreGState()//恢复成初始状态
        
        // 复杂图形1
        let minX = 10,  maxX = 50
        let minY = 400, maxY = 500
        let midX = 30,  midY = 450
        let topLeft = CGPoint(x:minX, y: minY)
        let topRight = CGPoint(x:maxX, y:minY)
        let bottomRight = CGPoint(x:maxX, y:maxY)
        let bottomLeft = CGPoint(x:minX, y:maxY)
        let center = CGPoint(x:midX, y:midY)

        let bezierPath = UIBezierPath() //创建一个贝塞尔路径
        bezierPath.move(to: topLeft)
        bezierPath.addLine(to: topRight)
        bezierPath.addLine(to: bottomLeft)
        bezierPath.addCurve(to: bottomRight, controlPoint1: center, controlPoint2: center)
        bezierPath.close()

        UIColor.green.setFill()  //设定颜色
        UIColor.black.setStroke()//设定画笔
        bezierPath.fill()
        bezierPath.stroke()
        
        // 复杂图形2
        let circleRect = CGRect(x: 60+20, y: 400, width: 60, height: 60)
        let squareRect = CGRect(x: 60, y: 400+15, width: 100, height: 30)
        let circlePath = UIBezierPath(ovalIn: circleRect)
        let squarePath = UIBezierPath(roundedRect: squareRect, cornerRadius: 10)
        bezierPath.append(circlePath)
        bezierPath.append(squarePath)
        UIColor.green.setFill()
        UIColor.black.setStroke()
        bezierPath.fill()
        
        // 放射性渐变/辐射性渐变
        let gradientRect = CGRect(x:10, y:300, width: 100, height: 50)
        let gradientCircle = CGRect(x:150, y:290, width: 150, height: 70)
        let colorSpace = CGColorSpaceCreateDeviceRGB()              //使用rgb颜色空间
        let compoents:[CGFloat] = [0xfc/255, 0x68/255, 0x20/255, 1, //颜色数组（这里使用三组颜色作为渐变）
                                   0xfe/255, 0xd3/255, 0x2f/255, 1, //fc(red) 68(green) 20(blue) 1(alpha)
                                   0xb1/255, 0xfc/255, 0x33/255, 1]
        let locations:[CGFloat] = [0, 0.5, 1]                       //设置颜色所在位置（范围0~1)
        let gradient = CGGradient(colorSpace: colorSpace,           //生成渐变色（count参数表示渐变个数）
                                  colorComponents: compoents,
                                  locations: locations,
                                  count: locations.count)
        let start = CGPoint(x: gradientRect.minX+30, y: gradientRect.minY)//渐变开始位置
        let end = CGPoint(x: gradientRect.maxX, y: gradientRect.maxY)  //渐变结束位置
        context.clip(to: gradientRect) //裁剪绘制区域
        context.drawLinearGradient(gradient!, start: start, end: end, options: .drawsBeforeStartLocation)
        context.resetClip()
        context.clip(to: gradientCircle) //裁剪绘制区域
        context.drawRadialGradient(gradient!,
                                   startCenter: CGPoint(x:150, y:325),
                                   startRadius: 25,
                                   endCenter: CGPoint(x:250, y:325),
                                   endRadius: 4,
                                   options: .drawsBeforeStartLocation)
        
        
    }
}
