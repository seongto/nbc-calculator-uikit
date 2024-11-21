//
//  Operations.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

/// 숫자 2개를 더하기
struct AddOperation: AbstractOperation {
    func operationNumber(_ num1: Int, _ num2: Int) -> Int {
        return num1 + num2
    }
}

/// 숫자2를 숫자1에서 빼기
struct SubstractOperation: AbstractOperation {
    func operationNumber(_ num1: Int, _ num2: Int) -> Int {
        return num1 - num2
    }
}

/// 숫자1과 숫자2를 곱하기
struct MultiplyOperation: AbstractOperation {
    func operationNumber(_ num1: Int, _ num2: Int) -> Int {
        return num1 * num2
    }
}

/// 숫자1을 숫자2로 나누기
struct DivideOperation: AbstractOperation {
    func operationNumber(_ num1: Int, _ num2: Int) -> Int {
        // 0으로 나누는 것을 방지 :
        guard ((num2 != 0) && (num1 != 0)) else {
            print("0을 나누거나 0으로 숫자를 나눌 수 없습니다.")
            print("계산기가 예민하여 결과값이 0으로 초기화됩니다.")
            return 0
        }
        
        return num1 / num2
    }
}

/// 숫자1을 숫자2로 나눈 나머지 구하기
struct ModulusOperation: AbstractOperation {
    func operationNumber(_ num1: Int, _ num2: Int) -> Int {
        // 0으로 나누는 것을 방지 :
        guard ((num2 != 0) && (num1 != 0)) else {
            print("0을 나누거나 0으로 숫자를 나눌 수 없습니다.")
            print("계산기가 예민하여 결과값이 0으로 초기화됩니다.")
            return 0
        }
        return num1 % num2
    }
}
