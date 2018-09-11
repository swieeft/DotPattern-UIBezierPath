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

public class DotPattern {
    private var view:UIView
    private var dotPoints:[Dot:CGPoint]
    private var dotLayer:CAShapeLayer
    private var _rowSize:CGFloat = 0.0
    private var _colSize:CGFloat = 0.0
    
    public var rowSize:CGFloat {
        get {
            return _rowSize
        }
    }
    
    public var colSize:CGFloat {
        get {
            return _colSize
        }
    }
    
    public init(view: UIView) {
        self.view = view
        self.dotPoints = [:]
        
        self.dotLayer = CAShapeLayer()
        dotLayer.strokeEnd = 1
        dotLayer.strokeColor = UIColor.black.cgColor
        dotLayer.lineWidth = 1
        dotLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(self.dotLayer)
    }
    
    public init(view: UIView, row: Int, col: Int) {
        self.view = view
        
        self.dotLayer = CAShapeLayer()
        dotLayer.strokeEnd = 1
        dotLayer.strokeColor = UIColor.black.cgColor
        dotLayer.lineWidth = 1
        dotLayer.fillColor = UIColor.clear.cgColor
        
        self.dotPoints = [:]
        setDot(row: row, col: col)
        
        view.layer.addSublayer(self.dotLayer)
    }
    
    public init(view: UIView, layer:CAShapeLayer, row: Int, col: Int) {
        self.view = view
        self.dotLayer = layer
        
        self.dotPoints = [:]
        setDot(row: row, col: col)
        
        view.layer.addSublayer(self.dotLayer)
    }
    
    public func setDot(row:Int, col:Int) {
        
        self._rowSize = view.frame.height / CGFloat(row)
        self._colSize = view.frame.width / CGFloat(col)
        
        for i in 1...row {
            let rowPointY = self.rowSize * CGFloat(i)
            let colPointY = self.rowSize * CGFloat(i - 1)
            
            for j in 1...col {
                let rowPointX = self.colSize * CGFloat(j - 1)
                let colPointX = self.colSize * CGFloat(j)
                
                let centerX = (rowPointX + colPointX) / 2
                let centerY = (rowPointY + colPointY) / 2
                
                let center = CGPoint(x: centerX, y: centerY)
                
                let key = Dot(row: i, col: j)
                dotPoints[key] = center
            }
        }
    }
    
    public func viewDot()  {
        let path = UIBezierPath()
        
        for point in dotPoints {
            path.m(to: point.value)
                .line(to: CGPoint(x: point.value.x, y: point.value.y + 2))
        }
        
        self.dotLayer.path = path.cgPath
        self.dotLayer.isHidden = false
    }
    
    public func viewDot(rowRange: CountableClosedRange<Int>, colRange: CountableClosedRange<Int>)  {
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
        
        self.dotLayer.path = path.cgPath
        self.dotLayer.isHidden = false
    }
    
    public func hiddenDot() {
        self.dotLayer.isHidden = true
    }
    
    public func isEmpty(row: Int, col: Int) -> Bool {
        let key = Dot(row: row, col: col)
        
        if let _ = dotPoints[key] {
            return false
        }
        
        return true
    }
    
    public func get(_ row: Int, _ col: Int) -> CGPoint {
        let key = Dot(row: row, col: col)
        
        if let point = dotPoints[key] {
            return point
        }
        
        return CGPoint(x: 0, y: 0)
    }
    
    public func get(point:JSONData.Layer.Data.Point) -> CGPoint {
        guard let row = point.x, let col = point.y else {
            return CGPoint(x: 0, y: 0)
        }
        
        return get(row, col)
    }
    
    public func createPath(url: String, completion: @escaping (_ paths:[UIBezierPath], _ success:Bool) -> Void) {
        getData(url: url) { (data, success) in
            if success {
                
                var paths:[UIBezierPath] = []
                
                guard let row = data.row, let col = data.col else {
                    completion(paths, false)
                    return
                }
                
                self.setDot(row: row, col: col)
                
                if let layers = data.layers {
                    for layer in layers {
                        let bezierPath = self.getPath(layer: layer)
                        
                        if bezierPath.isEmpty == false {
                            paths.append(bezierPath)
                        }
                        
                        completion(paths, true)
//                        if bezierPath.isEmpty == false {
//                            let shapeLayer = CAShapeLayer()
//                            shapeLayer.path = bezierPath.cgPath
//                            shapeLayer.strokeEnd = 0
//                            shapeLayer.strokeColor = UIColor.black.cgColor
//                            shapeLayer.lineWidth = 3
//                            shapeLayer.fillColor = UIColor.clear.cgColor
//
//                            let duration: TimeInterval = 3
//
//                            let animation = CABasicAnimation(keyPath: "strokeEnd")
//                            animation.toValue = 1
//                            animation.duration = duration
//                            animation.fillMode = kCAFillModeForwards
//                            animation.isRemovedOnCompletion = false
//
//                            shapeLayer.add(animation, forKey: "ani")
//
//                            self.view.layer.addSublayer(shapeLayer)
//                        }
                    }
                }
            }
        }
    }
    
