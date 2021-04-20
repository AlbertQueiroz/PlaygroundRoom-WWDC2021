//
//  Canvas.swift
//  BookCore
//
//  Created by Albert Rayneer on 13/04/21.
//

import UIKit
import PlaygroundSupport

public class Canvas: UIView {
    var shapeLayer = CAShapeLayer()
    
    public var pencilColor: PencilColor = .red
    public var dottedLineLenght = 20
    public var dottedLineInterval = 14
    
    var strokeColor: UIColor {
        switch pencilColor {
        case .red:
            return .systemRed
        case . green:
            return .systemGreen
        case .blue:
            return .systemBlue
        }
    }
    
    // MARK: - Constants
    var height: CGFloat {
        frame.height
    }
    var width: CGFloat {
        frame.width
    }
    // MARK: - Random Bezier Path
    func randomPath() -> CGMutablePath {
        // Create a path
        let path = CGMutablePath()
        
        // Starting point
        path.move(to: randomPoint())
        
        // Random curves
        let numberOfCurves = Int.random(in: 0..<3)
        for _ in 0...numberOfCurves {
            path.addQuadCurve(to: randomPoint(), control: randomPoint())
        }
        
        // Ending point
        path.addQuadCurve(to: randomPoint(), control: randomPoint())
        
        return path
    }

    // MARK: - Random Point Helpers
    func randomPoint() -> CGPoint {
        let xPoint = CGFloat.random(in: 40.0..<width - 40)
        let yPoint = CGFloat.random(in: 100.0..<height - 40)
        return CGPoint(x: xPoint, y: yPoint)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(8)
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
        
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.lineDashPattern = [NSNumber(value: dottedLineLenght),
                                      NSNumber(value: dottedLineInterval)]
        shapeLayer.fillColor = .none
        shapeLayer.path = randomPath()
        layer.addSublayer(shapeLayer)
    }
    
    var lines = [[CGPoint]]()
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var drawPoints = 0
        for line in lines {
            for point in line {
                if shapeLayer.path?.contains(point) ?? true {
                    drawPoints += 1
                }
            }
        }
        
        if drawPoints > 200 {
            shapeLayer.lineDashPattern = [10, 0]
            shapeLayer.strokeColor = strokeColor.cgColor
            SoundHelper.instance.playSound(resource: "won1")
            self.isUserInteractionEnabled = false
            PlaygroundPage.current.assessmentStatus = .pass(message: "Great! You did it. Your homework is done. [Next Page](@next)")
        }
        lines = []
        setNeedsDisplay()
    }
    
}
