//
//  CalculatorButtonComponent.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import SnapKit
import UIKit


class CalculatorButtonComponent: UIButton {
    private var customAction : (() -> Void)?
    private var calButtonType: CalButtonTypes? = nil
    
    private let theme = ThemeManager.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init( buttonInfo: CalButton ) {
        super.init(frame: .zero)
        
        self.customAction = buttonInfo.action
        self.calButtonType = buttonInfo.type
        
        setTitle(buttonInfo.title, for: .normal)
        titleLabel?.font = theme.fonts.h3
        backgroundColor = theme.colors.calButton
        setTitleColor(theme.colors.white, for: .normal) // 타이틀 컬러 설정
        layer.cornerRadius = 40 // 테두리 곡률 설정
        
        if calButtonType == .number {
            backgroundColor = theme.colors.calButton
        } else {
            backgroundColor = theme.colors.orange
        }
        
        snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonTapped() {
        if customAction != nil {
            
        }
    }
    
}
