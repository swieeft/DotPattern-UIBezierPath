//
//  HeartViewController.swift
//  DotPattern-UIBezierPath-Test
//
//  Created by 박길남 on 2018. 8. 31..
//  Copyright © 2018년 swieeft. All rights reserved.
//

import UIKit
import DotPattern_UIBezierPath

class HeartViewController: UIViewController {

    @IBOutlet weak var dotView: UIView!
    
    @IBOutlet weak var viewDotButton: UIButton!

    var dotPattern:DotPattern!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dotPattern = DotPattern(view: self.dotView, row: 20, col: 11)
    }
    
    @IBAction func ViewDotAction(_ sender: UIButton) {
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
    
    @IBAction func ShowHeartAction(_ sender: Any) {
        let path = UIBezierPath()
        
        path.m(to: getPoint(10, 6))
            .curve(to: getPoint(10, 3), controlPoint1: getPoint(8, 5), controlPoint2: getPoint(8, 3))
            .curve(to: getPoint(14, 6), controlPoint1: getPoint(11, 3), controlPoint2: getPoint(13, 5))
            .curve(to: getPoint(10, 9), controlPoint1: getPoint(13, 7), controlPoint2: getPoint(11, 9))
            .curve(to: getPoint(10, 6), controlPoint1: getPoint(8, 9), controlPoint2: getPoint(8, 7))
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeEnd = 0
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 3
        layer.fillColor = UIColor.clear.cgColor
        
        let animation = setAnimation()
        layer.add(animation, forKey: "ani")
        
        self.dotView.layer.addSublayer(layer)
    }
    
    func setAnimation() -> CAAnimationGroup {
        let duration: TimeInterval = 5
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        
        let animation2 = CABasicAnimation(keyPath: "fillColor")
        animation2.fromValue = UIColor.clear.cgColor
        animation2.toValue = UIColor.red.cgColor
        animation2.duration = duration
        animation2.fillMode = kCAFillModeForwards
        animation2.repeatCount = .infinity
        animation2.isRemovedOnCompletion = false
        
        let group = CAAnimationGroup()
        group.animations = [animation, animation2]
        group.duration = duration
        group.fillMode = kCAFillModeForwards
        group.repeatCount = .infinity
        group.isRemovedOnCompletion = false
        
        return group
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
