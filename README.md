![Logo](https://github.com/swieeft/DotPattern-UIBezierPath/blob/master/md-Resource/Logo.png)

DotPattern-UIBezierPath
=======================

## 1. DotPattern을 왜 만들게 되었을까요?
UIBezierPath를 처음 접하게 되었을 때 새로운 세상을 본 것 같이 신기하였습니다. 
단순히 코드 만으로 퀄리티 있는 그림을 그린다? 지금까지 상상도 못했던 이야기였습니다.
그렇게 UIBezierPath를 사용해보기 시작했습니다.

우선 회사에서 개발하고 있는 앱의 아이콘을 만들어서 로딩 이미지로 쓰려고 시도를 했습니다. 
그런데 왠걸? 포인트 계산부터 너무 어려워 단순한 이미지인데도 장장 5시간에 걸쳐서 완성하게 되었습니다.

그 뒤로 어떻게하면 좀 더 편하게 UIBezierPath를 사용할 수 있을까 고민하던 차에 점 잇기 그림이 떠올랐습니다.
단순히 점으로 찍혀 있는 부분만 순서대로 연결하면 하나의 그림이 완성 되는 점 잇기 그림처럼 
UIBezierPath도 포인트가 아닌 점으로 이어 진다면 좀 더 수월하게 사용할 수 있지 않을까?
그렇게 생각하고 개발을 시작하게 되어 DotPattern-UIBezierPath가 되었습니다.
    
하얀 도화지에 아무것도 없이 임의의 점을 찾는 것이 아닌 눈에 보이는 점을 이어 만드는 
DotPattern-UIBezierPath를 사용하여 여러분만의 멋진 그림을 그려보세요!

![FishExample | 20%](https://github.com/swieeft/DotPattern-UIBezierPath/blob/master/md-Resource/FishExample.gif)

## 2. 사용법
* **선택한 뷰에 DotPattern 생성**
  * view : UIBezierPath가 적용된 layer를 추가할 view
  * layer : 사용자가 설정한 값으로 생성 될 UIBezierPath를 적용할 layer(생략가능)
  * row : view의 row 개수
  * col : view의 column 개수
  * row와 col은 (view의 크기 / 개수)로 하여 간격이 결정됩니다.
```swift 
public init(view: UIView, layer:CAShapeLayer, row: Int, col: Int)
(ex. var dotPattern:DotPattern = DotPattern(view: myView, layer: myLayer row: 40, col: 20))
```

* **DotPattern 보기**
  * rowRange : 보고자 하는 row의 범위(생략가능)
  * colRange : 보고자 하는 column의 범위(생략가능)
  * rowRange, colRange 모두 생략 시 전체 범위의 DotPattern을 보여줍니다.
```swift
public func viewDot(rowRange: CountableClosedRange<Int>, colRange: CountableClosedRange<Int>)
(ex. dotPattern.viewDot(rowRange: 5...10, colRange: 1...15))
```

* **DotPattern 숨기기**
```swift
public func hiddenDot()
```

* **유효한 위치의 점인지 확인**
  * row : row 번호
  * col : column 번호
  * return : true -> 존재하지 않음, false -> 존재함
```swift 
public func isEmpty(row: Int, col: Int) -> Bool
(ex. row: 10, col: 5
    dotPattern.isEmpty(row: 15, col: 4) -> true
    dotPattern.isEmpty(row: 5, col: 3) -> false
```

* **선택한 위치의 Point 가져오기**
  * row : row 번호
  * col : column 번호
  * return : 선택한 위치의 CGPoint
```swift 
public func get(_ row: Int, _ col: Int) -> CGPoint
(ex. dotPattern.get(10, 5) -> CGPoint(x : 200, y: 100))
```

## 3. JSON을 이용한 사용법
DotPattern-UIBezierPath는 코드로만 작업 할 수 있도록 하는 것이 아닌 JSON 형식을 제공하여 Path의 재사용성을 높이고, 서버에서 Path 데이터를 내려주어 좀 더 유연하게 UIBezierPath를 활용하여 작업 할 수 있도록 지원하고 있습니다.

* **JSON 형식**
```swift
public struct JSONData:Decodable {
    var width:CGFloat?  // view의 넓이 값
    var height:CGFloat? // view의 높이 값
    var row:Int?        // view의 행 개수
    var col:Int?        // view의 열 개수
    var layers:[Layer]? // view에 추가 될 layer 정보
    
    public struct Layer:Decodable {
        var datas:[Data]?   // layer의 path data array
        
        // path data
        public struct Data:Decodable {
            var type:String?        // path의 종류 (line, curve, arc 등)
            var startPoint:Point?   // path의 시작 점
            var endPoint:Point?     // path의 종료 점
            var curve:Curve?        // curve 타입일 때의 curve 정보
            var arc:Arc?            // arc 타입일 때의 arc 정보
            
            // path의 각 점에 대한 정보
            public struct Point:Decodable {
                var x:Int?
                var y:Int?
            }
            
            // curve 정보
            public struct Curve:Decodable {
                var controlPoint1:Point?
                var controlPoint2:Point?
            }
            
            // arc 정보
            public struct Arc:Decodable {
                var radius:CGFloat?     // 원의 반지름
                var startAngle:CGFloat? // 원의 시작 각도
                var endAngle:CGFloat?   // 원의 종료 각도
                var clockwise:Bool?     // 원이 그려지는 방향 (true:시게, false:반시계)
            }
        }
    }
}
```

* **URL로 JSON 데이터를 받아와 그리기**
  * ulr : JSON 데이터를 받아올 url 
```swift 
public func createPath(url: String, completion: @escaping (_ paths:[UIBezierPath], _ success:Bool) -> Void)
```

* **JSON 데이터 예제코드**
  * [JSON 데이터 예제 링크](md-Resource/hellodot.json)
```swift
self.dotPattern.createPath(url: "https://raw.githubusercontent.com/swieeft/DotPattern-UIBezierPath/master/md-Resource/hellodot.json") { (paths, success) in
            // your source code
        }
```
![HelloDotExample](https://github.com/swieeft/DotPattern-UIBezierPath/blob/master/md-Resource/HelloDot.gif)

## 4. Dot Editor
DotPattern-UIBezierPath를 더욱 쉽게 사용하기 위해서는 어떻게 해야 할지 고민하다 생각한 방법은 Dot-Editor입니다. 

우리가 포토샵이나 스케치 등의 이미지 작업 프로그램에서 이미지 파일을 작업하고 저장하여 App에서 사용하듯이 DotPattern-UIBezierPath는 Dot-Editor에서 Path를 작업하고 저장(JSON Data)하여 App에서 사용하도록 지원합니다.

Dot-Editor로 인해 하나하나 포인트를 찾아가며 작업을 해야했던 불편한 과정이 사라지고 더욱 쉽게, 누구나 원하는 Path를 그릴 수 있게 되었습니다.

* Dot Editor Link : [Dot Editor](https://kingcjy.github.io/Dot-Editor/)
* GitHub URL : [GitHub](https://github.com/KingCjy/Dot-Editor)

## 5. 확장기능
DotPattern-UIBezierPath에서는 UIBezierPath를 확장하여 UIBezierPath의 함수를 체이닝으로 사용 할 수 있게끔 하였습니다.

* **Move : m(to: CGPoint)**
  * to : path가 이동 할 포인트
```swift 
public func m(to point: CGPoint) -> Self
```

* **Line : line(to: CGPoint)**
  * to : 선을 이어줄 다음 포인트
```swift 
public func line(to point: CGPoint) -> Self
```

* **Carve : carve(to: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint)**
  * to : 곡선을 이어줄 다음 포인트
  * controlPoint1 : 곡선을 만들어 주기 위한 첫번째 기준 포인트
  * controlPoint2 : 곡선을 만들어 주기 위한 두번째 기준 포인트
```swift 
public func carve(to point: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> Self
```

* **QuadCurve : quadCurve(to: CGPoint, controlPoint: CGPoint)**
  * to : 곡선을 이어줄 다음 포인트
  * controlPoint : 곡선을 만들어 주기 위한 기준 포인트
```swift 
public func quadCurve(to point: CGPoint, controlPoint: CGPoint) -> Self
```

* **Arc : arc(center: CGPoint, radius: CGFloat, start: CGFloat, end: CGFloat, clockwise: Bool)**
  * center : 원의 중심점
  * radius : 원의 반지름
  * start : 원을 그릴 때 시작할 위치 Angel
  * end : 원을 그릴때 종료 될 위치 Angel
  * clockwise : 원이 그려지는 방향 (시계방향/반시계방향)
```swift 
public func arc(center: CGPoint, radius: CGFloat, start: CGFloat, end: CGFloat, clockwise: Bool) -> Self
```


### 6. 예제소스
* **하트 그리기**
```swift
class HeartViewController: UIViewController {

   @IBOutlet weak var dotView: UIView!
    
   @IBOutlet weak var viewDotButton: UIButton!

    var dotPattern:DotPattern!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dotPattern = DotPattern(view: self.dotView, row: 20, col: 11)
    }
    
    @IBAction func ViewDotAction(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            if title == "View Dot" {
                self.dotPattern.viewDot()
                sender.setTitle("Hide Dot", for: .normal)
            } else {
                self.dotPattern.hiddenDot()
                sender.setTitle("View Dot", for: .normal)
            }
        }
    }
    
    @IBAction func ShowHeartAction(_ sender: Any) {
        let path = UIBezierPath()
        
        path.m(to: getPoint(10, 6))
            .curve(to: getPoint(10, 3), controlPoint1: getPoint(8, 5), controlPoint2: getPoint(8, 3))
            .curve(to: getPoint(14, 6), controlPoint1: getPoint(11, 3), controlPoint2: getPoint(13, 5))
            .curve(to: getPoint(10, 9), controlPoint1: getPoint(13, 7), controlPoint2: getPoint(11, 9))
            .curve(to: getPoint(10, 6), controlPoint1: getPoint(8, 9), controlPoint2: getPoint(8, 7))
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeEnd = 0
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 3
        layer.fillColor = UIColor.clear.cgColor
        
        let animation = setAnimation()
        layer.add(animation, forKey: "ani")
        
        self.dotView.layer.addSublayer(layer)
    }
    
    func setAnimation() -> CAAnimationGroup {
        let duration: TimeInterval = 5
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        
        let animation2 = CABasicAnimation(keyPath: "fillColor")
        animation2.fromValue = UIColor.clear.cgColor
        animation2.toValue = UIColor.red.cgColor
        animation2.duration = duration
        animation2.fillMode = kCAFillModeForwards
        animation2.repeatCount = .infinity
        animation2.isRemovedOnCompletion = false
        
        let group = CAAnimationGroup()
        group.animations = [animation, animation2]
        group.duration = duration
        group.fillMode = kCAFillModeForwards
        group.repeatCount = .infinity
        group.isRemovedOnCompletion = false
        
        return group
    }
    
    func getPoint(_ row: Int, _ col: Int) -> CGPoint {
        return self.dotPattern.get(row, col)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
```
![HeartExample](https://github.com/swieeft/DotPattern-UIBezierPath/blob/master/md-Resource/HeartExemple.gif)

## 7. 설치방법
준비중입니다...


## 8. 라이센스 
DotPattern-UIBezierPath는 MIT 라이센스를 사용합니다.
