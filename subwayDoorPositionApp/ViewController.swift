//
//  ViewController.swift
//  subwayDoorPositionApp
//
//  Created by hong on 2022/04/04.
//

import UIKit

class ViewController: UIViewController {

    
    let getSubwayLineInfoButton: UIButton = {
        let getSubwayLineInfoButton = UIButton()
        getSubwayLineInfoButton.layer.masksToBounds = true
        getSubwayLineInfoButton.layer.cornerRadius = 50
        getSubwayLineInfoButton.backgroundColor = .orange
        return getSubwayLineInfoButton
    }()
    
    let getYourTravelInfoButton: UIButton = {
        let getYourTravelinfoButton = UIButton()
        getYourTravelinfoButton.layer.masksToBounds = true
        getYourTravelinfoButton.layer.cornerRadius = 50
        getYourTravelinfoButton.backgroundColor = .yellow
        return getYourTravelinfoButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(getSubwayLineInfoButton)
        self.view.addSubview(getYourTravelInfoButton)
        
        getSubwayLineInfoButton.addTarget(self, action: #selector(getSubwayLineInfoButtonTapped), for: .touchUpInside)
    }
    
    @objc func getSubwayLineInfoButtonTapped() {
        
        guard let view = self.storyboard?.instantiateViewController(withIdentifier: "travelInfoView") else {return}
        self.present(view, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        getSubwayLineInfoButton.frame = CGRect(x: self.view.frame.maxX/3,
                                               y: self.view.frame.maxY/3,
                                               width: self.view.frame.maxX/2,
                                               height: self.view.frame.maxY/3)
        getYourTravelInfoButton.frame = CGRect(x: getSubwayLineInfoButton.frame.origin.x + self.view.frame.maxX/10,
                                               y: getSubwayLineInfoButton.frame.origin.y + self.view.frame.maxY/10,
                                               width: getSubwayLineInfoButton.frame.width,
                                               height: getSubwayLineInfoButton.frame.height)
    }


}

