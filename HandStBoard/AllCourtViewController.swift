//
//  ViewController.swift
//  HandStBoard
//
//  Created by 木村勉 on 2020/06/14.
//  Copyright © 2020 木村勉. All rights reserved.
//
import UIKit
import CoreGraphics
import ReplayKit

//ラベルの定義
//赤の選手
var players1:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]

//青の選手
var players2:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]

//ボール
var ball:UILabel?



class AllCourtViewController:UIViewController,UIGestureRecognizerDelegate{
    
//    let recorder = RPScreenRecorder.shared()
//    var iconImageView = UIImageView()
    
    //
    var flag:Bool = false
    @IBOutlet weak var mysegment: UISegmentedControl!
    @IBOutlet var drawView: DrawView!
    
    //回らないように画面を固定
    override var shouldAutorotate: Bool{
        get{
            return false
        }
    }

    //ポートレイトで固定
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            return.portrait
        }
    }
    
    //コートの描画
    func courtLine(_ rect:CGRect){
        
        //6mラインの弧の中心
        let sP_startX = rect.maxX*0.425
        let sP_endX = rect.maxX*0.575
        let sP_startY = rect.maxY*0.15
        let sP_endY =  rect.maxY*0.85
        
        //7mラインの始点と終点の定義
        let seven_start_x = rect.width*0.475
        let seven_end_x = rect.width*0.525
        let seven_start_y = rect.height*0.175
        let seven_end_y = rect.height*0.825
        
        //9ラインの太さ
        let ninemeter_line = rect.width/20
        
        //ラインの太さ
        let line_width = rect.width/60
    
        //センターライン
        let centerPath = UIBezierPath()
        centerPath.move(to: CGPoint(x: rect.minX,y: rect.maxY/2))
        centerPath.addLine(to:CGPoint(x: rect.maxX, y: rect.maxY/2))
        centerPath.close()
        centerPath.lineWidth = line_width
        UIColor.black.setStroke()
        centerPath.stroke()
        
        //上側の6mライン(弧以外の部分）
        let sixmeterPath_center1 = UIBezierPath()
        sixmeterPath_center1.move(to: CGPoint(x: sP_startX, y: sP_startY))
        sixmeterPath_center1.addLine(to: CGPoint(x: sP_endX, y: sP_startY))
        sixmeterPath_center1.close()
        sixmeterPath_center1.lineWidth = line_width
        UIColor.black.setStroke()
        sixmeterPath_center1.stroke()
        
        //下側の6mライン(弧以外の部分）
         let sixmeterPath_center2 = UIBezierPath()
         sixmeterPath_center2.move(to: CGPoint(x: sP_startX, y: sP_endY))
         sixmeterPath_center2.addLine(to: CGPoint(x: sP_endX, y: sP_endY))
         sixmeterPath_center2.close()
         sixmeterPath_center2.lineWidth = line_width
         UIColor.black.setStroke()
         sixmeterPath_center2.stroke()
        
        //上側6mライン　右側の弧
        let right_arc1 = UIBezierPath(arcCenter: CGPoint(x: sP_endX, y: rect.minY), radius: rect.width*0.3, startAngle: 0, endAngle: CGFloat(Double.pi)/2, clockwise: true)
        let color = UIColor.black
        color.setStroke()
        right_arc1.lineWidth = line_width
        right_arc1.stroke()
        
        //上側の6mライン 左側の弧
        let left_arc1 = UIBezierPath(arcCenter: CGPoint(x: sP_startX, y: rect.minY), radius: rect.width*0.3, startAngle: 0, endAngle: CGFloat(Double.pi)/2, clockwise: false)
        color.setStroke()
        left_arc1.lineWidth = line_width
        left_arc1.stroke()
        
        //下側の6mライン　左側の弧
        let left_arc2 = UIBezierPath(arcCenter: CGPoint(x: sP_startX, y: rect.maxY), radius: rect.width*0.3, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi)*3/2, clockwise: true)
        color.setStroke()
        left_arc2.lineWidth = line_width
        left_arc2.stroke()

        //下側の6mライン 右側の弧
        let right_arc2 = UIBezierPath(arcCenter: CGPoint(x: sP_endX, y: rect.maxY), radius: rect.width*0.3, startAngle:CGFloat(Double.pi)*3/2,endAngle: CGFloat(Double.pi)*2, clockwise: true)
        color.setStroke()
        right_arc2.lineWidth = line_width
        right_arc2.stroke()
        
        //上側の7mライン
        let seven_1 = UIBezierPath()
        seven_1.move(to: CGPoint(x: seven_start_x, y: seven_start_y))
        seven_1.addLine(to: CGPoint(x: seven_end_x, y: seven_start_y))
        color.setStroke()
        seven_1.lineWidth = line_width
        seven_1.stroke()
        
        //下側の7mライン
        let seven_2 = UIBezierPath()
        seven_2.move(to: CGPoint(x: seven_start_x, y: seven_end_y))
        seven_2.addLine(to: CGPoint(x: seven_end_x, y: seven_end_y))
        color.setStroke()
        seven_2.lineWidth = line_width
        seven_2.stroke()
        
        //上側の9mラインの右側の弧
        let ninemeter_right_arc1 = UIBezierPath(arcCenter: CGPoint(x: sP_endX, y: rect.minY), radius: rect.width*0.45, startAngle:CGFloat(Double.pi)/6, endAngle: CGFloat(Double.pi)/2, clockwise: true)
        color.setStroke()
        ninemeter_right_arc1.setLineDash([ninemeter_line,ninemeter_line], count: 2, phase: 0)
        ninemeter_right_arc1.lineWidth = line_width
        ninemeter_right_arc1.stroke()
        
        //上側の9mラインの左側の弧
        let ninemeter_left_arc1 = UIBezierPath(arcCenter: CGPoint(x: sP_startX, y: rect.minY), radius: rect.width*0.45, startAngle:CGFloat(Double.pi - Double.pi/6) , endAngle: CGFloat(Double.pi)/2, clockwise: false)
        color.setStroke()
        ninemeter_left_arc1.setLineDash([ninemeter_line,ninemeter_line], count: 2, phase: 0)
        ninemeter_left_arc1.lineWidth = line_width
        ninemeter_left_arc1.stroke()
        
        //上側　9mラインの真ん中の線
        let nine_1 = UIBezierPath();
        nine_1.move(to: CGPoint(x: seven_start_x, y: rect.height*0.225))
        nine_1.addLine(to: CGPoint(x: seven_end_x, y:rect.height*0.225))
        color.setStroke()
        nine_1.lineWidth = line_width
        nine_1.stroke()
        
        //下側　9mライン　右の弧
        let ninemeter_right_arc2 = UIBezierPath(arcCenter: CGPoint(x: sP_endX, y: rect.maxY), radius: rect.width*0.45, startAngle:CGFloat(Double.pi)*3/2,endAngle: CGFloat(Double.pi*2 - Double.pi/6), clockwise: true)
             color.setStroke()
        ninemeter_right_arc2.setLineDash([ninemeter_line,ninemeter_line], count: 2, phase: 0)
        ninemeter_right_arc2.lineWidth = line_width
        ninemeter_right_arc2.stroke()
        
        //下側　9mライン　左の弧
        let ninemeter_left_arc2 = UIBezierPath(arcCenter: CGPoint(x: sP_startX, y: rect.maxY), radius: rect.width*0.45, startAngle: CGFloat(Double.pi + Double.pi/6), endAngle: CGFloat(Double.pi)*3/2, clockwise: true)
        color.setStroke()
        ninemeter_left_arc2.setLineDash([ninemeter_line,ninemeter_line], count: 2, phase: 0)
        ninemeter_left_arc2.lineWidth = line_width
        ninemeter_left_arc2.stroke()
        
        
        //下側 9mライン 真ん中の線
         let nine_2 = UIBezierPath();
         nine_2.move(to: CGPoint(x: seven_start_x, y: rect.height*0.775))
         nine_2.addLine(to: CGPoint(x: seven_end_x, y:rect.height*0.775))
         color.setStroke()
         nine_2.lineWidth = line_width
         nine_2.stroke()
        
        //上側　ゴールの線
        let goalLine1 = UIBezierPath()
        goalLine1.move(to: CGPoint(x: rect.maxX*0.425, y: rect.minY+line_width*1.5))
        goalLine1.addLine(to: CGPoint(x: rect.maxX*0.575, y: rect.minY+line_width*1.5))
        UIColor.red.setStroke()
        goalLine1.setLineDash([rect.width/50,rect.width/50], count: 2, phase: 0)
        goalLine1.lineWidth = line_width
        goalLine1.stroke()
        
        //下側 ゴールの線
        let goalLine2 = UIBezierPath()
        goalLine2.move(to: CGPoint(x: rect.maxX*0.425, y: rect.maxY-line_width*1.5))
        goalLine2.addLine(to: CGPoint(x: rect.maxX*0.575, y: rect.maxY-line_width*1.5))
        UIColor.red.setStroke()
        goalLine2.setLineDash([rect.width/50,rect.width/50], count: 2, phase: 0)
        goalLine2.lineWidth = line_width
        goalLine2.stroke()
        
    }
    
    //この関数は何？
    func makeCourtImage(width w: CGFloat,height h:CGFloat) -> UIImage{
        
        //コートの大きさを定義
        let size = CGSize(width: w, height: h)
        
        //
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        //
        let context = UIGraphicsGetCurrentContext()
        //
        let drawRect = CGRect(x: 0, y: 0, width: w, height: h)
    
        courtLine(drawRect)
        
        let drawPath = UIBezierPath(rect: drawRect)
        
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        drawPath.lineWidth = w/30

        
        drawPath.stroke()
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()

        return image!
        
    }
    
    //クリアの関数
    @objc func clearTapped(_ sender:Any){
        //関数を実行
        drawView.clear()
    }
    
    //色を変える関数
    //機能していない
    @IBAction func colorChanged(_ sender: UIButton){
        var c:UIColor!
        switch mysegment.selectedSegmentIndex{
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
        drawView.setDrawingColor(color: c)
    }
    
    //描画を一つ前に戻す
    @objc func undoTapped(_ sender:Any){
        
        drawView.undo()
    }
    
    //ハーフコートへ移動
    @objc func goToHalfPage(_ sender:Any){
        self.performSegue(withIdentifier: "toSecond", sender: self)
    }
    
    //描画モードのを画像を切り替えるボタン
    let judgeButton = UIButton(type: .custom)
    //ボタンのイメージ参照
    let judgeButtonImage = UIImage(named: "judgeButtonImage")
    //ボタンの状態を判定する関数
    let falseButton = UIImage(named: "falseButtonImage")
    @objc func judge(_ sender:Any){
        if flag == false{
             //描画可能ボタンのイメージをセット
             judgeButton.setImage(judgeButtonImage, for: .normal)
            drawView.setBool(j: !flag)
            flag = true
        }
        else if flag == true{
            //描画不能ボタンのセット
             judgeButton.setImage(falseButton, for: .normal)
            drawView.setBool(j: !flag)
            flag = false
        }
    }
    
    //録画モードの関数(いずれ消すかな...)
//    @objc func TouchRecord(){
//           let recorder = RPScreenRecorder.shared()
//           if !recorder.isRecording{
//               recorder.startRecording { (error) in
//                   if let error = error{
//                       print(error)
//                    return
//                   }
////                guard error == nil else{
////                    print(error ?? <#default value#>)
////                    return
////                }
//               }
//           }else{
//               recorder.stopRecording { (previewVC, error) in
//                   if let previewVC = previewVC{
//                    previewVC.popoverPresentationController?.sourceView = self.view
//                       previewVC.previewControllerDelegate = self
//                       self.present(previewVC,animated: true,completion: nil)
//                   }
//                   if let error = error{
//                       print(error)
//                    return
//                   }
////                guard error == nil else{
////                    print(error)
////                    return
////                }
////                previewVC?.previewControllerDelegate = self
////                previewVC?.popoverPresentationController?.sourceView = self.view
////                self.present(previewVC!,animated: true,completion: nil)
//               }
//           }
//       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //何のフラッグ?
        flag = false
        
        //画面を常にライトモードに
        self.overrideUserInterfaceStyle = .light
        
        //画面の大きさを参照?
        let myBoundSize:CGSize = UIScreen.main.bounds.size
        
        //コートの大きさを画面の8割に設定
        //広告を入れるからこの大きさは変わるかも...
        let courtLength = myBoundSize.height*0.8
        
        //
        let boxImage = makeCourtImage(width: courtLength / 2 ,height: courtLength)
        let boxView = UIImageView(image: boxImage)
        boxView.center = view.center
        
         view?.addSubview(boxView)
        
        let gap = boxView.frame.minY - view.frame.minY
        
        let clearButton = UIButton(type: .custom)
        clearButton.frame = CGRect(x: boxView.frame.maxX - gap*0.4,y:gap/3, width: gap*0.4, height: gap*0.4)
        let picture = UIImage(named: "clearImage")
        clearButton.setImage(picture, for: .normal)
        clearButton.imageView?.contentMode = .scaleAspectFill
        clearButton.layer.masksToBounds = true
        clearButton.layer.cornerRadius = gap/15
        clearButton.addTarget(self, action: #selector(clearTapped(_:)), for: .touchDown)
        view.addSubview(clearButton)
        
        //一つ前に戻るボタン
        let undoButton = UIButton(type: .custom)
        undoButton.frame = CGRect(x: boxView.frame.maxX - gap*0.4*2.5,y:gap/3, width: gap*0.4, height: gap*0.4)
        let undoPicture = UIImage(named: "undoButtonImage")
        undoButton.setImage(undoPicture, for: .normal)
        undoButton.imageView?.contentMode = .scaleAspectFill
        undoButton.layer.masksToBounds = true
        undoButton.layer.cornerRadius = gap/15
        undoButton.addTarget(self, action: #selector(undoTapped(_:)), for: .touchDown)
        view.addSubview(undoButton)
        
        //ハーフコートに行くボタン
        let ToHalfCourtButton = UIButton(type: .custom)
        ToHalfCourtButton.frame = CGRect(x:boxView.frame.minX,y:gap/3, width: gap*0.8, height: gap*0.4)
        let half_court_Image = UIImage(named: "halfCourtImage")
        ToHalfCourtButton.setImage(half_court_Image, for: .normal)
        ToHalfCourtButton.imageView?.contentMode = .scaleAspectFill
        ToHalfCourtButton.layer.masksToBounds = true
        ToHalfCourtButton.layer.cornerRadius = gap/15
        ToHalfCourtButton.addTarget(self, action: #selector(goToHalfPage(_:)), for: .touchDown)
        view.addSubview(ToHalfCourtButton)
        
        
        judgeButton.frame = CGRect(x: boxView.frame.maxX - gap*0.4*4,y:gap/3, width: gap*0.4, height: gap*0.4)
        //        let picture = UIImage(named: "playerImage")
        judgeButton.backgroundColor = UIColor.black
        judgeButton.setImage(falseButton, for: .normal)
        judgeButton.imageView?.contentMode = .scaleAspectFill
        judgeButton.adjustsImageWhenHighlighted = true
        judgeButton.layer.masksToBounds = true
        judgeButton.layer.cornerRadius = gap/15
        judgeButton.addTarget(self, action: #selector(judge(_:)), for: .touchDown)
        view.addSubview(judgeButton)
        
        //パレットボタン
        let AllCourtPalleteButton = UIButton(type: .custom)
        AllCourtPalleteButton.frame = CGRect(x: boxView.frame.maxX - gap*0.4 * 5.5, y: gap/3, width: gap*0.4, height: gap*0.4)
        let HalfPalletPicture = UIImage(named: "undoImage2")
        AllCourtPalleteButton.setImage(HalfPalletPicture, for: .normal)
        AllCourtPalleteButton.imageView?.contentMode = .scaleAspectFill
        AllCourtPalleteButton.layer.masksToBounds = true
        AllCourtPalleteButton.layer.cornerRadius = gap/15
        //AllCourtEraserButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        view.addSubview(AllCourtPalleteButton)
                
//        消しゴムのボタン
        let AllCourtEraserButton = UIButton(type: .custom)
        AllCourtEraserButton.frame = CGRect(x: boxView.frame.maxX - gap*0.4*7, y: gap/3, width: gap*0.4, height: gap*0.4)
        let erasePicture = UIImage(named: "undoImage2")
        AllCourtEraserButton.setImage(erasePicture, for: .normal)
        AllCourtEraserButton.imageView?.contentMode = .scaleAspectFill
        AllCourtEraserButton.layer.masksToBounds = true
                AllCourtEraserButton.layer.cornerRadius = gap/15
        //AllCourtEraserButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        view.addSubview(AllCourtEraserButton)
        
        //レコードボタン（必要ないのでいづれ消す）
//        let startRecordButton = UIButton()
//        startRecordButton.setTitle("Start", for: .normal)
//        startRecordButton.backgroundColor = .lightGray
//        startRecordButton.frame = CGRect(x: self.view.frame.width/3, y: self.view.frame.height/5, width: 50, height: 50)
//        startRecordButton.addTarget(self, action: #selector(TouchRecord), for: .touchDown)
//        view.addSubview(startRecordButton)
//
        let player1_num = 7
        let angle = Double.pi
        let trans1 = CGAffineTransform(rotationAngle: CGFloat(angle))
        
        let radius = courtLength/23
        let offset = radius/2
        players1[0] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.5 - offset, y: boxView.frame.height*0.13 + offset, width: radius, height: radius))
        players1[1] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.1 - offset, y: boxView.frame.height*0.15 + offset, width: radius, height: radius))
        players1[2] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.2 - offset, y: boxView.frame.height*0.25 + offset, width: radius, height: radius))
        players1[3] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.4 - offset, y: boxView.frame.height*0.3 + offset, width: radius, height: radius))
        players1[4] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.6 - offset, y: boxView.frame.height*0.3 + offset, width: radius, height: radius))
        players1[5] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.8 - offset, y: boxView.frame.height*0.25 + offset, width: radius, height: radius))
        players1[6] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.9 - offset, y: boxView.frame.height*0.15 + offset, width: radius, height: radius))
        for index in 0..<player1_num{
            players1[index].text = "\(index+1)"
            players1[index].textColor = UIColor.white
            players1[index].textAlignment = NSTextAlignment.center
            players1[index].backgroundColor = UIColor.red
            players1[index].transform = trans1
            players1[index].layer.masksToBounds = true
            players1[index].layer.cornerRadius = courtLength/46
            players1[index].isUserInteractionEnabled = true
            view.addSubview(players1[index])
            
        }
        for player1 in players1{
            let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(_:)))
            player1.addGestureRecognizer(panGesture)
   
        }
        
        //playerの数
        let player2_num = 7
        //プレイヤーの基準を画面の一番上に設定
        let player2_offset = boxView.frame.minY
        players2[0] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.5 - offset, y: boxView.frame.height*0.9 + offset + player2_offset, width: radius, height: radius))
        players2[6] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.1 - offset, y: boxView.frame.height*0.9 + offset + player2_offset, width: radius, height: radius))
        players2[5] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.2 - offset, y: boxView.frame.height*0.8 + offset + player2_offset, width: radius, height: radius))
        players2[4] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.4 - offset, y: boxView.frame.height*0.75 + offset + player2_offset, width: radius, height: radius))
        players2[3] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.6 - offset, y: boxView.frame.height*0.75 + offset + player2_offset, width: radius, height: radius))
        players2[2] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.8 - offset, y: boxView.frame.height*0.8 + offset + player2_offset, width: radius, height: radius))
        players2[1] = UILabel(frame: CGRect(x:boxView.frame.minX + boxView.frame.width*0.9 - offset, y: boxView.frame.height*0.9 + offset + player2_offset, width: radius, height: radius))
        
        for index in 0..<player2_num{
            players2[index].text = "\(index+1)"
            players2[index].textColor = UIColor.white
            players2[index].textAlignment = NSTextAlignment.center
            players2[index].backgroundColor = UIColor.blue
            players2[index].layer.masksToBounds = true
            players2[index].layer.cornerRadius = courtLength/46
            players2[index].isUserInteractionEnabled = true
                    
            view.addSubview(players2[index])
            }
        for player2 in players2{
            let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(_:)))
            player2.addGestureRecognizer(panGesture)
        }
        
        //ボールの半径
        let ballRadius = courtLength/25
        let ballOffset = ballRadius/2
        ball = UILabel(frame: CGRect(x:view.frame.width/2 - ballOffset, y:view.frame.height/2 - ballOffset, width: ballRadius, height:ballRadius))
        ball!.backgroundColor = #colorLiteral(red: 1, green: 0.819552958, blue: 0, alpha: 1)
        ball!.layer.masksToBounds = true
        ball!.layer.cornerRadius = courtLength/50
        ball!.isUserInteractionEnabled = true
        view.addSubview(ball!)
        
        let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(_:)))
        panGesture.delegate = self
        
        ball!.addGestureRecognizer(panGesture)
        
    }
    
    @objc func panGestureHandler(_ pan:UIPanGestureRecognizer){
        let point = pan.location(in: view)
        let draggedView = pan.view!
        draggedView.center = point
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
//    @objc func TouchRecord(_ sender:Any){
//        if !recorder.isRecording{
//            recorder.startRecording { (error) in
//                if let error = error{
//                    print(error)
//                }
//            }
//        }else{
//            recorder.stopRecording { (previewVC, error) in
//                if let previewVC = previewVC{
//                    previewVC.previewControllerDelegate = self
//                    self.present(previewVC,animated: true,completion: nil)
//                }
//                if let error = error{
//                    print(error)
//                }
//            }
//        }
//    }
    
//    @objc func startRecording(){
//        recorder.startRecording { (error) in
//            if let error = error{
//                print(error)
//            }
////            guard error == nil else{
////                print("Failed to start recording")
////                return
////            }
////            self.butotn.texure = imageNamed
//        }
//    }
//
//    @objc func stopRecording(){
//        recorder.stopRecording { (previewVC, error) in
//            if let previewVC = previewVC{
//                self.present(previewVC,animated: true,completion: nil)
//            }
//            if let error = error{
//                print(error)
//            }
//        }
//    }
   
}

extension AllCourtViewController:RPPreviewViewControllerDelegate{
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        previewController.popoverPresentationController?.sourceView = self.view
        dismiss(animated: true, completion: nil)
        
    }
}

