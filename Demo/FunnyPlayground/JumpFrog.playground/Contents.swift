//: A UIKit based Playground for presenting user interface
// 2020年春节疫情期间，被困在老家，闲时配小侄子们玩我们小时候玩的青蛙跳井益智游戏，随后，有Playground实现了一个简单人机模式的青蛙跳井小游戏。

import UIKit
import PlaygroundSupport
import CoreGraphics

class MapView : UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
         
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
         
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
         
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x:drawingRect.minX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.maxY))
        path.addLine(to:CGPoint(x:drawingRect.minX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.minX, y:drawingRect.maxY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.minY))

        //添加路径到图形上下文
        context.addPath(path)
        
        let circle = CGPath.init(roundedRect: CGRect(x: (drawingRect.maxX-60)*0.5, y: drawingRect.maxY-60-20, width: 60, height: 60), cornerWidth: 30, cornerHeight: 30, transform: nil)
        context.addPath(circle)
         
        //设置笔触颜色
        context.setStrokeColor(UIColor.black.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
         
        //绘制路径
        context.strokePath()
        
    }
}

//当前位置 0：未知 1：左上 2：右上 3：中间 4：左下 5：右下
enum FrogPosition: Int {
    case unknow
    case topLeft
    case topRight
    case center
    case bottomLeft
    case bottomRight
}


class Frog : UIButton {
    var isSystemFrog = false //是否是系统青蛙
    var isCurrentFrog : Bool? {
        get {
            return self.layer.borderColor == UIColor.red.cgColor
        }
        set {
            self.layer.borderColor = newValue == true ? UIColor.red.cgColor : UIColor.clear.cgColor
        }
    }
    
    var currentPosition: FrogPosition = .unknow
    
    init(position: FrogPosition, isSys: Bool) {
        super.init(frame: .zero)

        self.currentPosition = position
        self.titleLabel?.font = .systemFont(ofSize: 35)
        self.setTitle("🐸", for: .normal)
        if isSys {
            self.isSystemFrog = true
            self.backgroundColor = .black
        } else {
            self.backgroundColor = .brown
        }
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}




class MyViewController : UIViewController {
    let locations = [
        CGRect.zero,
        CGRect(x: 27.5-25, y: 103-25, width: 50, height: 50),
        CGRect(x: 375-27.5-25, y: 103-25, width: 50, height: 50),
        CGRect(x: 30+160-25, y: 103+160-25, width: 50, height: 50),
        CGRect(x: 27.5-25, y: 103+320-3-25, width: 50, height: 50),
        CGRect(x: 375-27.5-25, y: 103+320-25, width: 50, height: 50)
    ]
    
    var emptyPosition : FrogPosition = .center
    var isAnimating = false
    
    let systemFrog1 = Frog(position: .topLeft, isSys: true)
    let systemFrog2 = Frog(position: .topRight, isSys: true)
    let userFrog1 = Frog(position: .bottomLeft, isSys: false)
    let userFrog2 = Frog(position: .bottomRight, isSys: false)
    var currentMoveFrog : Frog?
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "青蛙跳井"
        label.frame = CGRect(x: 20, y: 40, width: 375-40, height: 20)
        view.addSubview(label)
        
        let mp = MapView()
        mp.backgroundColor = .white
        mp.frame = CGRect(x: 27.5, y: 100, width: 320, height: 320)
        view.addSubview(mp)
        
        systemFrog1.frame = locations[1]
        view.addSubview(systemFrog1)
        systemFrog2.frame = locations[2]
        view.addSubview(systemFrog2)
        
