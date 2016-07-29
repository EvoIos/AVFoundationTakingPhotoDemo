//
//  LineGrid.swift
//  AVFoundationTakingPhotoDemo
//
//  Created by z on 16/7/29.
//  Copyright © 2016年 LC. All rights reserved.
//

import Foundation
import UIKit

protocol LineGrid {
    func minddleLine() -> CGPath
    
}

extension LineGrid {
    func minddleLine(frame: CGRect) -> CGPath{
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.size.width/2.0, y: 0))
        path.addLine(to: CGPoint(x: frame.size.width/2.0, y: frame.size.height))
        
        return path.cgPath
    }
}