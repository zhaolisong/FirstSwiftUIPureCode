//
//  MvvmModel.swift
//  FirstSwiftUIPureCode
//
//  Created by ZhaoLisong on 2018/4/26.
//  Copyright © 2018 ZhaoLisong. All rights reserved.
//

import UIKit

public class MvvmModel: NSObject {
    var colorName : String?
    @objc dynamic var color: UIColor?

    func requestData() {
        let red = CGFloat(arc4random_uniform(255)) / CGFloat(255)
        let gre = CGFloat(arc4random_uniform(255)) / CGFloat(255)
        let blu = CGFloat(arc4random_uniform(255)) / CGFloat(255)
        let randomColor = UIColor.init(red: red, green: gre, blue: blu, alpha: 1)
        colorName = randomColor.description
        color = randomColor
    }
}
