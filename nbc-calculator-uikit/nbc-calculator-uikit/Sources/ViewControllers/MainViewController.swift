//
//  MainViewController.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import UIKit
import SnapKit
import OSLog


/// 메인 UI 컴포넌트 배치 및 기본 작동 기능 구현
class MainViewController: UIViewController {
    
    private let theme = ThemeManager.shared // 전역 데이터 관리를 위한 앱델리게이트 가져오기
    private var calculator: Calculator // 계산기 뷰모델 : 각종 로직 담당
    
    let mainWrapper = UIView()
    // 현재 계산 중인 수식 및 그 결과를 보여주는 레이어
    let displayLabel = UILabel.makeDisplayLabel("0")
    let displayScrollView = UIScrollView.makeHorizontalScrollView()
    
    // 현재 계산 중인 수식 및 그 결과를 보여주는 레이어
    let historyLabel = UILabel.makeHistoryLabel()
    let historyScrollView = UIScrollView.makeHorizontalScrollView()
    
    
    let buttonsStackView = UIStackView() // 각 계산기 버튼 row 스택뷰들을 모아서 담는 스택뷰
    
    // 각 행에 접근할 경우를 대비해 각각을 따로 변수로 만들어서 사용.
    let buttonsRowStackView1: UIStackView = UIStackView.makeHorizontalStackView([
        CalculatorButtonComponent(title: "7", type: .number),
        CalculatorButtonComponent(title: "8", type: .number),
        CalculatorButtonComponent(title: "9", type: .number),
        CalculatorButtonComponent(title: "+", type: .add),
    ])
    let buttonsRowStackView2: UIStackView = UIStackView.makeHorizontalStackView([
        CalculatorButtonComponent(title: "4", type: .number),
        CalculatorButtonComponent(title: "5", type: .number),
        CalculatorButtonComponent(title: "6", type: .number),
        CalculatorButtonComponent(title: "-", type: .subtract),
    ])
    let buttonsRowStackView3: UIStackView = UIStackView.makeHorizontalStackView([
        CalculatorButtonComponent(title: "1", type: .number),
        CalculatorButtonComponent(title: "2", type: .number),
        CalculatorButtonComponent(title: "3", type: .number),
        CalculatorButtonComponent(title: "x", type: .multiply),
    ])
    let buttonsRowStackView4: UIStackView = UIStackView.makeHorizontalStackView([
        CalculatorButtonComponent(title: "AC", type: .clear),
        CalculatorButtonComponent(title: "0", type: .number),
        CalculatorButtonComponent(title: "=", type: .calculate),
        CalculatorButtonComponent(title: "÷", type: .divide),
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
        
        // 각 UI의 레이어 구조는 아래와 같다.
        // buttonsRowStackView -> buttonsStackView -> mainWrapper -> view
        // displayLabel -> displayScrollView -> mainWrapper
        // historyLabel -> historyScrollView -> mainWrapper
        
        displayScrollView.addSubview(displayLabel)
        mainWrapper.addSubview(displayScrollView)
        
        historyScrollView.addSubview(historyLabel)
        mainWrapper.addSubview(historyScrollView)
        
        mainWrapper.addSubview(buttonsStackView)
        view.addSubview(mainWrapper)
        
        
        
        mainWrapper.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        historyLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.greaterThanOrEqualToSuperview()
        }
        
        historyScrollView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        
        displayLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.greaterThanOrEqualToSuperview()
        }
        
        displayScrollView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(140)
            $0.height.equalTo(100)
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(0)
            $0.trailing.equalToSuperview().inset(0)
            $0.top.equalTo(displayScrollView.snp.bottom).offset(60)
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
    
    
    /// 스크롤뷰에서 하위 레이블 컨텐츠의 길이가 추가될 때마다 offset을 가장 trail쪽으로 옮기는 기능
    /// - Parameter scrollView: 작동시키고자 하는 horizontal 스크롤뷰
    private func scrollToRight(_ scrollView: UIScrollView) {
        // 내부의 컨텐츠 사이즈가 스크롤 뷰의 사이즈보다 작으면 이동없도록 처리.
        //
        let offsetX = scrollView.contentSize.width - scrollView.bounds.width
        guard offsetX > 0 else {
            return
        }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
    
    /// 각 버튼 객체의 버튼 타입에 따라 서로 다른 기능을 수행하는 메소드.
    /// 각 버튼에 addTarget 으로 연결
    /// - Parameter sender: 버튼 하나하나가 객체이며, 해당 객체의 버튼타입(enum)에 따라 기능을 수행하기 위해 객체를 파라미터로 삽입
    @objc private func buttonTapped(_ sender: CalculatorButtonComponent) {
        switch sender.calButtonType {
        case .number, .add, .subtract, .multiply, .divide:
            // 새로운 입력을 시작할 경우 히스토리 라벨 비우기
            if historyLabel.text != "" {
                historyLabel.text = ""
            }
            
            calculator.addToDisplay(sender.title, sender.calButtonType)
        case .clear:
            calculator.clear()
        case .calculate:
            calculator.calculateAll()
            historyLabel.text = calculator.history.last?.calculation
            DispatchQueue.main.async {
                self.scrollToRight(self.historyScrollView)
            }
        }
        
        // 렌더링 파트. 버튼 클릭 후 변경되는 값 또는 수식을 label을 통해 화면에 그려준다.
        var tempDisplay: String = ""
        calculator.currentDisplay.forEach { tempDisplay += " \($0.0)"}
        displayLabel.text = tempDisplay
        
        // 스크롤뷰 이동의 경우 동기화하지 않으면 원하는 거리만큼 이동하지 않으므로 아래와 같이 코드 작성.
        DispatchQueue.main.async {
            self.scrollToRight(self.displayScrollView)
        }
    }

}


#Preview {
    MainViewController()
}
