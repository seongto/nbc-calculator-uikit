//
//  Task.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/22/24.
//

import Foundation

/// 수행이 완료된 경우의 수식과 결과값을 기록
/// 수행이 실패한 경우 중 사용자에게 알릴 정보가 있을 경우, 그 메시지를 저장하여 활용
struct Task {
    var calculation: String = ""
    var result: String = ""
    
    init(_ calculation: String, _ result: String) {
        self.calculation = calculation
        self.result = result
    }
}
