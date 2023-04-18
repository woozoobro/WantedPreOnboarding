//
//  Student.swift
//  MyCreditManager
//
//  Created by 우주형 on 2023/04/18.
//

import Foundation

struct Student {
    let name: String
    var subGradeList: [SubjectAndGrade]
    
    init(name: String, subGradeList: [SubjectAndGrade]) {
        self.name = name
        self.subGradeList = subGradeList
    }
}

struct SubjectAndGrade {
    var subject: String
    var grade: Grade?
}