    private func getData(url urlStr:String, completion: @escaping (_ data:JSONData, _ success:Bool) -> Void) {
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            guard let data = data else { return }
            
            var jsonData:JSONData = JSONData()
            
            do {
                jsonData = try JSONDecoder().decode(JSONData.self, from: data)
                
            } catch {
                print("error: \(error)")
                completion(jsonData, false)
            }
            
            DispatchQueue.main.async(execute: {
                completion(jsonData, true)
            })
        });
        task.resume()
    }
    
    private func getPath(layer:JSONData.Layer) ->  UIBezierPath {
        let bezierPath = UIBezierPath()
        
        guard let datas = layer.datas else {
            return bezierPath
        }
        
        for data in datas {
            guard let type = data.type else {
                continue
            }
            
            switch type {
            case "line":
                if let path = createLine(data: data, currentPoint: bezierPath.currentPoint) {
                    bezierPath.append(path)
                }
            case "curve":
                if let path = createCurve(data: data, currentPoint: bezierPath.currentPoint) {
                    bezierPath.append(path)
                }
            case "quadCurve":
                if let path = createQuadCurve(data: data, currentPoint: bezierPath.currentPoint) {
                    bezierPath.append(path)
                }
            case "arc":
                if let path = createArc(data: data, currentPoint: bezierPath.currentPoint) {
                    bezierPath.append(path)
                }
            default:
                break
            }
        }
        
        return bezierPath
    }
    
    private func createLine(data: JSONData.Layer.Data, currentPoint:CGPoint) -> UIBezierPath? {
        
        let path:UIBezierPath = UIBezierPath()
        
        guard let startPoint = data.startPoint, let endPoint = data.endPoint else {
            return nil
        }
        
        let start = get(point: startPoint)
        let end = get(point: endPoint)
        
        if start == currentPoint {
            path.line(to: end)
        } else {
            path.m(to: start)
                .line(to: end)
        }
        
        return path
    }
    
    private func createCurve(data: JSONData.Layer.Data, currentPoint:CGPoint) -> UIBezierPath? {
        
        let path:UIBezierPath = UIBezierPath()
        
        guard let startPoint = data.startPoint, let endPoint = data.endPoint, let curve = data.curve else {
            return nil
        }
        
        guard let controlPoint1 = curve.controlPoint1, let controlPoint2 = curve.controlPoint2 else {
            return nil
        }
        
        let start = get(point: startPoint)
        let end = get(point: endPoint)
        let control1 = get(point: controlPoint1)
        let control2 = get(point: controlPoint2)
        
        if start == currentPoint {
            path.curve(to: end, controlPoint1: control1, controlPoint2: control2)
        } else {
            path.m(to: start)
                .curve(to: end, controlPoint1: control1, controlPoint2: control2)
        }
        
        return path
    }
    
    private func createQuadCurve(data: JSONData.Layer.Data, currentPoint:CGPoint) -> UIBezierPath? {
        
        let path:UIBezierPath = UIBezierPath()
        
        guard let startPoint = data.startPoint, let endPoint = data.endPoint, let curve = data.curve else {
            return nil
        }
        
        guard let controlPoint = curve.controlPoint1 else {
            return nil
        }
        
        let start = get(point: startPoint)
        let end = get(point: endPoint)
        let control = get(point: controlPoint)
        
        if start == currentPoint {
            path.m(to: start)
                .quadCurve(to: end, controlPoint: control)
        } else {
            path.m(to: start)
                .quadCurve(to: end, controlPoint: control)
        }
        
        return path
    }
    
    private func createArc(data: JSONData.Layer.Data, currentPoint:CGPoint) -> UIBezierPath? {
        
        let path:UIBezierPath = UIBezierPath()
        
        guard let centerPoint = data.startPoint, let arc = data.arc else {
            return nil
        }
        
        guard let radius = arc.radius, let start = arc.startAngle, let end = arc.endAngle, let clockwise = arc.clockwise else {
            return nil
        }
        
        let center = get(point: centerPoint)
        
        path.m(to: CGPoint(x: center.x + radius, y: center.y))
            .arc(center: center, radius: radius, start: start, end: end, clockwise: clockwise)
        
        return path
    }
}


































