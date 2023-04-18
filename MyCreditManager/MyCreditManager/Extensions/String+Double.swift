//
//  String+Double.swift
//  MyCreditManager
//
//  Created by 우주형 on 2023/04/18.
//

import Foundation

extension String {
    // 영어 혹은 숫자인지
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    // 영어 인지
    var isEnglish: Bool {
        let pattern = "^[a-z]+$"
        return range(of: pattern, options: .regularExpression) != nil
    }
}

//MARK: - 소수점 최대 두번째까지 출력하게
extension Double {
    func formattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
