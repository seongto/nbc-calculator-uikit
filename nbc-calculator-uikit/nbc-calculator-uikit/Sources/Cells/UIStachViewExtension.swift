//
//  UIStachViewExtension.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/23/24.
//

import UIKit

extension UIStackView {
    /// 버튼의 한 행을 스택뷰로 만들기
    static func makeHorizontalStackView(_ buttons: [CalculatorButtonComponent]) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = ThemeManager.shared.colors.black
        
        buttons.forEach { stackView.addArrangedSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        return stackView
        
    }
    
}
