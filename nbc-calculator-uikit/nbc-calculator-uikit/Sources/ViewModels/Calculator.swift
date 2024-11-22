//
//  Calculator.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import UIKit
import OSLog

struct Calculator {
    
    // 계산기에 항상 계산된 결과값을 저장. 현재 숫자의 의미
    var currentDisplay: [(String, CalButtonTypes)]
    var history: [Task]
    var isResultDisplay: Bool // 결과값 초기화 용.
    
    init() {
        self.currentDisplay = []
        self.history = []
        self.isResultDisplay = false
    }
    
    
    /// 계산식에 사용자가 입력한 정보를 누적시킨다. 이 누적된 정보는 displayLabel 에 출력된다.
    /// - Parameters:
    ///   - str: 숫자 혹은 연산기호와 같이 계산에 필요한 실제적인 값.
    ///   - type: 해당 값의 타입. 숫자인지 연산기호인지, 어떤 연산기호인지 체크하는 용도.
    mutating func addToDisplay(_ str: String, _ type: CalButtonTypes) {
        guard let last = currentDisplay.last else {
            currentDisplay.append((str, type))
            return
        }
                
        switch type {
        case .number:
            if last.1 == .number {
                // 이전 숫자가 0일 경우 이를 초기화한 후 숫자입력, 그 외의 숫자일 경우 숫자에 결합.
                if last.0 == "0" || isResultDisplay { // 0으로 시작 방지 및 결과출력 직후 숫자 누를 경우 현재 값 초기화
                    currentDisplay.removeLast()
                    currentDisplay.append((str, type))
                    isResultDisplay = false
                } else {
                    let lastNum: String = last.0
                    currentDisplay.removeLast()
                    currentDisplay.append((lastNum + str, type))
                }
            } else {
                // 0으로 나누려고 하는 경우에 입력이 안되도록 하기.
                if last.1 == .divide && str == "0" {
                    os_log(.debug, "0 안돼!")
                    return
                }
                
                currentDisplay.append((str, type))
            }
        case .add, .subtract, .multiply, .divide:
            if last.1 == .number {
                currentDisplay.append((str, type))
            } else {
                currentDisplay.removeLast()
                currentDisplay.append((str, type))
            }
        case .clear, .calculate:
            os_log(.debug, "\(last.1.rawValue) 너가 왜 나와?")
        }
                
    }
    
    
    /// 현재 계산식을 초기화하고 초기화면에서 다시 시작.
    mutating func clear() {
        currentDisplay.removeAll()
        currentDisplay.append(("0", .number))
    }
    
    
    mutating func calculateAll() {
        // 입력 데이터가 비정상이거나 아무것도 없을 경우 현재 디스플레이를 초기화.
        guard var arr = validateDisplay() else {
            return
        }
        
        // 추가 수식이 없거나 숫자가 한개 뿐일 경우(=arr.count < 3) 아무 동작없음.
        if arr.count < 3 {
            return
        }
        
        var idx: Int = 1
        
        // 곱셈과 나눗셈을 우선적으로 계산.
        while true {
            
            if idx >= arr.count - 1 {
                break
            }
            

            if arr[idx].1 == .multiply {
                // 너무 크거나 작은수로 인한 크래시에 대한 예외처리
                // 유효성 검사에서도 한번 거르지만 곱하기 결과에 따라 추가적으로 발생할 수 있으므로 한번 더 검사
                if (arr[idx - 1].0.count > 9) || (arr[idx + 1].0.count > 9) {
                    os_log(.debug, "숫자가 너무 크거나 작습니다.")
                    saveBadLog("숫자가 너무 크거나 작아요. 다시 시작해주세요.")
                    return
                }
                
                let tempResult: Int = MultiplyOperation().operationNumber(Int(arr[idx - 1].0)!, Int(arr[idx + 1].0)!)
                
                arr[idx] = (String(tempResult), .number)
                arr.remove(at: idx + 1)
                arr.remove(at: idx - 1 )
                                
            } else if arr[idx].1 == .divide {
                
                guard Int(arr[idx + 1].0) != 0 else {
                    self.clear()
                    return
                }
                
                let tempResult: Int = DivideOperation().operationNumber(Int(arr[idx - 1].0)!, Int(arr[idx + 1].0)!)
                
                arr[idx] = (String(tempResult), .number)
                arr.remove(at: idx + 1)
                arr.remove(at: idx - 1 )
                
            } else {
                idx += 1
            }
            
            
        }
        
        
        // 최종 계산 결과를 담는 sum. 로직 실패로 첫 수가 숫자가 아닐 경우 초기화.
        guard var sum: Int = Int(arr[0].0) else {
            os_log(.debug, "\(arr)")
            saveBadLog("계산기가 실수를 한 것 같다...")
            return
        }
        
        if arr.count > 1 {
            // 덧셈과 뺄셈은 순차적으로 진행
            for i in 1...(arr.count / 2) {
                // 만약 다음에 숫자가 아닐 경우 아묻따 초기화.
                guard let nextNum: Int = Int(arr[2 * i].0) else {
                    os_log(.debug, "\(arr)")
                    self.clear()
                    return
                }
                
                if arr[2 * i - 1].1 == .add {
                    sum += nextNum
                } else {
                    sum -= nextNum
                }
            }
        
        }
        
        saveResult(sum)
        
    }
    
