//
//  ContentView.swift
//  PieChart
//
//  Created by Franco on 17/1/20.
//  Copyright © 2020 Franco. All rights reserved.
//

import SwiftUI

func randomColor() -> UIColor {
    [UIColor.systemRed, UIColor.systemBlue, UIColor.systemPink, UIColor.systemTeal, UIColor.systemGreen, UIColor.systemIndigo].randomElement()!
}

extension FloatingPoint {
    func degreesToRad() -> Self {
        return self * .pi / 180
    }

    func radToDegrees() -> Self {
        return self * 180 / .pi
    }
}

func pointForCenter(_ center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
    return CGPoint(
        x: center.x + radius * cos(angle),
        y: center.y + radius * sin(angle)
    )
}

final class PieChartView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let radius = min(rect.size.width / 2, rect.size.height / 2)
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(0).degreesToRad(),
            endAngle: CGFloat(30).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(30).degreesToRad(),
            endAngle: CGFloat(60).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(60).degreesToRad(),
            endAngle: CGFloat(90).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(90).degreesToRad(),
            endAngle: CGFloat(120).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(120).degreesToRad(),
            endAngle: CGFloat(150).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(150).degreesToRad(),
            endAngle: CGFloat(180).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(180).degreesToRad(),
            endAngle: CGFloat(210).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(210).degreesToRad(),
            endAngle: CGFloat(240).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(240).degreesToRad(),
            endAngle: CGFloat(270).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(270).degreesToRad(),
            endAngle: CGFloat(300).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(300).degreesToRad(),
            endAngle: CGFloat(330).degreesToRad()
        )
        
        drawSlice(
            context: context,
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: CGFloat(330).degreesToRad(),
            endAngle: CGFloat(360).degreesToRad()
        )
        
        drawIcon(context: context, image: UIImage(named: "mail")!, center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: CGFloat(0).degreesToRad(), endAngle: CGFloat(30).degreesToRad())
        
    }
    
    func drawIcon(
        context: CGContext,
        image: UIImage,
        center: CGPoint,
        radius: CGFloat,
        startAngle: CGFloat,
        endAngle: CGFloat
    ) {
        let size = CGSize(width: 24, height: 24)
        UIGraphicsBeginImageContext(size)
        
        let midAngle = (startAngle + endAngle) / 2
        let midRadius = (radius + (radius * 0.5)) / 2
        let midOfSlice = pointForCenter(center, radius: midRadius, angle: midAngle)
        
        let origin = CGPoint(x: midOfSlice.x - size.width / 2, y: midOfSlice.y - size.height / 2)
        
        context.draw(image.cgImage!, in: CGRect(origin: origin, size: size))
        
        UIGraphicsEndImageContext()
    }
    
    func drawSlice(
        context: CGContext,
        center: CGPoint,
        radius: CGFloat,
        startAngle: CGFloat,
        endAngle: CGFloat
    ) {
        context.saveGState()
        
        context.setFillColor(randomColor().cgColor)
        
        let innerRadius = radius * 0.5
        
        let arcStartPointX = center.x + radius * cos(startAngle)
        let arcStartPointY = center.y + radius * sin(startAngle)

        let path = CGMutablePath()

        path.move(to: CGPoint(x: arcStartPointX, y: arcStartPointY))
        
        path.addRelativeArc(center: center, radius: radius, startAngle: startAngle, delta: endAngle-startAngle)
        
        let innerArcStartPointX = center.x + innerRadius * cos(endAngle)
        let innerArcStartPointY = center.y + innerRadius * sin(endAngle)
        
        path.addLine(to: CGPoint(x: innerArcStartPointX, y: innerArcStartPointY))
        
        path.addRelativeArc(center: center, radius: innerRadius, startAngle: endAngle, delta: -endAngle+startAngle)
        
        path.closeSubpath()

        context.beginPath()
        context.addPath(path)
        context.fillPath(using: .evenOdd)
        
        context.restoreGState()
    }
}

final class MyVC: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = PieChartView()
        v.backgroundColor = .systemGray
        view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        v.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        v.heightAnchor.constraint(equalTo: v.safeAreaLayoutGuide.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct VCWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = MyVC
    func makeUIViewController(context: UIViewControllerRepresentableContext<VCWrapper>) -> VCWrapper.UIViewControllerType {
        MyVC()
    }
    
    func updateUIViewController(_ uiViewController: VCWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<VCWrapper>) {
        uiViewController.view.layoutIfNeeded()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VCWrapper()
                .previewDevice(
                    PreviewDevice(rawValue: "iPhone 11 Pro Max")
                )
        }
    }
}
