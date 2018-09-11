//
//  JSONData.swift
//  DotPattern-UIBezierPath
//
//  Created by 박길남 on 2018. 9. 7..
//  Copyright © 2018년 swieeft. All rights reserved.
//

import Foundation

public struct JSONData:Decodable {
    var width:CGFloat?  // view의 넓이 값
    var height:CGFloat? // view의 높이 값
    var row:Int?        // view의 행 개수
    var col:Int?        // view의 열 개수
    var layers:[Layer]? // view에 추가 될 layer 정보
    
    public struct Layer:Decodable {
        var datas:[Data]?   // layer의 path data array
        
        // path data
        public struct Data:Decodable {
            var type:String?        // path의 종류 (line, curve, arc 등)
            var startPoint:Point?   // path의 시작 점
            var endPoint:Point?     // path의 종료 점
            var curve:Curve?        // curve 타입일 때의 curve 정보
            var arc:Arc?            // arc 타입일 때의 arc 정보
            
            // path의 각 점에 대한 정보
            public struct Point:Decodable {
                var x:Int?
                var y:Int?
            }
            
            // curve 정보
            public struct Curve:Decodable {
                var controlPoint1:Point?
                var controlPoint2:Point?
            }
            
            // arc 정보
            public struct Arc:Decodable {
                var radius:CGFloat?     // 원의 반지름
                var startAngle:CGFloat? // 원의 시작 각도
                var endAngle:CGFloat?   // 원의 종료 각도
                var clockwise:Bool?     // 원이 그려지는 방향 (true:시게, false:반시계)
            }
        }
    }
}
