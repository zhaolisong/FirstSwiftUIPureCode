//
//  Base2DTextUIView.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/23.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

class Base2DTextUIView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //为方便看到效果，背景使用黑色
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //保存初始状态
        context.saveGState()
        
        //将坐标系系上下翻转
        context.textMatrix = CGAffineTransform.identity
        context.translateBy(x: 0, y: self.bounds.height+200)
        context.scaleBy(x: 1, y: -1)
        
        //创建并设置路径(排版区域)
        let path = CGMutablePath()
        //绘制椭圆
        path.addEllipse(in: self.bounds.insetBy(dx: 1, dy: 1))
        //绘制边框
        context.addPath(path)
        context.strokePath()
        
        //根据framesetter和绘图区域创建CTFrame
        let str = "欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!欢迎访问hangge.com!"
        let attrString = NSAttributedString(string:str)
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length),
                                             path, nil)
        
        //使用CTFrameDraw进行绘制
        CTFrameDraw(frame, context)
        
        //恢复成初始状态
        context.restoreGState()
    }
}
