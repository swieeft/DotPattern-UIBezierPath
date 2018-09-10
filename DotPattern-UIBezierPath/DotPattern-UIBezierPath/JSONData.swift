//
//  JSONData.swift
//  DotPattern-UIBezierPath
//
//  Created by 박길남 on 2018. 9. 7..
//  Copyright © 2018년 swieeft. All rights reserved.
//

import Foundation

public struct JSONData:Decodable {
    var width:CGFloat?
    var height:CGFloat?
    var row:Int?
    var col:Int?
    var layers:[Layer]?
    
    public struct Layer:Decodable {
        var datas:[Data]?
        
        public struct Data:Decodable {
            var type:String?
            var startPoint:Point?
            var endPoint:Point?
            var curve:Curve?
            var arc:Arc?
            
            public struct Point:Decodable {
                var x:Int?
                var y:Int?
            }
            
            public struct Curve:Decodable {
                var controlPoint1:Point?
                var controlPoint2:Point?
            }
            
            public struct Arc:Decodable {
                var radius:CGFloat?
                var startAngle:CGFloat?
                var endAngle:CGFloat?
                var clockwise:Bool?
            }
        }
    }
}