    mutating func saveResult(_ result: Int) {
        // 이전 기록 조회 및 마지막 계산식을 hitoryLabel에 띄워주기 위해 해당 기록을 저장.
        history.append( Task(currentDisplay.map{ $0.0 }.joined(separator: " "), String(result)) )
        currentDisplay.removeAll()
        currentDisplay.append((String(result), .number)) // 마지막 결과값 남기기
        isResultDisplay = true // 결과 출력 후 숫자를 입력할 경우 현재 결과를 사용하지 않고 초기화하기 위함.
    }
    
    mutating func saveBadLog(_ msg: String) {
        history.append( Task(msg, "error") )
        currentDisplay.removeAll()
        currentDisplay.append(("0", .number))
        isResultDisplay = true
    }
    
    mutating func validateDisplay() -> [(String, CalButtonTypes)]? {
        // 아무값이 없을 경우 검증 단계 스킵.
        if currentDisplay.isEmpty {
            return nil
        }
        
        var arr = currentDisplay
        
        // 연산기호 여부 확인용
        let symbols: [CalButtonTypes] = [.add, .subtract, .multiply, .divide]
        
        for i in 0..<arr.count {
            //
            if (i + 1) % 2 == 0 {
                // 짝수 항목은 항상 기호여야 한다.
                guard symbols.contains(arr[i].1) else {
                    os_log(.debug, "기호가 있어야 합니다.")
                    saveBadLog("계산기가 뭔가 실수를 저질렀어요!")
                    return nil
                }
            } else {
                // 홀수 항목은 항상 숫자여야 한다.
                guard arr[i].1 == .number else {
                    os_log(.debug, "숫자가 있어야 합니다.")
                    saveBadLog("계산기가 뭔가 실수를 저질렀어요!")
                    return nil
                }
            }
            
            // 나누기 기호 다음 0이 있을 경우 에러
            if arr[i].1 == .divide && arr[i + 1].0 == "0" {
                os_log(.debug, "0으로 나눌 수 없어.")
                saveBadLog("0으로 나누기 금지!")
                return nil
            }
            
            // 너무 크거나 작은 숫자 있으면 초기화하기
            if arr[i].0.count > 9 {
                os_log(.debug, "숫자가 너무 크거나 작습니다.")
                saveBadLog("숫자가 너무 크거나 작아요. 다시 시작해주세요.")
                return nil
            }
        }
        
        // 마지막 항목이 기호일 경우 이를 제거
        if arr.last!.1 != .number {
            arr.removeLast()
        }
        
        return arr
    }
}
