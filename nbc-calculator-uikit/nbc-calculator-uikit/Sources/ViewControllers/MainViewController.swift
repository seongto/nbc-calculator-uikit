//
//  MainViewController.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import UIKit
import SnapKit



func makeHorizontalStackView(_ buttonInfos: [CalButton]) -> UIStackView {
    let stackView = UIStackView()
    let theme = ThemeManager.shared
    
    
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    stackView.backgroundColor = theme.colors.black
    
    let buttons: [UIButton] = buttonInfos.map { CalculatorButtonComponent(buttonInfo: $0) }
    
    buttons.forEach { stackView.addArrangedSubview($0) }
    
    stackView.snp.makeConstraints {
        $0.height.equalTo(80)
    }
    
    return stackView
    
}

func makeDisplayLabel() -> UILabel {
    let label = UILabel()
    let theme = ThemeManager.shared
    
    label.text = "12345"
    label.backgroundColor = theme.colors.black
    label.textColor = theme.colors.white
    label.textAlignment = .right
    label.font = theme.fonts.h1
    
    label.snp.makeConstraints {
        $0.height.equalTo(100)
    }
    
    return label
}


class MainViewController: UIViewController {

    let mainWrapper = UIView()
    let displayLabel = makeDisplayLabel()
    let buttonsStackView = UIStackView()
    let buttonsRowStackView1: UIStackView = makeHorizontalStackView([
        CalButton(title: "7", type: .number),
        CalButton(title: "8", type: .number),
        CalButton(title: "9", type: .number),
        CalButton(title: "+", type: .add),
    ])
    let buttonsRowStackView2: UIStackView = makeHorizontalStackView([
        CalButton(title: "4", type: .number),
        CalButton(title: "5", type: .number),
        CalButton(title: "6", type: .number),
        CalButton(title: "-", type: .subtract),
    ])
    let buttonsRowStackView3: UIStackView = makeHorizontalStackView([
        CalButton(title: "1", type: .number),
        CalButton(title: "2", type: .number),
        CalButton(title: "3", type: .number),
        CalButton(title: "*", type: .multiply),
    ])
    let buttonsRowStackView4: UIStackView = makeHorizontalStackView([
        CalButton(title: "AC", type: .clear),
        CalButton(title: "0", type: .number),
        CalButton(title: "=", type: .equal),
        CalButton(title: "/", type: .divide),
    ])
    
    // 전역 데이터 관리를 위한 앱델리게이트 가져오기
    private let theme = ThemeManager.shared
    
    let calculator: Calculator = Calculator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    private func configureUI() {
        view.backgroundColor = theme.colors.black
        
        mainWrapper.backgroundColor = theme.colors.black
        
        buttonsStackView.addArrangedSubview(buttonsRowStackView1)
        buttonsStackView.addArrangedSubview(buttonsRowStackView2)
        buttonsStackView.addArrangedSubview(buttonsRowStackView3)
        buttonsStackView.addArrangedSubview(buttonsRowStackView4)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.backgroundColor = theme.colors.black
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .fillEqually
        
        
        mainWrapper.addSubview(buttonsStackView)
        mainWrapper.addSubview(displayLabel)
        view.addSubview(mainWrapper)
        
        mainWrapper.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        displayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(140)
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(0)
            $0.trailing.equalToSuperview().inset(0)
            $0.top.equalTo(displayLabel.snp.bottom).offset(60)
        }
        
    }

}

#Preview {
    MainViewController()
}
