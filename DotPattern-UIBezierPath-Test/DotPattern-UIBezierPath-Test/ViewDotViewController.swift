//
//  ViewDotViewController.swift
//  DotPattern-UIBezierPath-Test
//
//  Created by 박길남 on 2018. 8. 31..
//  Copyright © 2018년 swieeft. All rights reserved.
//

import UIKit
import DotPattern_UIBezierPath

class ViewDotViewController: UIViewController {

    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var rowTextField: UITextField!
    @IBOutlet weak var colTextField: UITextField!
    
    var dotPattern:DotPattern!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dotPattern = DotPattern(view: self.dotView, row: 40, col: 20)
    }

    @IBAction func viewAllDotAction(_ sender: Any) {
        self.dotPattern.viewDot()
    }
    
    @IBAction func viewRangeDotAction(_ sender: Any) {
        var row = 0
        if let rowText = self.rowTextField.text, let convertRow = Int(rowText) {
            row = convertRow
        }
        
        var col = 0
        if let colText = self.colTextField.text, let convertCol = Int(colText) {
            col = convertCol
        }
        
        if row == 0 || col == 0 {
            return
        }
        
        self.dotPattern.viewDot(rowRange: 1...row, colRange: 1...col)
    }
    
    @IBAction func HideDotAction(_ sender: Any) {
        self.dotPattern.hiddenDot()
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
