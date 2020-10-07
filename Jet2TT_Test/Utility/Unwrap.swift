//
 //  Unwrap.swift
 //  Jet2TT_Test
 //
 //  Created by Ankit on 06/10/2020.
 //  Copyright © 2020 Ankit. All rights reserved.
 //
import UIKit
import Foundation

//MARK:- PROTOCOL
protocol OptionalType { init() }

//MARK:- EXTENSIONS
extension Dictionary:OptionalType {}
extension UIImage:OptionalType {}
extension IndexPath:OptionalType {}
extension UIFont:OptionalType {}
extension UIView:OptionalType {}
extension Data:OptionalType {}
extension UIViewController:OptionalType {}

extension String:OptionalType {}

extension Bool:OptionalType {}

extension Int:OptionalType {}
extension Int64:OptionalType { }

extension Float:OptionalType {}

extension Double:OptionalType {}

extension CGFloat:OptionalType {}
extension CGRect:OptionalType {}

prefix operator /

//unwrapping values
prefix func /<T:OptionalType>(value:T?) -> T {
    guard let validValue = value else { return T() }
    return validValue
}

extension NSObject {
    var appDelegate:AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}



