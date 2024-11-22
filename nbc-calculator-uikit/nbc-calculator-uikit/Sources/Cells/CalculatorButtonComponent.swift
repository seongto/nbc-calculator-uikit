//
//  CalculatorButtonComponent.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import SnapKit
import UIKit

/// 버튼은 클래스로 만들어서 재사용하는 것을 시도
class CalculatorButtonComponent: UIButton {
    var calButtonType: CalButtonTypes = .number
    var title: String = ""
    private let buttonSize: CGFloat = 80
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init( title: String, type: CalButtonTypes ) {
        super.init(frame: .zero)
        self.calButtonType = type
        self.title = title
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = calButtonType == .number ? ThemeManager.shared.colors.calButton : ThemeManager.shared.colors.orange
        setTitle(title, for: .normal)
        titleLabel?.font = ThemeManager.shared.fonts.h3
        setTitleColor(ThemeManager.shared.colors.white, for: .normal) // 타이틀 컬러 설정
        layer.cornerRadius = buttonSize / 2 // 테두리 곡률 설정
                
        snp.makeConstraints {
            $0.height.equalTo(buttonSize)
            $0.width.equalTo(buttonSize)
        }
    }

}
