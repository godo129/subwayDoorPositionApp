//
//  StopButton.swift
//  subwayDoorPositionApp
//
//  Created by hong on 2022/04/11.
//

import UIKit

class StopButton: UIButton {

    var color: UIColor?
    var name: String?
    
    init(color: UIColor, name: String, frame: CGRect) {
        
        self.color = color
        self.name = name
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2
        self.setTitle(name, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
