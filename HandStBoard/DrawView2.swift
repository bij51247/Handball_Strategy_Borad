//
//  DrawView2.swift
//  HandStBoard
//
//  Created by 木村勉 on 2020/06/14.
//  Copyright © 2020 木村勉. All rights reserved.
//

import UIKit
import  CoreGraphics

class DrawView2: UIView {
   struct Drawing {
         var color = UIColor.black
         var points = [CGPoint]()
     }
     
     var currentDrawing: Drawing?
     var finishedDrawings = [Drawing]()
     var currentColor = UIColor.black
     var current_judge = false
     
     override func draw(_ rect: CGRect) {
         for drawing in finishedDrawings {
             drawing.color.setStroke()
             stroke(drawing: drawing)
         }
         
         if let drawing = currentDrawing {
             drawing.color.setStroke()
             stroke(drawing: drawing)
         }
     }
     
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if current_judge == false{
             return
         }
         
         let touch = touches.first!
         let location = touch.location(in: self)
         
         for index1 in 0...6{
             
             if players3[index1].frame.contains(location){
                 return
             }
         }
         
         for index2 in 0...6{
             if players4[index2].frame.contains(location){
                 return
             }
             
         }
         if ball2!.frame.contains(location){
             return
         }
         
         currentDrawing = Drawing()
         currentDrawing?.color = currentColor
         currentDrawing?.points.append(location)
         setNeedsDisplay()
     }
     
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         if current_judge == false{
             return
         }
         let touch = touches.first!
         let location = touch.location(in: self)
         
         for index1 in 0...6{
             
             if players3[index1].frame.contains(location){
                 return
             }
         }
         
         for index2 in 0...6{
             if players4[index2].frame.contains(location){
                 return
             }
         }
         
         if ball2!.frame.contains(location){
             return
         }
         
         currentDrawing?.points.append(location)
         
         setNeedsDisplay()
     }
     
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         if current_judge == false{
             return
         }
         if var drawing = currentDrawing {
             let touch = touches.first!
             let location = touch.location(in: self)
             drawing.points.append(location)
             finishedDrawings.append(drawing)
         }
         currentDrawing = nil
         setNeedsDisplay()
     }
     
     func clear() {
         finishedDrawings.removeAll()
         setNeedsDisplay()
     }
     
     func undo() {
         if finishedDrawings.count == 0 {
             return
         }
         finishedDrawings.remove(at: finishedDrawings.count - 1)
         setNeedsDisplay()
     }
     
     func setDrawingColor(color : UIColor){
         currentColor = color
     }
     
     func stroke(drawing: Drawing) {
         let path = UIBezierPath()
         path.lineWidth = 5
         path.lineCapStyle = .round
         path.lineJoinStyle = .round
         
         let begin = drawing.points[0];
         path.move(to: begin)
         
         if drawing.points.count > 1 {
             for i in 1...(drawing.points.count - 1) {
                 let end = drawing.points[i]
                 path.addLine(to: end)
             }
         }
         path.stroke()
     }
     
     func setBool(j : Bool){
         current_judge = j
     }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

