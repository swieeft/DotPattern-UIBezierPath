//
//  FishViewController.swift
//  DotPattern-UIBezierPath-Test
//
//  Created by 박길남 on 2018. 9. 3..
//  Copyright © 2018년 swieeft. All rights reserved.
//

import UIKit
import DotPattern_UIBezierPath

class FishViewController: UIViewController {

    @IBOutlet weak var dotView: UIView!
    
    @IBOutlet weak var viewDotButton: UIButton!
    
    var dotPattern:DotPattern!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dotPattern = DotPattern(view: self.dotView, row: 50, col: 50)
    }

    @IBAction func viewDotAction(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            if title == "View Dot" {
                self.dotPattern.viewDot()
                sender.setTitle("Hide Dot", for: .normal)
            } else {
                self.dotPattern.hiddenDot()
                sender.setTitle("View Dot", for: .normal)
            }
        }
    }
    
    @IBAction func showFishAction(_ sender: Any) {
        drawingBody()
        drawingEye()
        drawingFin()
        drawingBubble()
    }
    
    func drawingBody() {
        let path = UIBezierPath()
        
        path.m(to: getPoint(21, 5))
            .quadCurve(to: getPoint(20, 10), controlPoint: getPoint(20, 7))
            .quadCurve(to: getPoint(15, 14), controlPoint: getPoint(17, 11))
            .curve(to: getPoint(24, 41), controlPoint1: getPoint(13, 19), controlPoint2: getPoint(13, 38))
            .quadCurve(to: getPoint(17, 49), controlPoint: getPoint(19, 44))
            .quadCurve(to: getPoint(26, 47), controlPoint: getPoint(25, 49))
            .quadCurve(to: getPoint(34, 49), controlPoint: getPoint(30, 49))
            .quadCurve(to: getPoint(34, 49), controlPoint: getPoint(30, 49))
            .quadCurve(to: getPoint(29, 41), controlPoint: getPoint(33, 46))
            .quadCurve(to: getPoint(25, 5), controlPoint: getPoint(40, 20))
            .quadCurve(to: getPoint(24, 11), controlPoint: getPoint(25, 9))
            .line(to: getPoint(23, 6))
            .quadCurve(to: getPoint(21, 5), controlPoint: getPoint(22, 5))
            .m(to: getPoint(18, 18))
            .arc(center: getPoint(18, 16), radius: self.dotPattern.colSize * 2, start: 0, end: 2 * .pi, clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeEnd = 0
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 1.5
        layer.fillColor = UIColor.clear.cgColor
        
        let animation = setAnimation()
        layer.add(animation, forKey: "ani")
        
        self.dotView.layer.addSublayer(layer)
    }
    
    func drawingEye() {
        let path = UIBezierPath()
        
        path.m(to: getPoint(18, 18))
            .arc(center: getPoint(18, 16), radius: self.dotPattern.colSize * 2, start: 0, end: 2 * .pi, clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeEnd = 0
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 1.5
        layer.fillColor = UIColor.clear.cgColor
        
        let animation = setAnimation()
        layer.add(animation, forKey: "ani")
        
        self.dotView.layer.addSublayer(layer)
        
        let path2 = UIBezierPath()
        
        path2.m(to: getPoint(18, 16))
            .arc(center: getPoint(18, 15), radius: self.dotPattern.colSize, start: 0, end: 2 * .pi, clockwise: true)
        
        let layer2 = CAShapeLayer()
        layer2.path = path2.cgPath
        layer2.strokeEnd = 0
        layer2.strokeColor = UIColor.black.cgColor
        layer2.lineWidth = 1.5
        layer2.fillColor = UIColor.black.cgColor
        
        self.dotView.layer.addSublayer(layer2)
    }
    
    func drawingFin() {
        let path = UIBezierPath()
        
        path.m(to: getPoint(15, 14))
            .quadCurve(to: getPoint(7, 27), controlPoint: getPoint(9, 15))
            .quadCurve(to: getPoint(11, 25), controlPoint: getPoint(10, 23))
            .quadCurve(to: getPoint(9, 30), controlPoint: getPoint(9, 28))
            .quadCurve(to: getPoint(19, 38), controlPoint: getPoint(13, 30))
            .m(to: getPoint(33, 19))
            .quadCurve(to: getPoint(39, 30), controlPoint: getPoint(39, 24))
            .line(to: getPoint(33, 30))
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeEnd = 0
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 1.5
        layer.fillColor = UIColor.clear.cgColor
        
        let animation = setAnimation()
        layer.add(animation, forKey: "ani")
        
        self.dotView.layer.addSublayer(layer)
    }
    
    func drawingBubble() {
        let path = UIBezierPath()
        
        path.m(to: getPoint(18, 8))
            .arc(center: getPoint(18, 6), radius: self.dotPattern.colSize * 2, start: 0, end: 2 * .pi, clockwise: true)
            .m(to: getPoint(14, 9))
            .arc(center: getPoint(14, 8), radius: self.dotPattern.colSize, start: 0, end: 2 * .pi, clockwise: true)
            .m(to: CGPoint(x: getPoint(10, 8).x - (self.dotPattern.colSize / 2), y: getPoint(10, 8).y) )
            .arc(center: getPoint(10, 6), radius: self.dotPattern.colSize * 1.5, start: 0, end: 2 * .pi, clockwise: true)
            .m(to: getPoint(7, 11))
            .arc(center: getPoint(7, 10), radius: self.dotPattern.colSize, start: 0, end: 2 * .pi, clockwise: true)
            .m(to: getPoint(4, 10))
            .arc(center: getPoint(4, 9), radius: self.dotPattern.colSize, start: 0, end: 2 * .pi, clockwise: true)
            .m(to: getPoint(2, 13))
            .arc(center: getPoint(2, 12), radius: self.dotPattern.colSize, start: 0, end: 2 * .pi, clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeEnd = 0
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 1.5
        layer.fillColor = UIColor.cyan.cgColor
        
        let animation = setAnimation()
        layer.add(animation, forKey: "ani")
        
        self.dotView.layer.addSublayer(layer)
    }
    
    func setAnimation() -> CABasicAnimation {
        let duration: TimeInterval = 3
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
//        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        
        return animation
        
//        let animation2 = CABasicAnimation(keyPath: "fillColor")
//        animation2.fromValue = UIColor.clear.cgColor
//        animation2.toValue = UIColor.red.cgColor
//        animation2.duration = duration
//        animation2.fillMode = kCAFillModeForwards
//        animation2.repeatCount = .infinity
//        animation2.isRemovedOnCompletion = false
//
//        let group = CAAnimationGroup()
//        group.animations = [animation, animation2]
//        group.duration = duration
//        group.fillMode = kCAFillModeForwards
//        group.repeatCount = .infinity
//        group.isRemovedOnCompletion = false
        
//        return group
    }
    
    func getPoint(_ row: Int, _ col: Int) -> CGPoint {
        return self.dotPattern.get(row, col)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
