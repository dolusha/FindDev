//
//  SearchVC + ColorGradient.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
import UIKit

extension UIView {
    func applyGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        let existingLayer = layer.sublayers?.first(where: { $0.name == "gradientLayer" }) as? CAGradientLayer
        
        let gradientLayer = existingLayer ?? CAGradientLayer()
        gradientLayer.name = "gradientLayer" 
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        if existingLayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
