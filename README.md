# iOS_week2_calculator_UIKit

![계산기 만들기](https://help.apple.com/assets/65D6896CA6CCCD9ECD051E60/65D6896D44E24248E80D32D1/ko_KR/5250122ee560cee90b3d7cfa2d91695e.png)


## Project Information
  - 프로젝트명 : 나의 스위프트 계산기 UIKit 버전
  - 프로젝트 소개 : 
    - 스위프트의 기초문법과 UIKit을 활용하여 터치로 동작하는 계산기 앱을 만들어 보자.
    - 이전에 플레이그라운드에서 만들었던 계산기앱에 UI를 입히기. 모델과 프로토콜 등을 활용하여 이전보다 로직 코드를 개선해보자.
<br><br><br>

## 프로젝트 수행 과제
### 1. 수행 목표 
  - UI를 입혀서 제대로 동작하는 계산기 "앱" 만들기.
    - `UILabel` 로 숫자를 표시.
    - `UIButton` 으로 숫자와 연산 버튼 구성.
    - `UIStackView` 로 버튼들을 규칙성있게 배치.
    - `AutoLayout` 을 활용해서 레이아웃을 설정.
    - `backgroundColor` , `layer.cornerRadius` 등 다양한 속성 활용.
    - `UIButton` 의 `addTarget` 혹은 `IBAction` 으로 버튼을 클릭했을 때 이벤트를 설정합니다.
    - 코드베이스 UI를 이용하여 코드로만 만들어보기

<br><br>

### 2. 필수 구현 기능
  - LV 1
    + [ ] UILabel 을 사용해서 수식을 표시할 수 있는 라벨을 띄우기. 
    + [ ] AutoLayout을 활용하여 라벨 위치를 고정하기
  - LV 2
    + [ ] UIStackView 을 사용해서 4개의 버튼을 모아 가로 스택뷰 생성.
    + [ ] UIButton 속성 변경하기
    + [ ] horizontalStackView 속성 변경하기
    + [ ] horizontalStackView AutoLayout 속성 변경하기
  - LV 3
    - [ ] UIStackView 을 사용해서 세로 스택 뷰 생성
    - [ ] verticalStackView 속성 변경하기
    - [ ] horizontal StackView AutoLayout 속성 변경하기
  - LV 4
    - [ ] 연산 버튼 (+, -, *, /, AC, =) 들은 색상을 orange 로 설정.
  - LV 5
    - [ ] 모든 버튼들을 원형으로 만들기
<br><br>

![hard mode](https://staticdelivery.nexusmods.com/mods/5113/images/headers/229_1676449560.jpg)

### 3. 도전(이라고 쓰고 필수라고 읽는다) 구현 기능
  - LV 6
    + [ ] 이제 기본 텍스트는 “12345” 가 아닌 “0” 이 되도록 변경
    + [ ] 버튼 눌렀을 때 라벨에 텍스트 추가하는 기능 구현하기
    + [ ] 각 숫자의 가장 앞자리에 0이 나오지 않게 만들기
  - LV 7
    + [ ] AC 버튼을 클릭하면 모든 값을 지우고 “0” 으로 초기화 되도록 구현
  - LV 8
    + [ ] 등호 (=) 버튼을 클릭하면 연산이 수행되도록 구현. 아래 메서드를 활용
      ``` swift
      func calculate(expression: String) -> Int? {
	    let expression = NSExpression(format: expression)
          if let result = expression.expressionValue(with: nil, context: nil) as? Int {
              return result
          } else {
              return nil
          }
      }
      ```

<br><br>

### 4. 과제 외 추가 기능
  - [ ] 미정

<br><br>

### 5. Trouble Shooting
[트러블 슈팅 노션 페이지 바로가기](https://seongto.notion.site/241118-241122-143a2764a657809c96affbb9d64e2889?pvs=4)




      
