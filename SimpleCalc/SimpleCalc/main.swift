//
//  main.swift
//  SimpleCalc
//
//  Created by Personal on 3/31/17.
//  Copyright © 2017 Ena Markovic. All rights reserved.
//

import Foundation

var intOperands = [Float]()
var mathOperator = ""
var regularMath = false
var wasInt = true
var fromCount = false

func reset() {
    wasInt = true
    fromCount = false
    intOperands = []
    print()
    print("Enter your expression:")
}

func intro() {
    print("Welcome to the calculator")
    print()
    print("For regular math: enter a number, an operator and another number separated by returns")
    print("For count: enter numbers separated by returns ending with 'count'")
    print("For averages: enter numbers separated by returns ending with 'avg'")
    print("For factorials: enter a number, hit return, enter 'fact'")
    reset()
}

func start() {
    while true {
        var response = readLine(strippingNewline: true)!
        if strlen(response) > 0 {
            response = response.trimmingCharacters(in: .whitespaces)
            switch response {
            case "+", "-", "*", "/":
                mathOperator = response
                regularMath = true
            case "count":
                countNums()
            case "avg":
                avg()
            case "fact":
                fact()
            default:
                wasInt = wasInt && (Int(response) != nil)
                let num = Float(response)
                
                if num != nil {
                    intOperands.append(num!)
                } else {
                    print("Invalid response")
                    reset()
                }
            }
            if regularMath {
                doMath()
            }
        } else {
            print("you did not enter a valid number")
            reset()
        }
    }
}

func printResult(result: Float) {
    if wasInt || fromCount {
        wasInt = true
        fromCount = false
        
        print("Result \(Int(result))")
    } else {
        print("Result \(result)")
    }
}

func countNums() {
    fromCount = true
    
    printResult(result: Float(intOperands.count))
    
    reset()
}

func avg() {
    let operandCnt = intOperands.count
    
    if operandCnt == 0 {
        print("Please enter a number")
    } else {
        var sum = Float(0)
        let count = intOperands.count
        
        for number in intOperands {
            sum += number
        }
        
        printResult(result: sum / Float(count))
    }
    
    reset()
}

func fact() {
    let operandCnt = intOperands.count
    
    if !wasInt {
        let intVal = Int(intOperands[0])
        print("Factorial function can only work on Ints, taking factorial of \(intVal)")
    }
    
    if operandCnt == 0 {
        print("Please enter a number")
    } else if operandCnt > 1 {
        print("Factorial can only accept one number")
    } else {
        var product = Float(1);
        let num = intOperands[0]
        for index in 1...Int(num) {
            product *= Float(index)
        }
        printResult(result: product)
    }
    
    reset()
}

func doMath() {
    let operandCnt = intOperands.count
    
    if operandCnt == 0 {
        print("Please enter a number")
    } else if operandCnt == 1 {
        return
    } else if operandCnt > 2 {
        print("Too many numbers entered")
    } else {
        switch mathOperator {
        case "+":
            printResult(result: intOperands[0] + intOperands[1])
        case "-":
            printResult(result: intOperands[0] - intOperands[1])
        case "*":
            printResult(result: intOperands[0] * intOperands[1])
        case "/":
            printResult(result: intOperands[0] / intOperands[1])
        default:
            print("Ivalid operator.")
        }
    }

    regularMath = false
    reset()
}

intro()
start()





