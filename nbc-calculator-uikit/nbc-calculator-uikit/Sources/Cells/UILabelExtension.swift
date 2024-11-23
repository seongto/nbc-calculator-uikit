//
//  UILabelExtension.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/23/24.
//

import UIKit

extension UILabel {
    /// 현재 입력한 수식 및 결과값을 보여주는 레이블
    static func makeDisplayLabel(_ text: String) -> UILabel {
        let label = UILabel()
        let theme = ThemeManager.shared
        
        label.text = text
        label.backgroundColor = theme.colors.black
        label.textColor = theme.colors.white
        label.textAlignment = .right
        label.font = theme.fonts.h1
        label.adjustsFontSizeToFitWidth = true // 원하는 대로 작동하지 않는 코드...
        label.minimumScaleFactor = 0.5
        
        label.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        return label
    }
    
    /// 이전 계산된 수식과 에러 메시지 등을 보여주는 레이블
    static func makeHistoryLabel() -> UILabel {
        let label = UILabel()
        let theme = ThemeManager.shared
        
        label.text = ""
        label.backgroundColor = theme.colors.black
        label.textColor = theme.colors.grey2
        label.textAlignment = .right
        label.font = theme.fonts.h4
        
        label.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        return label
    }
    
}
