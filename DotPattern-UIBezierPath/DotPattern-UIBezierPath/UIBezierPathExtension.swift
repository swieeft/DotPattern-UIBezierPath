//
//  UIBezierPathExtension.swift
//  DotPattern-UIBezierPath
//
//  Created by 박길남 on 2018. 8. 31..
//  Copyright © 2018년 swieeft. All rights reserved.
//

import Foundation
import UIKit

public extension UIBezierPath {
    
    @discardableResult
    public func m(to point: CGPoint) -> Self {
        move(to: point)
        return self
    }
    
    @discardableResult
    public func line(to point: CGPoint) -> Self {
        addLine(to: point)
        return self
    }
    
    @discardableResult
    public func quadCurve(to point: CGPoint, controlPoint: CGPoint) -> Self {
        addQuadCurve(to: point, controlPoint: controlPoint)
        return self
    }
    
    @discardableResult
    public func carve(to point: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> Self {
        addCurve(to: point, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        return self
    }
    
    @discardableResult
    public func arc(center: CGPoint, radius: CGFloat, start: CGFloat, end: CGFloat, clockwise: Bool) -> Self {
        addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: clockwise)
        return self
    }
}
