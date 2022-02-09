//
//  CircularProgressView.swift
//  Clear Score Credit
//
//  Created by Haresh Ghatala on 9/2/22.
//

import UIKit

@IBDesignable class CircularProgressView: UIView {
    
    @IBInspectable var fillColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    /// Here 100.00% means 1.0
    @IBInspectable var progress: CGFloat = 0.0 {
        didSet {
            if progress < 0.0 {
                progress = 0.0
            } else if progress > 1.0 {
                progress = 1.0
            }
            setNeedsDisplay()
        }
    }
    
    struct Segment {
        var color: UIColor
        var value: CGFloat
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let segments = [
            Segment(color: fillColor, value: progress),
            Segment(color: .clear, value: (1.0 - progress))
        ]
        let ctx = UIGraphicsGetCurrentContext()
        let radius = min(frame.size.width, frame.size.height) * 0.5
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        let valueCount = segments.reduce(0, {$0 + $1.value})
        
        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle, with the positive angle being in an anti-clockwise direction (same as a unit circle in maths).
        var startAngle = -CGFloat.pi * 0.5
        
        UIView.animate(withDuration: 5.0, delay: 0.5, options: .curveEaseInOut, animations: {
            for segment in segments {
                ctx?.setFillColor(segment.color.cgColor)
                let endAngle = startAngle + 2 * .pi * (segment.value / valueCount)
                ctx?.move(to: viewCenter)
                ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                ctx?.fillPath()
                startAngle = endAngle
            }
        }, completion: nil)
    }
}
