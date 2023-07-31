//  PlayStopButtonSize.swift
//  Neobis_iOS_StopWatch
//  Created by Askar Soronbekov

import UIKit

class PlayStopButtonSize: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 25
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                // Change the button color when it's pressed (highlighted)
                backgroundColor = UIColor.systemYellow
                tintColor = UIColor.label
            } else {
                // Restore the button's original color when it's released (touch up inside)
                backgroundColor = UIColor.label
                tintColor = UIColor.systemYellow
            }
        }
    }
}
