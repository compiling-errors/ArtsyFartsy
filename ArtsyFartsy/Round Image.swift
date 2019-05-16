//
//  Round Image.swift
//  ArtsyFartsy
//
//  Created by Randy Lloyd on 5/16/19.
//  Copyright © 2019 MICHAEL BENTON. All rights reserved.
//

import UIKit

class Round_Image: UIImageView
{
    @IBInspectable var cornerRadius: CGFloat = 3.0
    {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
