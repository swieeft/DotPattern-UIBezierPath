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
    
    public func createPath(url: String) {
        getData(url: url) { (data, success) in
            if success {
                guard let row = data.row, let col = data.col else {
                    return
                }
                
                self.setDot(row: row, col: col)
                
                if let layers = data.layers {
                    for layerPathData in layers {
                        let bezierPath = self.getPath(layerPathData: layerPathData)
                        
                        if bezierPath.isEmpty == false {
                            let layer = CAShapeLayer()
                            layer.path = bezierPath.cgPath
                            layer.strokeEnd = 1
                            layer.strokeColor = UIColor.black.cgColor
                            layer.lineWidth = 3
                            layer.fillColor = UIColor.clear.cgColor
                            
                            self.view.layer.addSublayer(layer)
                        }
                    }
                }
            }
        }
    }
    
    func getPath(layerPathData:JSONData.dotPatternLayer) ->  UIBezierPath {
        let bezierPath = UIBezierPath()
        
        if let paths = layerPathData.path {
            for path in paths {
                if let type = path.type {
                    switch type {
                    case "move" :
                        if let point = path.point, let row = point.x, let col = point.y {
                            bezierPath.m(to: self.get(row, col))
                        }
                    case "curve" :
                        if let point = path.point, let cp1 = path.controlPoint1, let cp2 = path.controlPoint2 {
                            if let pRow = point.x, let pCol = point.y, let cp1Row = cp1.x, let cp1Col = cp1.y, let cp2Row = cp2.x, let cp2Col = cp2.y {
                                bezierPath.curve(to: self.get(pRow, pCol), controlPoint1: self.get(cp1Row, cp1Col), controlPoint2: self.get(cp2Row, cp2Col))
                            }
                        }
                    case "quadCurve" :
                        if let point = path.point, let cp = path.controlPoint1 {
                            if let pRow = point.x, let pCol = point.y, let cpRow = cp.x, let cpCol = cp.y {
                                bezierPath.quadCurve(to: self.get(pRow, pCol), controlPoint: self.get(cpRow, cpCol))
                            }
                        }
                    case "arc" :
                        if let point = path.point, let radius = path.radius, let start = path.startAngle, let end = path.endAngle, let clockwise = path.clockwise {
                            if let row = point.x, let col = point.y {
                                bezierPath.arc(center: self.get(row, col), radius: radius, start: start, end: end, clockwise: clockwise)
                            }
                        }
                    default :
                        break
                    }
                }
            }
        }
        
        return bezierPath
    }
    
    func getData(url urlStr:String, completion: @escaping (_ data:JSONData, _ success:Bool) -> Void) {
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
}


































