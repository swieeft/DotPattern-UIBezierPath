//
//  HelloDotViewController.swift
//  DotPattern-UIBezierPath-Test
//
//  Created by 박길남 on 2018. 9. 11..
//  Copyright © 2018년 swieeft. All rights reserved.
//

import UIKit
import DotPattern_UIBezierPath

class HelloDotViewController: UIViewController {

    @IBOutlet weak var dotView: UIView!
    
    @IBOutlet weak var viewDotButton: UIButton!
    
    var dotPattern:DotPattern!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dotPattern = DotPattern(view: self.dotView)
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
    
    @IBAction func showHelloDotAction(_ sender: Any) {
        self.dotPattern.createPath(url: "https://raw.githubusercontent.com/swieeft/DotPattern-UIBezierPath/master/md-Resource/hellodot.json") { (paths, success) in
            for path in paths {
                if path.isEmpty == false {
                    let shapeLayer = CAShapeLayer()
                    shapeLayer.path = path.cgPath
                    shapeLayer.strokeEnd = 0
                    shapeLayer.strokeColor = UIColor.black.cgColor
                    shapeLayer.lineWidth = 3
                    shapeLayer.fillColor = UIColor.clear.cgColor
                    
                    let duration: TimeInterval = 5
                    
                    let animation = CABasicAnimation(keyPath: "strokeEnd")
                    animation.toValue = 1
                    animation.duration = duration
                    animation.fillMode = kCAFillModeForwards
                    animation.isRemovedOnCompletion = false
                    
                    shapeLayer.add(animation, forKey: "ani")
                    
                    self.view.layer.addSublayer(shapeLayer)
                }
            }
        }
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
