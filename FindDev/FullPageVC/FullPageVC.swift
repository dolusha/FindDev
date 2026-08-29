//
//  FullPageVC.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
import UIKit

class FullPageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(colors: [UIColor(hex: "480A54"), UIColor(hex: "AD57CE")])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