        userFrog1.frame = locations[4]
        userFrog2.frame = locations[5]
        userFrog1.addTarget(self, action: #selector(didClickFrog), for: .touchUpInside)
        view.addSubview(userFrog1)
        userFrog2.addTarget(self, action: #selector(didClickFrog), for: .touchUpInside)
        view.addSubview(userFrog2)

        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("重置", for: .normal)
        btn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        btn.frame = CGRect(x: 147, y: 480, width: 80, height: 45)
        view.addSubview(btn)
        
        self.view = view
    }
    
    @objc func didClickFrog(frog: Frog) {
        if isAnimating {
            return
        }
              
        let loc = frog.currentPosition
        
        let moveAble = self.moveAble(frog: frog)
        if moveAble {
            isAnimating = true
            UIView.animate(withDuration: 0.25, animations: {
                frog.frame = self.locations[self.emptyPosition.rawValue]
            }) { (finished) in
                if self.currentMoveFrog != nil {
                    self.currentMoveFrog!.isCurrentFrog = false
                }
                frog.isCurrentFrog = true
                self.currentMoveFrog = frog
                
                frog.currentPosition = self.emptyPosition
                self.emptyPosition = loc
                
                self.sysetemFrogJump()
            }
        } else {
            self.isAnimating = false
        }
    }
    
    func moveAble(frog: Frog) -> Bool {
        /*
        loc=1，可以走2，3，4
        loc=2，可以走1，3，5
        loc=3，可以走1，2，4，5
        loc=4，可以走1，3
        loc=5，可以走2，3
        */
        var moveAble = false
        switch frog.currentPosition {
            case .topLeft:
                moveAble = self.emptyPosition == FrogPosition.topRight || self.emptyPosition == FrogPosition.center || self.emptyPosition == FrogPosition.bottomLeft
            case .topRight:
                moveAble = self.emptyPosition == FrogPosition.topLeft || self.emptyPosition == FrogPosition.center || self.emptyPosition == FrogPosition.bottomRight
            case .center:
                moveAble = self.emptyPosition == FrogPosition.topLeft || self.emptyPosition == FrogPosition.topRight || self.emptyPosition == FrogPosition.bottomLeft || self.emptyPosition == FrogPosition.bottomRight
            case .bottomLeft:
                moveAble = self.emptyPosition == FrogPosition.topLeft || self.emptyPosition == FrogPosition.center
            case .bottomRight:
                moveAble = self.emptyPosition == FrogPosition.topRight || self.emptyPosition == FrogPosition.center
            default:
                moveAble = false
        }
        return moveAble
    }
    
    @objc func reset() {
        systemFrog1.currentPosition = .topLeft
        systemFrog2.currentPosition = .topRight
        userFrog1.currentPosition = .bottomLeft
        userFrog2.currentPosition = .bottomRight
        emptyPosition = .center
        systemFrog1.frame = locations[1]
        systemFrog2.frame = locations[2]
        userFrog1.frame = locations[4]
        userFrog2.frame = locations[5]
        isAnimating = false
        
        self.currentMoveFrog = nil
        systemFrog1.isCurrentFrog = false
        systemFrog2.isCurrentFrog = false
        userFrog1.isCurrentFrog = false
        userFrog2.isCurrentFrog = false
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController.init(title: "提示", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func sysetemFrogJump() {
        let systemMoveAble1 = self.moveAble(frog: systemFrog1)
        let systemMoveAble2 = self.moveAble(frog: systemFrog2)
        
        //被围死
        if systemMoveAble1 == false && systemMoveAble2 == false {
            self.isAnimating = false
            //机器输了
            self.showAlert(msg: "👍👏你赢了")
            return
        }
        
        //只有一个青蛙可跳
        var sysFrog: Frog?
        if systemMoveAble1 == true && systemMoveAble2 == false {
            sysFrog = self.systemFrog1
        } else if systemMoveAble2 == true && systemMoveAble1 == false {
            sysFrog = systemFrog2
        }
        
        if sysFrog != nil {
            self.isAnimating = true

            let loc = sysFrog!.currentPosition
            
            UIView.animate(withDuration: 0.25, animations: {
                sysFrog!.frame = self.locations[self.emptyPosition.rawValue]
            }) { (finished) in
                if self.currentMoveFrog != nil {
                    self.currentMoveFrog!.isCurrentFrog = false
                }
                sysFrog!.isCurrentFrog = true
                self.currentMoveFrog = sysFrog!
                
                sysFrog!.currentPosition = self.emptyPosition
                self.emptyPosition = loc
                self.isAnimating = false
                
                //判断输赢
                let userMoveAble1 = self.moveAble(frog: self.userFrog1)
                let userMoveAble2 = self.moveAble(frog: self.userFrog2)
                if userMoveAble1 == false && userMoveAble2 == false {
                    self.showAlert(msg: "👎💪你输了")
                }
            }
            
            return
        }
        
        //两只青蛙都能跳  预演
        
        let backupEmptyLocation = self.emptyPosition
        let backupFrog1Loc = self.systemFrog1.currentPosition
        
        //预演第一只青蛙跳
        let loc1 = systemFrog1.currentPosition
        self.systemFrog1.currentPosition = self.emptyPosition
        self.emptyPosition = loc1
        
        //判断输赢
        var userMoveAble1 = self.moveAble(frog: self.userFrog1)
        var userMoveAble2 = self.moveAble(frog: self.userFrog2)
        //预演完重置状态
        self.systemFrog1.currentPosition = backupFrog1Loc
        self.emptyPosition = backupEmptyLocation
        if userMoveAble1 == false && userMoveAble2 == false {
            //第一只青蛙跳后赢
            self.isAnimating = true

            let loc = systemFrog1.currentPosition
            
            UIView.animate(withDuration: 0.25, animations: {
                self.systemFrog1.frame = self.locations[self.emptyPosition.rawValue]
            }) { (finished) in
                if self.currentMoveFrog != nil {
                    self.currentMoveFrog!.isCurrentFrog = false
                }
                self.systemFrog1.isCurrentFrog = true
                self.currentMoveFrog = self.systemFrog1
                
                self.systemFrog1.currentPosition = self.emptyPosition
                self.emptyPosition = loc
                self.isAnimating = false
                
                //判断输赢
                self.showAlert(msg: "👎💪你输了")
            }
            
            return
        }
        
        //预演第二只青蛙跳
        let backupFrog2Loc = self.systemFrog2.currentPosition
        
        let loc2 = systemFrog2.currentPosition
        self.systemFrog2.currentPosition = self.emptyPosition
        self.emptyPosition = loc2
        
        //判断输赢
        userMoveAble1 = self.moveAble(frog: self.userFrog1)
        userMoveAble2 = self.moveAble(frog: self.userFrog2)
        //预演完重置状态
        self.systemFrog2.currentPosition = backupFrog2Loc
        self.emptyPosition = backupEmptyLocation
        if userMoveAble1 == false && userMoveAble2 == false {
            //走第二只青蛙
            self.isAnimating = true

            let loc = systemFrog2.currentPosition
            
            UIView.animate(withDuration: 0.25, animations: {
                self.systemFrog2.frame = self.locations[self.emptyPosition.rawValue]
            }) { (finished) in
                if self.currentMoveFrog != nil {
                    self.currentMoveFrog!.isCurrentFrog = false
                }
                self.systemFrog2.isCurrentFrog = true
                self.currentMoveFrog = self.systemFrog2
                
                self.systemFrog2.currentPosition = self.emptyPosition
                self.emptyPosition = loc
                self.isAnimating = false
                
                //判断输赢
                self.showAlert(msg: "👎💪你输了")
            }
            
            return
        }
   
        //随机走一只
        let r = Int(arc4random() % 2) //[0,1]
        if r == 0 {
            //走第一只青蛙
//            print("走这里\(self.emptyLocation)")
            self.isAnimating = true

            let loc = systemFrog1.currentPosition
            
            UIView.animate(withDuration: 0.25, animations: {
                self.systemFrog1.frame = self.locations[self.emptyPosition.rawValue]
            }) { (finished) in
                if self.currentMoveFrog != nil {
                    self.currentMoveFrog!.isCurrentFrog = false
                }
                self.systemFrog1.isCurrentFrog = true
                self.currentMoveFrog = self.systemFrog1
                
                self.systemFrog1.currentPosition = self.emptyPosition
                self.emptyPosition = loc
                self.isAnimating = false
            }
        } else {
            //走第二只青蛙
//            print("走这里\(self.emptyLocation)")
            self.isAnimating = true

            let loc = systemFrog2.currentPosition
            
            UIView.animate(withDuration: 0.25, animations: {
                self.systemFrog2.frame = self.locations[self.emptyPosition.rawValue]
            }) { (finished) in
                if self.currentMoveFrog != nil {
                    self.currentMoveFrog!.isCurrentFrog = false
                }
                self.systemFrog2.isCurrentFrog = true
                self.currentMoveFrog = self.systemFrog2
                
                self.systemFrog2.currentPosition = self.emptyPosition
                self.emptyPosition = loc
                self.isAnimating = false
            }
        }
        
    }

}



// Present the view controller in the Live View window
let vc = MyViewController()
vc.preferredContentSize = CGSize(width: 375, height: 667)//修改展示尺寸
PlaygroundPage.current.liveView = vc
