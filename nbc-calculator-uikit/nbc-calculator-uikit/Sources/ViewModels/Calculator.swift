//
//  Calculator.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import UIKit

class Calculator {
    
    // 계산기에 항상 계산된 결과값을 저장. 현재 숫자의 의미
    var result:Int

    init() {
        self.result = 0
    }
    

    // 연산자 기호와 숫자를 받아 결과를 출력해주는 메소드
    // 인스턴스 내부에 result를 기록중이므로 연산 결과를 result에 저장하고 이를 반환함.
    func calculate(operator opText: String, firstNumber: Int?, secondNumber: Int) -> Int {
        switch opText {
        case "+":
            if firstNumber != nil {
                result =  AddOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                result =  AddOperation().operationNumber(result, secondNumber)
            }
        case "-":
            if firstNumber != nil {
                result =  SubstractOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                result =  SubstractOperation().operationNumber(result, secondNumber)
            }
        case "*":
            if firstNumber != nil {
                result =  MultiplyOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                result =  MultiplyOperation().operationNumber(result, secondNumber)
            }
        case "/":
            if firstNumber != nil {
                result =  DivideOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                result =  DivideOperation().operationNumber(result, secondNumber)
            }
        case "%":
            if firstNumber != nil {
                result =  ModulusOperation().operationNumber(firstNumber!, secondNumber)
            } else {
                result =  ModulusOperation().operationNumber(result, secondNumber)
            }
        default:
            print("잘못된 연산자입니다. +, -, *, /, % 만 지원합니다.")
            result = 0
        }
        
        return result
    }
    
    // 현재 인스턴스에 저장된 result 값을 반환
    func printResult() -> Int {
        return result
    }
    
    func resetResult() -> Int {
        result = 0
        return result
    }
    
}
