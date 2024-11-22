//
//  AbstractOperation.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import Foundation


/// 연산 메소드들을 위한 프로토콜
protocol AbstractOperation {
    func operationNumber(_ num1: Int, _ num2: Int) -> Int
}



