//
//  ViewController.swift
//  Auto-Layout Calculator
//
//  Created by Anthony Krivonos on 1/9/18.
//  Copyright © 2018 Anthony Krivonos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

      // Calculator display
      @IBOutlet weak var valueLabel: UILabel!
      
      // . Button
      @IBOutlet weak var dotButton: UIButton!
      
      var isEntering:Bool = false;
      var currentValue:String = "";
      var previousValue:String = "";
      
      var operation:() -> Void = {
            () -> Void in
            return;
      };
      
      override func viewDidLoad() {
            super.viewDidLoad()
            clear();
            display();
      }

      override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
      }
      
      func display() -> Void {
            valueLabel.text = roundToFit(value: toDouble(value: currentValue), width: 9);
      }
      
      func clear() -> Void {
            isEntering = false;
            currentValue = "0";
            previousValue = "0";
            toggleDot(enabled: true);
      }
      
      func toDoOperate(op:Any) -> Void {
            previousValue = currentValue;
            isEntering = false;
            operation = op as! () -> Void;
      }
      
      func toggleDot(enabled:Bool) -> Void {
            dotButton.isEnabled = enabled;
      }
      
      //
      //    Button press events
      //

      // Called if user presses a number or a .
      @IBAction func valueButtonPressed(_ sender: UIButton) {
            let buttonValue:String = sender.currentTitle!
            // If user is typing
            if (isEntering) {
                  // If the user types a ., disable that button
                  if (buttonValue == ".") {
                        toggleDot(enabled: false);
                  }
            } else {
                  // If the user does not type in a ., remove the 0
                  isEntering = true;
                  if (buttonValue != ".") {
                        currentValue = "";
                  } else {
                        currentValue = "0";
                  }
            }
            currentValue += buttonValue;
            display();
      }
      
      
      @IBAction func operationButtonPressed(_ sender: UIButton) {
            let op:String = sender.currentTitle!
            switch (op) {
                  case "AC":
                        clear();
                        break;
                  case "+/-":
                        currentValue = toString(value: inverse(value: toDouble(value: currentValue)));
                        break;
                  case "%":
                        currentValue = toString(value: percentage(value: toDouble(value: currentValue)));
                        break;
                  case "÷":
                        toDoOperate(op: {
                              () -> Void in
                              self.currentValue = toString(value: divide(dividend: toDouble(value: self.previousValue), divisor: toDouble(value: self.currentValue)));
                        });
                        break;
                  case "x":
                        toDoOperate(op: {
                              () -> Void in
                              self.currentValue = toString(value: multiply(multiplicand: toDouble(value: self.previousValue), multiplier: toDouble(value: self.currentValue)));
                        });
                        break;
                  case "-":
                        toDoOperate(op: {
                              () -> Void in
                              self.currentValue = toString(value: subtract(minuend: toDouble(value: self.previousValue), subtrahend: toDouble(value: self.currentValue)));
                        });
                        break;
                  case "+":
                        toDoOperate(op: {
                              () -> Void in
                              self.currentValue = toString(value: add(augend: toDouble(value: self.previousValue), addend: toDouble(value: self.currentValue)));
                        });
                        break;
                  case "=":
                        operation();
                        break;
                  default:
                        break;
            }
            display();
      }
      
}

