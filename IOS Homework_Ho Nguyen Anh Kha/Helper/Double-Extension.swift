//
//  Double-Extension.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 9/5/24.
//

import Foundation

extension Double {
    
    /// Number formatter that adds separators for thousands (eg. 1,234.01).
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal // this style adds thousand separators.
        return numberFormatter
    }()

    /// Returns this number as a string with separators for thousands.
    var formattedString: String {
        return Double.numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    /// Formats this Double with thousand separators, and the given number of decimals.
    ///
    /// - Parameter decimals: Maximum number of decimals.
    /// - Returns: User friendly string.
    func formattedString(decimals: UInt) -> String {
        let formatter = Double.numberFormatter
        formatter.maximumFractionDigits = Int(decimals)
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
}
