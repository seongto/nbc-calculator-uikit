//
//  MainViewController.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import UIKit
import SnapKit
import OSLog


func makeHorizontalStackView(_ buttons: [CalculatorButtonComponent]) -> UIStackView {
    let stackView = UIStackView()
    let theme = ThemeManager.shared
    
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    stackView.backgroundColor = theme.colors.black
        
    buttons.forEach { stackView.addArrangedSubview($0) }
    
    stackView.snp.makeConstraints {
        $0.height.equalTo(80)
    }
    
    return stackView
    
}


func makeDisplayLabel(_ text: String) -> UILabel {
    let label = UILabel()
    let theme = ThemeManager.shared
    
    label.text = text
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
    
    private let theme = ThemeManager.shared // 전역 데이터 관리를 위한 앱델리게이트 가져오기
    private var calculator: Calculator // 계산기 뷰모델 : 각종 로직 담당
    
    let mainWrapper = UIView()
    let displayLabel = makeDisplayLabel("0")
    let buttonsStackView = UIStackView() // 각 계산기 버튼 row 스택뷰들을 모아서 담는 스택뷰
    
    let buttonsRowStackView1: UIStackView = makeHorizontalStackView([
        CalculatorButtonComponent(title: "7", type: .number),
        CalculatorButtonComponent(title: "8", type: .number),
        CalculatorButtonComponent(title: "9", type: .number),
        CalculatorButtonComponent(title: "+", type: .mathSymbol),
    ])
    let buttonsRowStackView2: UIStackView = makeHorizontalStackView([
        CalculatorButtonComponent(title: "4", type: .number),
        CalculatorButtonComponent(title: "5", type: .number),
        CalculatorButtonComponent(title: "6", type: .number),
        CalculatorButtonComponent(title: "-", type: .mathSymbol),
    ])
    let buttonsRowStackView3: UIStackView = makeHorizontalStackView([
        CalculatorButtonComponent(title: "1", type: .number),
        CalculatorButtonComponent(title: "2", type: .number),
        CalculatorButtonComponent(title: "3", type: .number),
        CalculatorButtonComponent(title: "*", type: .mathSymbol),
    ])
    let buttonsRowStackView4: UIStackView = makeHorizontalStackView([
        CalculatorButtonComponent(title: "AC", type: .clear),
        CalculatorButtonComponent(title: "0", type: .number),
        CalculatorButtonComponent(title: "=", type: .calculate),
        CalculatorButtonComponent(title: "/", type: .mathSymbol),
    ])
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init() {
        self.calculator = Calculator()
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
        addActionToButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    /// 생성된 버튼 들에 액션을 추가하기
    /// 처음엔 버튼 객체 내에 메소드로 액션을 추가하였었으나, 객체 내의 메소드와 현재 뷰의 calculator 데이터를 연동시키는 방법을 찾지 못해 액션을 아래와 같이 따로 추가.
    private func addActionToButtons() {
        let buttons: [CalculatorButtonComponent] = [
            buttonsRowStackView1,
            buttonsRowStackView2,
            buttonsRowStackView3,
            buttonsRowStackView4
        ].flatMap { ($0.arrangedSubviews as! [CalculatorButtonComponent]) }
        
        buttons.forEach { button in
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    
    /// 각 버튼 객체의 버튼 타입에 따라 서로 다른 기능을 수행하는 메소드.
    /// 각 버튼에 addTarget 으로 연결
    /// - Parameter sender: 버튼 하나하나가 객체이며, 해당 객체의 버튼타입(enum)에 따라 기능을 수행하기 위해 객체를 파라미터로 삽입
    @objc private func buttonTapped(_ sender: CalculatorButtonComponent) {
        switch sender.calButtonType {
        case .number, .mathSymbol:
            calculator.addToDisplay(sender.title, sender.calButtonType)
        case .clear:
            calculator.clear()
        case .calculate:
            return
        }
        
        // Update display
        var tempDisplay: String = ""
        calculator.currentDisplay.forEach { tempDisplay += $0.0}
        displayLabel.text = tempDisplay
    }

}

#Preview {
    MainViewController()
}
