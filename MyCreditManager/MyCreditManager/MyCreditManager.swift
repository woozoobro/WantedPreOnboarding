//
//  MyCreditManager.swift
//  MyCreditManager
//
//  Created by 우주형 on 2023/04/18.
//

import Foundation

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
            
            let newStudent = Student(name: name, subGradeList: [])
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
            let gradeString = input[2].uppercased()
            
            //MARK: - 성적 입력 제대로 됐나 체크
            let gradeRegex = #"^[ABCDF][+-]?$"#
            let gradePredicate = NSPredicate(format:"SELF MATCHES %@", gradeRegex)
            guard gradePredicate.evaluate(with: gradeString) else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
                return
            }
            
            let grade = Grade(rawValue: gradeString)
            
            if !allStudents.contains(where: { $0.name == name }) {
                print("\(name) 학생을 찾지 못했습니다.")
                return
            }
            
            guard
                let grade = grade,
                let index = allStudents.firstIndex(where: { $0.name == name })
            else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
                return
            }
            
            // 이미 존재하는 과목이 있는 경우, 해당 과목의 점수를 변경
            let subAndGradeList = allStudents[index].subGradeList
            if let subIndex = subAndGradeList.firstIndex(where: { $0.subject == subject }) {
                allStudents[index].subGradeList[subIndex].grade = grade
                print("\(name) 학생의 \(subject) 과목이 \(grade.rawValue)로 변경되었습니다.")
            }
            // 새로운 과목인 경우, 새로운 과목과 성적을 추가
            else {
                let newSubGrade = SubjectAndGrade(subject: subject, grade: grade)
                allStudents[index].subGradeList.append(newSubGrade)
                print("\(name) 학생의 \(subject) 과목이 \(grade.rawValue)로 추가되었습니다.")
            }
            
            return
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
                if let subIndex = allStudents[index].subGradeList.firstIndex(where: { $0.subject == subject}) {
                    
                    allStudents[index].subGradeList[subIndex].grade = nil
                }
                print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                return
            }
        }
    }
    
    func showAverageGrade() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        if let name = readLine() {
            if !name.isEnglish {
                print("뭔가 잘못 입력하셨습니다. 다시 시작하세요")
                return
            }
            
            if !allStudents.contains(where: { $0.name == name }) {
                print("\(name) 학생을 찾지 못했습니다.")
                return
            }
            
            if let index = allStudents.firstIndex(where: { $0.name == name }) {
                let subAndGradeList = allStudents[index].subGradeList
                var totalScore = 0.0
                
                for item in subAndGradeList {
                    print("\(item.subject): \(item.grade?.rawValue ?? "성적 없음")")
                    guard let grade = item.grade else { continue }
                    let score = grade.point
                    totalScore += score
                }
                
                let average = totalScore / Double(subAndGradeList.count)
                
                print("\(name) 학생의 평균 평점은 \(average.formattedString())")
            } else {
                print("뭔가 잘못 입력하셨습니다. 다시 시작하세요")
            }
        }
    }

}
