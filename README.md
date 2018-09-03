![Logo](https://github.com/swieeft/DotPattern-UIBezierPath/blob/master/md-Resource/Logo.png)

DotPattern-UIBezierPath
=======================

### 1. 왜 DotPattern-UIBezierPath인가?
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



### 2. 사용법
> * 선택한 뷰에 DotPattern 생성
>   * view : UIBezierPath가 적용된 layer를 추가할 view
>   * layer : 사용자가 설정한 값으로 생성 될 UIBezierPath를 적용할 layer(생략가능)
>   * row : view의 row 개수
>   * col : view의 column 개수
>   * row와 col은 (view의 크기 / 개수)로 하여 간격이 결정됩니다.
> <pre><code>public init(view: UIView, layer:CAShapeLayer, row: Int, col: Int)
> (ex. var dotPattern:DotPattern = DotPattern(view: myView, layer: myLayer row: 40, col: 20))</code></pre>
>
> * DotPattern 보기
>   * rowRange : 보고자 하는 row의 범위(생략가능)
>   * colRange : 보고자 하는 column의 범위(생략가능)
>   * rowRange, colRange 모두 생략 시 전체 범위의 DotPattern을 보여줍니다.
> <pre><code>public func viewDot(rowRange: CountableClosedRange<Int>, colRange: CountableClosedRange<Int>)
> (ex. dotPattern.viewDot(rowRange: 5...10, colRange: 1...15))</code></pre>
>
> * DotPattern 숨기기
> <pre><code>public func hiddenDot()</code></pre>
>
> * 유효한 위치의 점인지 확인 
>   * row : row 번호
>   * col : column 번호
>   * return : true -> 존재하지 않음, false -> 존재함
> <pre><code>public func isEmpty(row: Int, col: Int) -> Bool
> (ex. row: 10, col: 5
>     dotPattern.isEmpty(row: 15, col: 4) -> true
>     dotPattern.isEmpty(row: 5, col: 3) -> false </code></pre>
>
> * 선택한 위치의 Point 가져오기
>   * row : row 번호
>   * col : column 번호
>   * return : 선택한 위치의 CGPoint
> <pre><code>public func get(_ row: Int, _ col: Int) -> CGPoint
> (ex. dotPattern.get(10, 5) -> CGPoint(x : 200, y: 100))</code></pre>

* * *

### 3. 확장기능
> DotPattern-UIBezierPath에서는 UIBezierPath를 확장하여 UIBezierPath의 함수를 체이닝으로 사용 할 수 있게끔 하였습니다.
> * Move : m(to: CGPoint)
>   * to : path가 이동 할 포인트
> <pre><code>public func m(to point: CGPoint) -> Self</code></pre>
>
> * Line : line(to: CGPoint)
>   * to : 선을 이어줄 다음 포인트
> <pre><code>public func line(to point: CGPoint) -> Self</code></pre>
>
> * Carve : carve(to: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint)
>   * to : 곡선을 이어줄 다음 포인트
>   * controlPoint1 : 곡선을 만들어 주기 위한 첫번째 기준 포인트
>   * controlPoint2 : 곡선을 만들어 주기 위한 두번째 기준 포인트
> <pre><code>public func carve(to point: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> Self</code></pre>
>
> * QuadCurve : quadCurve(to: CGPoint, controlPoint: CGPoint)
>   * to : 곡선을 이어줄 다음 포인트
>   * controlPoint : 곡선을 만들어 주기 위한 기준 포인트
> <pre><code>public func quadCurve(to point: CGPoint, controlPoint: CGPoint) -> Self</code></pre>
>
> * Arc : arc(center: CGPoint, radius: CGFloat, start: CGFloat, end: CGFloat, clockwise: Bool)
>   * center : 원의 중심점
>   * radius : 원의 반지름
>   * start : 원을 그릴 때 시작할 위치 Angel
>   * end : 원을 그릴때 종료 될 위치 Angel
>   * clockwise : 원이 그려지는 방향 (시계방향/반시계방향)
> <pre><code>public func arc(center: CGPoint, radius: CGFloat, start: CGFloat, end: CGFloat, clockwise: Bool) -> Self</code></pre>

* * *

### 4. 예제소스
> * 하트 그리기
> <pre><code> class HeartViewController: UIViewController {
>
>   @IBOutlet weak var dotView: UIView!
>    
>   @IBOutlet weak var viewDotButton: UIButton!
>
>    var dotPattern:DotPattern!
>    
>    override func viewDidLoad() {
>        super.viewDidLoad()
>    }
>    
>    override func viewDidAppear(_ animated: Bool) {
>        super.viewDidAppear(animated)
>        
>        self.dotPattern = DotPattern(view: self.dotView, row: 20, col: 11)
>    }
>    
>    @IBAction func ViewDotAction(_ sender: UIButton) {
>        if let title = sender.title(for: .normal) {
>            if title == "View Dot" {
>                self.dotPattern.viewDot()
>                sender.setTitle("Hide Dot", for: .normal)
>            } else {
>                self.dotPattern.hiddenDot()
>                sender.setTitle("View Dot", for: .normal)
>            }
>        }
>    }
>    
>    @IBAction func ShowHeartAction(_ sender: Any) {
>        let path = UIBezierPath()
>        
>        path.m(to: getPoint(10, 6))
>            .curve(to: getPoint(10, 3), controlPoint1: getPoint(8, 5), controlPoint2: getPoint(8, 3))
>            .curve(to: getPoint(14, 6), controlPoint1: getPoint(11, 3), controlPoint2: getPoint(13, 5))
>            .curve(to: getPoint(10, 9), controlPoint1: getPoint(13, 7), controlPoint2: getPoint(11, 9))
>            .curve(to: getPoint(10, 6), controlPoint1: getPoint(8, 9), controlPoint2: getPoint(8, 7))
>        
>        let layer = CAShapeLayer()
>        layer.path = path.cgPath
>        layer.strokeEnd = 0
>        layer.strokeColor = UIColor.black.cgColor
>        layer.lineWidth = 3
>        layer.fillColor = UIColor.clear.cgColor
>        
>        let animation = setAnimation()
>        layer.add(animation, forKey: "ani")
>        
>        self.dotView.layer.addSublayer(layer)
>    }
>    
>    func setAnimation() -> CAAnimationGroup {
>        let duration: TimeInterval = 5
>        
>        let animation = CABasicAnimation(keyPath: "strokeEnd")
>        animation.toValue = 1
>        animation.duration = duration
>        animation.fillMode = kCAFillModeForwards
>        animation.repeatCount = .infinity
>        animation.isRemovedOnCompletion = false
>        
>        let animation2 = CABasicAnimation(keyPath: "fillColor")
>        animation2.fromValue = UIColor.clear.cgColor
>        animation2.toValue = UIColor.red.cgColor
>        animation2.duration = duration
>        animation2.fillMode = kCAFillModeForwards
>        animation2.repeatCount = .infinity
>        animation2.isRemovedOnCompletion = false
>        
>        let group = CAAnimationGroup()
>        group.animations = [animation, animation2]
>        group.duration = duration
>        group.fillMode = kCAFillModeForwards
>        group.repeatCount = .infinity
>        group.isRemovedOnCompletion = false
>        
>        return group
>    }
>    
>    func getPoint(_ row: Int, _ col: Int) -> CGPoint {
>        return self.dotPattern.get(row, col)
>    }
>    
>    override func didReceiveMemoryWarning() {
>        super.didReceiveMemoryWarning()
>        // Dispose of any resources that can be recreated.
>    }
>}</code></pre>
> ![HeartExample](https://github.com/swieeft/DotPattern-UIBezierPath/blob/master/md-Resource/HeartExemple.gif)

* * *

### 5. 설치방법
> 준비중입니다...

* * *

### 6. 라이센스 
    위 라이브러리는 MIT 라이센스를 사용합니다.
