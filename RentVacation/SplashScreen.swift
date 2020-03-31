//
//  SplashScreen.swift
//  RentVacation
//
//  Created by Vera Svet on 2/27/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//
import UIKit

final class SplashScreen: UIViewController {
    struct RentVacation: Shape {
      var percent: Double
      
      // 1
      func path(in rect: CGRect) -> Path {
        let end = percent * 360
        var p = Path()

        // 2
        p.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
                 radius: rect.size.width/2,
                 startAngle: Angle(degrees: 0),
                 endAngle: Angle(degrees: end),
                 clockwise: false)
        
        return p.animation(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
      }
      // 3
      var animatableData: Double {
        get { return percent }
        set { percent = newValue }
      }
    }
}
