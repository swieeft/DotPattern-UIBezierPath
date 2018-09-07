//
//  JSONData.swift
//  DotPattern-UIBezierPath
//
//  Created by 박길남 on 2018. 9. 7..
//  Copyright © 2018년 swieeft. All rights reserved.
//

import Foundation

struct JSONData:Decodable {
    var width:CGFloat?
    var height:CGFloat?
    var row:Int?
    var col:Int?
    var layers:[dotPatternLayer]?
    
    struct dotPatternLayer:Decodable {
        var path:[dotPatternPath]?
        
        struct dotPatternPath:Decodable {
            var type:String?
            var point:dotPatternPoint?
            var controlPoint1:dotPatternPoint?
            var controlPoint2:dotPatternPoint?
            var radius:CGFloat?
            var startAngle:CGFloat?
            var endAngle:CGFloat?
            var clockwise:Bool?
            
            struct dotPatternPoint:Decodable {
                var x:Int?
                var y:Int?
            }
        }
    }
}
