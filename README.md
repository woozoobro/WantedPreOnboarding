# WantedPreOnboarding
 
## 프로젝트 구성

Command Line Tool은 처음 사용해보는 것 같다.

readLine()이라는 메소드를 사용해서 유저의 인풋을 콘솔로 받을 수 있다는 걸 알게 됨  

콘솔에 타이핑을 입력하고 엔터를 치면 된다!  

우선은 프로그램이 계속 실행되어야 하니까 while문이 항상 true이게 해주자

```swift
while true {
    let something = readLine()
    print(something)
}
```
하고 입력을 해보면

![](https://velog.velcdn.com/images/woojusm/post/9bce0ab2-2be2-45a3-a54c-27b000229974/image.png)
옵셔널 해제가 필요하겠군요

그리고 x를 입력하면 while문을 벗어나게 해줍시다  
x의 대소문자 구분없이!

```swift
while true {
    if let input = readLine() {
        if input.lowercased() == "x" {
            print("프로그램을 종료합니다...")
            break
        }
    }
}
```

이제 class를 구성해서 메뉴가 뜨는 거랑, 유저 인풋을 가지고 처리들을 해줍시다  
따로 인스턴스 안만들어도 되게 싱글톤으로 만들까?!

```swift
class MyCreditManager {
    static let shared = MyCreditManager()
    private init() { }
    
    func showMenu() {
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    }    
}
```

오케이! 그리고 showMenu를 while문 제일 상단에 올려줌  

## 학생추가

이제 UserInput의 진행을 관리하는 메소드를 구성해야겠다  

흠,,,
공백 처리도 해줄까? 아니면 그냥 숫자만 입력하게할까

```swift
//In MyCreditManager...
func processUserInput(_ input: String) {
    let menu = input.trimmingCharacters(in: .whitespacesAndNewlines)
    
    switch menu {
    case "1":
        print("추가할 학생의 이름을 입력해주세요")
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}
```

앞뒤로 스페이스바 공백 제거하게 해줌!  

case들 12345 만들어주고,  
각각의 case들에 해당하는 메소드를 구성, 실행해주면 되겠다!  
(이 메소드들에서 readLine()을 한번더 작성하면 거기서 걸쳐진다는 걸 알게됨!)

```swift
func addStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {        
    
    }    
}
```

addStudent를 할라고 보니 student 모델이 있어야겠음  

```swift
struct Student {
    let name: String
    let subject: String?
    let grade: String?
}
```

간단하게 구성함!  
>🤔 subject랑 grade는 우선은 옵셔널하게 만들었는데 나중에 수정해야될 수도

아하잇
var가 되야겠구나

```swift
struct Student {
    let name: String
    var subject: String?
    var grade: String?
    
    init(name: String, subject: String? = nil, grade: String? = nil) {
        self.name = name
        self.subject = subject
        self.grade = grade
    }
}
```
init구문안에서 nil넣어서 새로 만들때 다른 거 입력 안해도 되게해줌  

```swift
func addStudent() {
        print("추가할 학생의 이름을 입력해주세요")
        if let name = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if allStudents.contains(where: { $0.name == name }) {
                print("\(name)은(는) 이미 존재하는 학생입니다. 추가하지 않습니다.")
                return
            }
            
            let newStudent = Student(name: name)
            allStudents.append(newStudent)
            print("\(name) 학생이 추가되었습니다.")
        }
    }
```
Manager안에 allStudents array 만들어두고 addStudent로직 추가해줬다  

근데 이거 여기서도 잘못된 입력에 대한 처리가 필요함

아하핫 영어 입력만 받는 거 찾다가 입력이 영어 혹은 숫자인지 알아내는 방법을 찾았다!  
[스택갓](https://stackoverflow.com/questions/35992800/check-if-a-string-is-alphanumeric-in-swift)

```swift
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
```
String extension으로 영어 입력체크하는 computed property 만듬  

![](https://velog.velcdn.com/images/woojusm/post/ce152333-cd20-42d9-90f3-aca4a2fa6fab/image.png)

옴하하  

대소문자 구별해줄까?!
흠 .lowercased()쓸까말까 고민하다 그냥 대소문자 다르면 다른 학생인걸로 인식하게 해줌  

___

## 학생 삭제

```swift
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
```

이전이랑 비슷한 뉘앙스로 구성  

___

## 성적 추가
앗하이
성적 추가 구현하다보니까  
이거 과목이랑 성적이 같이 매핑되야함  
SubjectAndGrade라는 또 새로운 struct 모델을 만들어줌!

![](https://velog.velcdn.com/images/woojusm/post/8df0e635-404a-4089-9df1-d4ce809ae470/image.png)


```swift
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
```
___

## 성적 삭제

```swift
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
```
>🤔firstIndex찾는걸로 두번 반복했는데 더 효율적으로 할 방법있을 것 같음!
딕셔너리로 바꿔줘야하려나?

___
## 평점보기  

grade를 enum타입으로 바꾸는 게 나을 거 같다..!

```swift
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

struct SubjectAndGrade {
    var subject: String
    var grade: Grade?
}

struct Student {
    let name: String
    var subGradeList: [SubjectAndGrade]?
    
    init(name: String, subGradeList: [SubjectAndGrade]? = nil) {
        self.name = name
        self.subGradeList = subGradeList
    }
}
```



와아아
진짜 뭐가 잘못됐나 한참을 찾았음...
`var subGradeList: [SubjectAndGrade]?`
여부분이 잘못 됐었음  
옵셔널하지 않게 바꿔야함  
grade는 옵셔널해도 Subgrade리스트는 없으면 그냥 빈배열로 고고!

```swift
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
```

___


![](https://velog.velcdn.com/images/woojusm/post/f0001b5e-7f76-4c7a-b4d5-33c7833d238a/image.png)|![](https://velog.velcdn.com/images/woojusm/post/ed44799d-4fbe-4e22-a786-163d89bf3c42/image.png)
---|---|

![](https://velog.velcdn.com/images/woojusm/post/dd9ee8e8-3f25-4f2e-a513-988a275a5266/image.png)|![](https://velog.velcdn.com/images/woojusm/post/ee178b06-639e-4d9f-ac01-645334368867/image.png)
---|---|

![](https://velog.velcdn.com/images/woojusm/post/9af8956e-9d9a-4a9f-9a3f-fb8e803b483f/image.png)



![](https://velog.velcdn.com/images/woojusm/post/33553445-d88b-4ace-b589-f5799e8cd44f/image.png)
끝! 프로그램을 종료합니다..
