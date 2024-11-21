//
//  CalButton.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import Foundation


enum CalButtonTypes {
    case add
    case subtract
    case multiply
    case divide
    case clear
    case number
    case equal
}


struct CalButton {
    var title: String
    var type: CalButtonTypes
    var action: (() -> Void)?
    
    init(title: String, type: CalButtonTypes) {
        self.title = title
        self.type = type
    }
}

