//
//  AllCourtControllerViewController.swift
//  HandStBoard
//
//  Created by 木村勉 on 2020/06/14.
//  Copyright © 2020 木村勉. All rights reserved.
//
import UIKit
import CoreGraphics

var players3:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
var players4:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
var ball2:UILabel?

class AllCourtControllerViewController: UIViewController,UIGestureRecognizerDelegate{
    var flag2:Bool = false
    @IBOutlet weak var mysegment2:UISegmentedControl!
    @IBOutlet  var drawView2: DrawView2!
    
    
    override var shouldAutorotate: Bool{
        get{
            return false
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            return .portrait
        }
    }
    
    func halfCourtLine(_ rect:CGRect){
        let line_Width  = rect.width/60
        let point1 = rect.height*0.425
        let point2 = rect.height*0.575
        let arc_radius = rect.height*0.3
        let line_Color = UIColor.black
        let one_meter = rect.height/20
        let nine_meter = rect.maxY*0.45
        
        let up_arc = UIBezierPath(arcCenter: CGPoint(x: rect.minX, y: point1), radius: arc_radius, startAngle: CGFloat(Double.pi*3/2), endAngle: CGFloat(Double.pi*2), clockwise: true)
        line_Color.setStroke()
        up_arc.lineWidth = line_Width
        up_arc.stroke()
        
        let down_arc = UIBezierPath(arcCenter: CGPoint(x: rect.minX, y: point2), radius: arc_radius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        line_Color.setStroke()
        down_arc.lineWidth = line_Width
        down_arc.stroke()
        
        let six_center_line = UIBezierPath()
        six_center_line.move(to: CGPoint(x: rect.height*0.3, y: point1 - 0.5))
        six_center_line.addLine(to: CGPoint(x: rect.height*0.3, y: point2 + 0.5))
        six_center_line.close()
        six_center_line.lineWidth = line_Width
        line_Color.setStroke()
        six_center_line.stroke()
        
        let nine_up_arc = UIBezierPath(arcCenter: CGPoint(x: rect.minX, y: point1), radius: nine_meter, startAngle: CGFloat(Double.pi*5/3), endAngle: CGFloat(Double.pi*2), clockwise: true)
        line_Color.setStroke()
        nine_up_arc.setLineDash([one_meter,one_meter], count: 2, phase: 0)
        nine_up_arc.lineWidth = line_Width
        nine_up_arc.stroke()
        
        let nine_down_arc = UIBezierPath(arcCenter: CGPoint(x: rect.minX, y: point2), radius: nine_meter, startAngle: 0, endAngle: CGFloat(Double.pi/3), clockwise: true)
        nine_down_arc.setLineDash([one_meter,one_meter], count: 2, phase: 0)
        line_Color.setStroke()
        nine_down_arc.lineWidth = line_Width
        nine_down_arc.stroke()
        
        let seven_center_line = UIBezierPath()
        seven_center_line.move(to: CGPoint(x: rect.height*0.35, y: rect.height*0.475))
        seven_center_line.addLine(to: CGPoint(x: rect.height*0.35, y: rect.height*0.525))
        seven_center_line.close()
        seven_center_line.lineWidth = line_Width
        line_Color.setStroke()
        seven_center_line.stroke()
        
        let nine_center_line = UIBezierPath()
        nine_center_line.move(to: CGPoint(x: rect.height*0.45, y: rect.height*0.475))
        nine_center_line.addLine(to: CGPoint(x: rect.height*0.45, y: rect.height*0.525))
        nine_center_line.close()
        nine_center_line.lineWidth = line_Width
        line_Color.setStroke()
        nine_center_line.stroke()

        let goal_line = UIBezierPath()
        goal_line.move(to: CGPoint(x: rect.minX + line_Width*1.5, y: point1))
        goal_line.addLine(to: CGPoint(x: rect.minX+line_Width*1.5, y: point2))
        UIColor.red.setStroke()
        goal_line.setLineDash([rect.height/50,rect.height/50], count: 2, phase: 0)
        goal_line.lineWidth = line_Width
        goal_line.stroke()
    }
    
    func makeAllCourtImage(width w:CGFloat, height h:CGFloat)->UIImage{
        let size2 = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(size2, false, 1.0)
        
        let context2 = UIGraphicsGetCurrentContext()
        let drawRect2 = CGRect(x: 0, y: 0, width: w, height: h)
        
        halfCourtLine(drawRect2)
        
        let drawPath2 = UIBezierPath(rect: drawRect2)
        
        context2?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        drawPath2.lineWidth = w/30
        
        drawPath2.stroke()
        
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        
        return image2!
    }
    
    @objc func clearTapped(_ sender:Any){
        drawView2.clear()
    }
    @IBAction func colorChanged(_ sender: UIButton){
        var c:UIColor!
        switch mysegment2.selectedSegmentIndex{
        case 0:
            c = UIColor.black
            break
        case 1:
            c = UIColor.red
            break
        case 2:
            c = UIColor.blue
        default:
            break
        }
        drawView2.setDrawingColor(color: c)
    }
    @objc func undoTapped(_ sender:Any){
        
        drawView2.undo()
    }
    
    @objc func goToHalfPage(_ sender:Any){
        self.performSegue(withIdentifier: "toSecond", sender: self)
    }
    
    let judgeButton2 = UIButton(type: .custom)
    let judgeButtonImage = UIImage(named: "judgeImage")
    let falseButton2 = UIImage(named: "falseImage2")
    @objc func judge(_ sender:Any){
        if flag2 == false{
             judgeButton2.setImage(judgeButtonImage, for: .normal)
            
            drawView2.setBool(j: !flag2)
            flag2 = true
        }
        else if flag2 == true{
             judgeButton2.setImage(falseButton2, for: .normal)
            
            drawView2.setBool(j: !flag2)
            flag2 = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        flag2 = false
        
        let myBoundSize2:CGSize = UIScreen.main.bounds.size
        let courtLength2 = myBoundSize2.width
        let boxImage2 = makeAllCourtImage(width: courtLength2*0.9, height: courtLength2)
        
        let boxView2 = UIImageView(image: boxImage2)
        boxView2.center = view.center
        view?.addSubview(boxView2)

        let offset_line = boxView2.frame.minY - view.frame.minY
    
        let box_size = (boxView2.frame.maxX - boxView2.frame.minX)/10
        
        //ハーフコートに行くボタン
        let ToHalfCourtButton = UIButton(type: .custom)
        //ここだけminXが基準になっていることに注意
        ToHalfCourtButton.frame = CGRect(x: boxView2.frame.minX, y: offset_line/2 - box_size/2, width: box_size*2, height: box_size)
        let picture = UIImage(named: "AllCourtImage")
        ToHalfCourtButton.setImage(picture, for: .normal)
        ToHalfCourtButton.imageView?.contentMode = .scaleAspectFill
        ToHalfCourtButton.layer.masksToBounds = true
        ToHalfCourtButton.layer.cornerRadius = box_size / 8
        ToHalfCourtButton.addTarget(self, action: #selector(goToAllPage(_:)), for: .touchDown)
        view.addSubview(ToHalfCourtButton)
        
        //メモをクリアにするボタン
        let clearButton2 = UIButton(type: .custom)
        clearButton2.frame = CGRect(x: boxView2.frame.maxX - box_size, y: offset_line/2 - box_size/2, width: box_size, height: box_size)
        let picture1 = UIImage(named: "clearImage2")
        clearButton2.setImage(picture1, for: .normal)
        clearButton2.imageView?.contentMode = .scaleAspectFill
        clearButton2.layer.masksToBounds = true
        clearButton2.layer.cornerRadius = box_size / 8
        clearButton2.addTarget(self, action: #selector(clearTapped(_:)), for: .touchDown)
        view.addSubview(clearButton2)
        
        let undoButton2 = UIButton(type: .custom)
        undoButton2.frame = CGRect(x: boxView2.frame.maxX - box_size*2.5, y: offset_line/2 - box_size/2, width: box_size, height: box_size)
        let picture2 = UIImage(named: "undoImage2")
        undoButton2.setImage(picture2, for: .normal)
        undoButton2.imageView?.contentMode = .scaleAspectFill
        undoButton2.layer.masksToBounds = true
        undoButton2.layer.cornerRadius = box_size / 8
        undoButton2.addTarget(self, action: #selector(undoTapped(_:)), for: .touchDown)
        view.addSubview(undoButton2)
        
//        let judgeButton2 = UIButton(type: .custom)
        judgeButton2.frame = CGRect(x: boxView2.frame.maxX - box_size*4, y: offset_line/2 - box_size/2, width: box_size, height: box_size)
        let picture3 = UIImage(named: "falseImage2")
        judgeButton2.setImage(picture3, for: .normal)
        judgeButton2.imageView?.contentMode = .scaleAspectFill
        judgeButton2.layer.masksToBounds = true
        judgeButton2.layer.cornerRadius = box_size / 8
        judgeButton2.addTarget(self, action: #selector(judge(_:)), for: .touchDown)
        view.addSubview(judgeButton2)
        
        let palleteButton = UIButton(type: .custom)
        palleteButton.frame = CGRect(x: boxView2.frame.maxX - box_size * 5.5, y: offset_line/2 - box_size/2, width: box_size, height: box_size)
        let palletPicture = UIImage(named: "undoImage2")
        palleteButton.setImage(palletPicture, for: .normal)
        palleteButton.imageView?.contentMode = .scaleAspectFill
        palleteButton.layer.masksToBounds = true
        palleteButton.layer.cornerRadius = box_size/8
        //eraserButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        view.addSubview(palleteButton)
        
        //消しゴムのボタン
        let eraserButton = UIButton(type: .custom)
        eraserButton.frame = CGRect(x: boxView2.frame.maxX - box_size*7, y: offset_line/2 - box_size/2, width: box_size, height: box_size)
        let erasePicture = UIImage(named: "undoImage2")
        eraserButton.setImage(erasePicture, for: .normal)
        eraserButton.imageView?.contentMode = .scaleAspectFill
        eraserButton.layer.masksToBounds = true
        eraserButton.layer.cornerRadius = box_size/8
//        eraserButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        view.addSubview(eraserButton)
        
        let player3_num = 7
        let angle2 = Double.pi*3/2
        let angle3 = Double.pi/2
        let trans = CGAffineTransform(rotationAngle: CGFloat(angle2))
        let trans2 = CGAffineTransform(rotationAngle: CGFloat(angle3))
        
        let player_radius = courtLength2/16
        let offset2 = player_radius/2
        let xoffset = boxView2.frame.minX
        let yoffset = boxView2.frame.minY
        
        players3[0] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.35, y: yoffset + boxView2.frame.height/2 - offset2, width: player_radius, height: player_radius))
        
        players3[1] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.05, y: yoffset + boxView2.frame.height*0.9, width: player_radius, height: player_radius))
        
        players3[2] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.75, y: yoffset + boxView2.frame.height*0.9 - offset2, width: player_radius, height: player_radius))
        
        players3[3] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.75, y: yoffset + boxView2.frame.height/2 - offset2, width: player_radius, height: player_radius))
        
        players3[4] = UILabel(frame: CGRect(x:xoffset + boxView2.frame.width*0.75, y: yoffset +  boxView2.frame.height*0.1 - offset2, width: player_radius, height: player_radius))
        
        players3[5] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.05, y: yoffset + boxView2.frame.height*0.06 - offset2, width: player_radius, height: player_radius))
        
        players3[6] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width - offset2*2.5, y: yoffset + boxView2.frame.height + offset2*1.5, width: player_radius, height: player_radius))
        
        for index in 0..<player3_num{
            players3[index].adjustsFontSizeToFitWidth = true
//            players3[0] = UILabel(frame: CGRect(x:boxView2.frame.minX + boxView2.frame.width*0.5 - offset2, y: boxView2.frame.height*0.13 + offset2, width: player_radius, height: player_radius))
            players3[index].text = "\(index+1)"
            players3[index].textColor = UIColor.white
            players3[index].textAlignment = NSTextAlignment.center
            players3[index].backgroundColor = UIColor.red
            players3[index].transform = trans
            players3[index].layer.masksToBounds = true
            players3[index].layer.cornerRadius = courtLength2/32
            players3[index].isUserInteractionEnabled = true
            view.addSubview(players3[index])
            
        }
        
        for player3 in players3{
            let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(_:)))
            player3.addGestureRecognizer(panGesture)
            
        }
        
        players4[0] = UILabel(frame: CGRect(x: xoffset + offset2, y: yoffset + boxView2.frame.height/2 - offset2, width: player_radius, height: player_radius))
        
        players4[1] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.15, y: yoffset + boxView2.frame.height*0.88 - offset2, width: player_radius, height: player_radius))
        
        players4[2] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.28, y: yoffset + boxView2.frame.height*0.77 - offset2, width: player_radius, height: player_radius))
        
        players4[3] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.35, y: yoffset + boxView2.frame.height/2 + offset2*2, width: player_radius, height: player_radius))
        
        players4[4] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.35, y: yoffset + boxView2.frame.height/2 - offset2*4, width: player_radius, height: player_radius))
        
        players4[5] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.28, y: yoffset + boxView2.frame.height*0.22 - offset2, width: player_radius, height: player_radius))
        
        players4[6] = UILabel(frame: CGRect(x: xoffset + boxView2.frame.width*0.15, y: yoffset + boxView2.frame.height*0.12 - offset2, width: player_radius, height: player_radius))
        
        for index in 0..<player3_num{
            players4[index].adjustsFontSizeToFitWidth = true
            //            players3[0] = UILabel(frame: CGRect(x:boxView2.frame.minX + boxView2.frame.width*0.5 - offset2, y: boxView2.frame.height*0.13 + offset2, width: player_radius, height: player_radius))
            players4[index].text = "\(index+1)"
            players4[index].textColor = UIColor.white
            players4[index].textAlignment = NSTextAlignment.center
            players4[index].backgroundColor = UIColor.blue
            players4[index].transform = trans2
            players4[index].layer.masksToBounds = true
            players4[index].layer.cornerRadius = courtLength2/32
            players4[index].isUserInteractionEnabled = true
            view.addSubview(players4[index])
            
        }
        
        for player4 in players4{
            let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(_:)))
            player4.addGestureRecognizer(panGesture)
        }
        
        let ballRadius2 = player_radius*0.9
        let ballOffset2 = ballRadius2/2
        
        ball2 = UILabel(frame: CGRect(x:view.frame.width/2 + ballOffset2*4, y:view.frame.height/2 - ballOffset2, width: ballRadius2, height:ballRadius2))
        ball2!.backgroundColor = #colorLiteral(red: 1, green: 0.819552958, blue: 0, alpha: 1)
        ball2!.layer.masksToBounds = true
        ball2!.layer.cornerRadius = ballRadius2/2
        ball2!.isUserInteractionEnabled = true
        view.addSubview(ball2!)
        
        let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(_:)))
        panGesture.delegate = self
        
        ball2!.addGestureRecognizer(panGesture)
//        boxView2.center = view.center
//        view?.addSubview(boxView2)
        
        // Do any additional setup after loading the view.
    }
    @objc func panGestureHandler(_ pan:UIPanGestureRecognizer){
        let point = pan.location(in: view)
        let draggedView = pan.view!
        draggedView.center = point
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
       @objc func goToAllPage(_ sender:Any){
         self.performSegue(withIdentifier: "toAll", sender: self)
     }
    
//    @objc func startRecoring(){
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
