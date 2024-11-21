//
//  MainViewController.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import UIKit
import SnapKit


let fontDisplay: UIFont = .systemFont(ofSize: 60 , weight: .bold)
let fontButton: UIFont = .systemFont(ofSize: 30)
let colorButton: UIColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
let colorBg: UIColor = .black
let colorMain1: UIColor = .white


func makeButton(title: String) -> UIButton {
    let button = UIButton()
    
    button.backgroundColor = colorButton
    button.layer.cornerRadius = 40
    button.setTitleColor(colorMain1, for: .normal)
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = fontButton
    
    button.snp.makeConstraints {
        $0.height.equalTo(80)
        $0.width.equalTo(80)
        
    }
    
    return button
}


func makeHorizontalStackView(_ buttonTitles: [String]) -> UIStackView {
    let stackView = UIStackView()
    
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    stackView.backgroundColor = .red
    
    let buttons: [UIButton] = buttonTitles.map { makeButton(title: $0) }
    
    buttons.forEach { stackView.addArrangedSubview($0) }
    
    stackView.snp.makeConstraints {
        $0.height.equalTo(80)
    }
    
    return stackView
    
}

func makeDisplayLabel() -> UILabel {
    let label = UILabel()
    
    label.text = "12345"
    label.backgroundColor = .blue
    label.textColor = .white
    label.textAlignment = .right
    label.font = fontDisplay
    
    label.snp.makeConstraints {
        $0.height.equalTo(100)
    }
    
    return label
}


class MainViewController: UIViewController {

    let mainWrapper = UIView()
    let displayLabel = makeDisplayLabel()
    let buttonsStackView: UIStackView = makeHorizontalStackView()
    
    var calQueue: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    private func configureUI() {
        view.backgroundColor = .black
        
        mainWrapper.backgroundColor = .black
        mainWrapper.layer.borderWidth = 1
        
        mainWrapper.addSubview(displayLabel)
        mainWrapper.addSubview(buttonsStackView)
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
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(displayLabel.snp.bottom).offset(20)
            
        }
    }

}

#Preview {
    MainViewController()
}
