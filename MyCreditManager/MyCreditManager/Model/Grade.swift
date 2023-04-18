//
//  Grade.swift
//  MyCreditManager
//
//  Created by 우주형 on 2023/04/18.
//

import Foundation

enum Grade: String {
    case APlus = "A+"
    case A = "A"
    case BPlus = "B+"
    case B = "B"
    case CPlus = "C+"
    case C = "C"
    case DPlus = "D+"
    case D = "D"
    case F = "F"
    
    var point: Double {
        switch self {
        case .APlus: return 4.5
        case .A: return 4
        case .BPlus: return 3.5
        case .B: return 3
        case .CPlus: return 2.5
        case .C: return 2
        case .DPlus: return 1.5
        case .D: return 1
        case .F: return 0
        }
    }
}
