//
//  LineGrid.swift
//  AVFoundationTakingPhotoDemo
//
//  Created by z on 16/7/29.
//  Copyright © 2016年 LC. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.main().bounds.size.width
let ScreenHeight = UIScreen.main().bounds.size.height
let ShowingH = ScreenHeight - 52.0 - 115.0
let GoldRadio: CGFloat = 1.618

protocol LineGrid { }

//where Self: CALayer
extension LineGrid {
    
    
    
    func minddleVerticalLine(frame: CGRect) -> CGPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.size.width/2.0, y: 0))
        path.addLine(to: CGPoint(x: frame.size.width/2.0, y: frame.size.height))
        return path.cgPath
    }
    
    func middleHorizontalLine(frame: CGRect) -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frame.size.height/2.0))
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height/2.0))
        return path.cgPath
    }
    
    //对角线
    func diagnalLine(frame: CGRect) -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.size.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: frame.size.height))
        return path.cgPath
    }
    
    //三分 横
    func thirdHorizontalLine(frame: CGRect) -> [CGPath] {
        var pathRows:[CGPath] = [CGPath]()
        for i in 0..<3 {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: CGFloat(i+1) * frame.size.height/4.0))
            path.addLine(to: CGPoint(x: frame.size.width, y: CGFloat(i+1) * frame.size.height/4.0))
            pathRows.append(path.cgPath)
        }
        return pathRows
    }
    
    //三分 竖直
    func thirdVerticalLine(frame: CGRect) -> [CGPath] {
        var pathRows:[CGPath] = [CGPath]()
        for i in 0..<3 {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: CGFloat(i+1) * frame.size.width/4.0, y: 0))
            path.addLine(to: CGPoint(x: CGFloat(i+1) * frame.size.width/4.0, y: CGFloat(i+1) * frame.size.height))
            pathRows.append(path.cgPath)
        }
        return pathRows
    }
    
    //黄金分割 h = w * 1.618, w 屏幕宽度， h黄金分割高度。
    //根据屏幕高度，求宽度，如果宽度大于屏幕宽度，那么则根据宽度求高度
    private func isGoldenRadioWBiggerWidth() -> Bool {
        return UIScreen.main().bounds.size.width < ShowingH / GoldRadio
    }
    
    private func getGoldenRadioW() -> CGFloat {
        if isGoldenRadioWBiggerWidth() == false {
            return ShowingH / GoldRadio
        } else {
            return 0
        }
    }
    
    private func getNextAngle(angle: CGFloat) -> CGFloat {
        let newAngle = angle + CGFloat.pi * CGFloat(0.5)
        if  newAngle == CGFloat.pi * CGFloat(2) {
            return 0.0
        } else {
            return newAngle
        }
    }
    
    
    func godenRadioLeftBottomLine(frame: CGRect) -> CGPath{
        
        if getGoldenRadioW() != 0 { //说明黄金高度没有屏幕高度高，取黄金宽度
            
        } else {
            
        }
        
        let w1 = getGoldenRadioW()
        let A = CGPoint(x: (ScreenWidth - w1) / 2.0, y: 0)
        let B = CGPoint(x: A.x + w1, y: 0)
        let C = CGPoint(x: B.x, y: B.y + w1)
        let D = CGPoint(x: A.x, y: A.y + w1)
        
        let path = UIBezierPath()
        var startAngle: CGFloat = CGFloat.pi * CGFloat(0.5 * 3)
        var endAngle: CGFloat = getNextAngle(angle: startAngle)
        path.move(to: A)
        path.addArc(withCenter: D, radius: w1, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
        let w2 = w1 / GoldRadio
        let secondCenter = CGPoint(x: C.x - w2, y: C.y)
        startAngle = endAngle
        endAngle = getNextAngle(angle: startAngle)
        print(startAngle, "-", endAngle)
        path.addArc(withCenter: secondCenter, radius: w2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        
        let w3 = w2 / GoldRadio
        let thirdCenter = CGPoint(x: secondCenter.x, y: secondCenter.y + w2 - w3)
        startAngle = endAngle
        endAngle = getNextAngle(angle: startAngle)
        path.addArc(withCenter: thirdCenter, radius: w3, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let w4 = w3 / GoldRadio
        let fourCenter = CGPoint(x: thirdCenter.x - (w3 - w4), y: thirdCenter.y)
        startAngle = endAngle
        endAngle = getNextAngle(angle: startAngle)
        path.addArc(withCenter: fourCenter, radius: w4, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let w5 = w4 / GoldRadio
        let fiveCenter = CGPoint(x: fourCenter.x, y: fourCenter.y - (w4 - w5))
        startAngle = endAngle
        endAngle = getNextAngle(angle: startAngle)
        path.addArc(withCenter: fiveCenter, radius: w5, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let w6 = w5 / GoldRadio
        let sixCenter = CGPoint(x: fiveCenter.x + (w5 - w6), y: fiveCenter.y)
        startAngle = endAngle
        endAngle = getNextAngle(angle: startAngle)
        path.addArc(withCenter: sixCenter, radius: w6, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let w7 = w6 / GoldRadio
        let sevenCenter = CGPoint(x: sixCenter.x, y: fiveCenter.y + (w6 - w7))
        startAngle = endAngle
        endAngle = getNextAngle(angle: startAngle)
        path.addArc(withCenter: sevenCenter, radius: w7, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let w8 = w7 / GoldRadio
        let eightCenter = CGPoint(x: sevenCenter.x - (w7 - w8), y: sevenCenter.y )
        startAngle = endAngle
        endAngle = getNextAngle(angle: startAngle)
        path.addArc(withCenter: eightCenter, radius: w8, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let w9 = w8 / GoldRadio
        let nightCenter = CGPoint(x: eightCenter.x , y: eightCenter.y - (w8 - w9))
        startAngle = endAngle
        endAngle = getNextAngle(angle: startAngle)
        path.addArc(withCenter: nightCenter, radius: w9, startAngle: startAngle, endAngle: endAngle, clockwise: true)


        return path.cgPath
        
    }
    
    
    
    
}
