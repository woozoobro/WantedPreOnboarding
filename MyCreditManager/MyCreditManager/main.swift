//
//  main.swift
//  MyCreditManager
//
//  Created by 우주형 on 2023/04/17.
//

import Foundation

//let myCreditManager = MyCreditManager()
//class MyCreditManager {
//    var students = [String: [String : String]]() // [이름 : [과목 : 성적]]
//
//    func showMenu() {
//        print("---")
//        print("[원하는 기능을 입력해주세요]")
//        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
//    }
//
//    func processUserInput(_ input: String) {
//
//        let menu = input.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
//
//        switch menu {
//        case "1":
//            addStudent()
//        case "2":
//            removeStudent()
//        case "3":
//            addGrade()
//        case "4":
//            removeGrade()
//        case "5":
//            showGradePointAverage()
//        default:
//            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
//        }
//
//    }
//
//    func isEnglish(_ str: String) -> Bool {
//        return str.range(of: "[^a-zA-Z]", options: .regularExpression) == nil
//    }
//
//    func addStudent() {
//        print("추가할 학생의 이름을 입력해주세요.")
//        if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            if !isEnglish(name) {
//                print("영어로만 입력해주세요.")
//                return
//            }
//
//            if students[name] != nil {
//                print("이미 존재하는 학생입니다.")
//                return
//            }
//
//            students[name] = [String: String]()
//            print("\(name) 학생이 추가되었습니다.")
//        }
//    }
//
//    func removeStudent() {
//        print("삭제할 학생의 이름을 입력해주세요.")
//        if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            if students[name] == nil {
//                print("\(name) 학생을 찾지 못했습니다.")
//                return
//            }
//
//            students.removeValue(forKey: name)
//            print("\(name) 학생이 삭제되었습니다.")
//        }
//    }
//
//    func addGrade() {
//        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
//        if let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ") {
//            if input.count != 3 {
//                print("입력이 잘못되었습니다. 다시 확인해주세요.")
//                return
//            }
//
//            let name = String(input[0])
//            let subject = String(input[1])
//            let grade = String(input[2])
//
//            if students[name] == nil {
//                print("\(name) 학생을 찾지 못했습니다.")
//                return
//            }
//
//            students[name]?[subject] = grade
//            print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
//        }
//    }
//
//    func removeGrade() {
//        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
//        if let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " "),
//           input.count == 2,
//           let name = input.first,
//           let subject = input.last,
//           let student = students[name] {
//
//            if student[subject] == nil {
//                print("\(name) 학생의 \(subject) 과목을 찾지 못했습니다.")
//                return
//            }
//
//            students[name]?.removeValue(forKey: subject)
//            print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
//        } else {
//            print("입력이 잘못되었습니다. 다시 확인해주세요.")
//        }
//    }
//
//    func showGradePointAverage() {
//        if students.isEmpty {
//            print("등록된 학생이 없습니다.")
//            return
//        }
//
//        print("평점을 알고 싶은 학생의 이름을 입력해주세요.")
//        if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            if let grades = students[name] {
//                var totalPoints = 0.0
//                var totalSubjects = 0
//
//                for (_, point) in grades {
//                    totalPoints += Double(point) ?? 0
//                    totalSubjects += 1
//                }
//
//                let average = totalPoints / Double(totalSubjects)
//                print("\(name) 학생의 평균 평점은 \(String(format: "%.2f", average))입니다.")
//            } else {
//                print("\(name) 학생을 찾지 못했습니다.")
//            }
//        }
//    }
//
//}
//while true {
//    myCreditManager.showMenu()
//    if let input = readLine() {
//        if input.lowercased() == "x" {
//            print("프로그램을 종료합니다...")
//            break
//        }
//        myCreditManager.processUserInput(input)
//    }
//}

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



struct SubjectAndGrade {
    var subject: String
    var grade: String?
}

struct Student {
    let name: String
    var subGradeList: [SubjectAndGrade]?
    
    init(name: String, subGradeList: [SubjectAndGrade]? = nil) {
        self.name = name
        self.subGradeList = subGradeList
    }
}

class MyCreditManager {
    static let shared = MyCreditManager()
    private init() { }
    var allStudents = [Student]()
    
    func showMenu() {
        print("___")
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    }
    
    func processUserInput(_ input: String) {
        let menu = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch menu {
        case "1":
            addStudent()
        case "2":
            removeStudent()
        case "3":
            addGrade()
        case "4":
            removeGrade()
        case "5":
            showAverageGrade()
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        }
    }
    
    func addStudent() {
        print("추가할 학생의 이름을 입력해주세요")
        if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            if !name.isEnglish {
                print("영어로만 입력해주세요.")
                return
            }
            
            if allStudents.contains(where: { $0.name == name }) {
                print("\(name)은(는) 이미 존재하는 학생입니다. 추가하지 않습니다.")
                return
            }
            
            let newStudent = Student(name: name)
            allStudents.append(newStudent)
            print("\(name) 학생이 추가되었습니다.")
        }
    }
    
    func removeStudent() {
        print("삭제할 학생의 이름을 입력해주세요")
        if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if !name.isEnglish {
                print("뭔가 잘못 입력하셨습니다. 다시 시작하세요")
                return
            }
            
            if let index = allStudents.firstIndex(where: { $0.name == name }) {
                allStudents.remove(at: index)
                print("\(name) 학생을 삭제하였습니다.")
                return
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
                return
            }
        }
    }
    
    func addGrade() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        if let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ") {
            if input.count != 3 {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
                return
            }
            
            let name = input[0]
            let subject = input[1]
            let grade = input[2]
            
            if !allStudents.contains(where: { $0.name == name }) {
                print("\(name) 학생을 찾지 못했습니다.")
                return
            }
            
            if let index = allStudents.firstIndex(where: { $0.name == name }) {
                let newSubGrade = SubjectAndGrade(subject: subject, grade: grade)
                allStudents[index].subGradeList?.append(newSubGrade)
                print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
                return
            }
        }
    }
    
    func removeGrade() {
        print("성적을 삭제할 학생의 이름, 과목이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        if let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ") {
            if input.count != 2 {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
                return
            }
            
            let name = input[0]
            let subject = input[1]
            
            if !allStudents.contains(where: { $0.name == name }) {
                print("\(name) 학생을 찾지 못했습니다.")
                return
            }
            
            if let index = allStudents.firstIndex(where: { $0.name == name }) {
                if let subIndex = allStudents[index].subGradeList?.firstIndex(where: { $0.subject == subject}) {
                    allStudents[index].subGradeList?[subIndex].grade = nil
                }
                print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                return
            }
        }
    }
    
    func showAverageGrade() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if !name.isEnglish {
                print("뭔가 잘못 입력하셨습니다. 다시 시작하세요")
                return
            }
            
            if !allStudents.contains(where: { $0.name == name }) {
                print("\(name) 학생을 찾지 못했습니다.")
                return
            }
            
            if let index = allStudents.firstIndex(where: { $0.name == name }) {
                if let subAndGradeList = allStudents[index].subGradeList {
                    for item in subAndGradeList {
                        print("\(item.subject): \(item.grade ?? "성적 없음")")
                        // 평점 작성
                        print("평점 계산해야함")
                    }
                    return
                }
            }
        }
    }
    
    
    
}

extension String {
    // 영어 혹은 숫자인지
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    // 영어 인지
    var isEnglish: Bool {
        return self.range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}
