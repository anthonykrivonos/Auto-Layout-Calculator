//
//  CalculatorUtility.swift
//  Auto-Layout Calculator
//
//  Created by Anthony Krivonos on 1/9/18.
//  Copyright © 2018 Anthony Krivonos. All rights reserved.
//

import Foundation

//
//    Arithmetic functions
//

func add(augend:Double, addend:Double) -> Double {
      return augend + addend;
}

func subtract(minuend:Double, subtrahend:Double) -> Double {
      return minuend - subtrahend;
}

func multiply(multiplicand:Double, multiplier:Double) -> Double {
      return multiplicand * multiplier;
}

func divide(dividend:Double, divisor:Double) -> Double {
      return dividend / divisor;
}

func percentage(value:Double) -> Double {
      return value / 100;
}

func inverse(value:Double) -> Double {
      return value != 0.0 ? value * -1 : 0.0;
}


//
//    String display functions
//

func toRounded(value:Double, places:Int) -> String {
      if (floor(value) == value) {
            return String(Int(value));
      }
      let rounder:Double = pow(Double(10), Double(places));
      return String(round(rounder*value)/rounder);
}

func toScientific(value:Double) -> String {
      let formatter:NumberFormatter = NumberFormatter();
      formatter.numberStyle = .scientific;
      formatter.positiveFormat = "0.###E+0";
      formatter.exponentSymbol = "e";
      if let scientificFormatted = formatter.string(for: value) {
            return scientificFormatted;
      }
      return "OVERFLOW";
}

func roundToFit(value:Double, width:Int) -> String {
      var wholePlaces:Int = 0;
      var tempValue:Double = value;
      while (tempValue >= 1) {
            wholePlaces += 1;
            tempValue /= 10;
      }
      if (wholePlaces > width) {
            return toScientific(value: value);
      }
      return toRounded(value: value, places: width-wholePlaces);
}

//
//    Parse functions
//

func toString(value:Double) -> String {
      return String(value);
}
func toDouble(value:String) -> Double {
      return Double(value)!;
}
