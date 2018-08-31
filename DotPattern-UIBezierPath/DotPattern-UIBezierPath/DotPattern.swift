//
//  DotPattern.swift
//  DotPattern-UIBezierPath
//
//  Created by swieeft on 2018. 8. 31..
//  Copyright © 2018년 swieeft. All rights reserved.
//
import Foundation
import UIKit

struct Dot: Hashable {
    var row: Int
    var col: Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
}

class DotPattern {
    private var dotPoints:[Dot:CGPoint] = [:]
    
    func setDot(view:UIView, row:Int, col:Int) {
        
        let rowSize = view.frame.height / CGFloat(row)
        let colSize = view.frame.width / CGFloat(col)
        
        for i in 1...row {
            let rowPointY = rowSize * CGFloat(i)
            let colPointY = rowSize * CGFloat(i - 1)
            
            for j in 1...col {
                let rowPointX = colSize * CGFloat(j - 1)
                let colPointX = colSize * CGFloat(j)
                
                let centerX = (rowPointX + colPointX) / 2
                let centerY = (rowPointY + colPointY) / 2
                
                let center = CGPoint(x: centerX, y: centerY)
                
                let key = Dot(row: i, col: j)
                dotPoints[key] = center
            }
        }
    }
    
    func viewDot(view:UIView, layer:CAShapeLayer)  {
        let path = UIBezierPath()
        
        for point in dotPoints {
            path.m(to: point.value)
                .line(to: CGPoint(x: point.value.x, y: point.value.y + 2))
        }
        
        view.layer.addSublayer(layer)
    }
    
    func viewDot(view:UIView, layer:CAShapeLayer, rowRange: CountableClosedRange<Int>, colRange: CountableClosedRange<Int>)  {
        let path = UIBezierPath()
        
        for i in rowRange {
            for j in colRange {
                let key = Dot(row: i, col: j)
                
                if let point = dotPoints[key] {
                    path.m(to: point)
                        .line(to: CGPoint(x: point.x, y: point.y + 2))
                }
            }
        }
        
        view.layer.addSublayer(layer)
    }
    
    func isEmpty(row: Int, col: Int) -> Bool {
        let key = Dot(row: row, col: col)
        
        if let _ = dotPoints[key] {
            return false
        }
        
        return true
    }
    
    func get(_ row: Int, _ col: Int) -> CGPoint {
        let key = Dot(row: row, col: col)
        
        if let point = dotPoints[key] {
            return point
        }
        
        return CGPoint(x: 0, y: 0)
    }
}


































