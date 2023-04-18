//
//  main.swift
//  MyCreditManager
//
//  Created by 우주형 on 2023/04/17.
//

import Foundation

while true {
    MyCreditManager.shared.showMenu()
    if let input = readLine() {
        if input.lowercased() == "x" {
            print("프로그램을 종료합니다...")
            break
        }
        MyCreditManager.shared.processUserInput(input)
    }
}
