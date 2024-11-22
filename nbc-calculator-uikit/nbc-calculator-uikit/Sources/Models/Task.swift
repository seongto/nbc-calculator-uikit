//
//  Task.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/22/24.
//

import Foundation

struct Task {
    var calculation: String = ""
    var result: String = ""
    
    init(_ calculation: String, _ result: String) {
        self.calculation = calculation
        self.result = result
    }
}
