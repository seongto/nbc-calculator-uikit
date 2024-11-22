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
    var currentValue: Int
    var currentDisplay: [(String, CalButtonTypes)]
    
    init() {
        self.currentValue = 0
        self.currentDisplay = []
    }
    
    
    mutating func addToDisplay(_ str: String, _ type: CalButtonTypes) {
        guard let last = currentDisplay.last else {
            currentDisplay.append((str, type))
            return
        }
                
        switch type {
        case .number:
            if last.1 == .number {
                if last.0 == "0" {
                    currentDisplay.removeLast()
                    currentDisplay.append((str, type))
                } else {
                    let lastNum: String = last.0
                    currentDisplay.removeLast()
                    currentDisplay.append((lastNum + str, type))
                }
            } else {
                currentDisplay.append((str, type))
            }
        case .mathSymbol:
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
    
    mutating func clear() {
        currentDisplay.removeAll()
        currentDisplay.append(("0", .number))
    }
    
    // 연산자 기호와 숫자를 받아 결과를 계산
    // 인스턴스 내부에 result를 기록중이므로 연산 결과를 result에 저장하고 이를 반환함.
    mutating func calculate(operator opText: String, firstNumber: Int?, secondNumber: Int) -> Int {
        switch opText {
        case "+":
            if firstNumber != nil {
                currentValue =  AddOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                currentValue =  AddOperation().operationNumber(currentValue, secondNumber)
            }
        case "-":
            if firstNumber != nil {
                currentValue =  SubstractOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                currentValue =  SubstractOperation().operationNumber(currentValue, secondNumber)
            }
        case "*":
            if firstNumber != nil {
                currentValue =  MultiplyOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                currentValue =  MultiplyOperation().operationNumber(currentValue, secondNumber)
            }
        case "/":
            if firstNumber != nil {
                currentValue =  DivideOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                currentValue =  DivideOperation().operationNumber(currentValue, secondNumber)
            }
        case "%":
            if firstNumber != nil {
                currentValue =  ModulusOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                currentValue =  ModulusOperation().operationNumber(currentValue, secondNumber)
            }
        default:
            break
        }
        
        return currentValue
    }
    
    // 현재 인스턴스에 저장된 result 값을 반환
    mutating func printResult() -> Int {
        return currentValue
    }
    
    mutating func resetResult() -> Int {
        currentValue = 0
        return currentValue
    }
    
}
