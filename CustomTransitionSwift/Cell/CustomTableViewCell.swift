//
//  CustomTableViewCell.swift
//  CustomTransitionSwift
//
//  Created by Ildar Zalyalov on 16.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
    func didSelectImageView(_ imageView: UIImageView)
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    weak var delegate: CustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureFirst = UITapGestureRecognizer(target: self, action: #selector(didSelectFirstImageView))
        let tapGestureSecond = UITapGestureRecognizer(target: self, action: #selector(didSelectSecondImageView))
        
        firstImageView.addGestureRecognizer(tapGestureFirst)
        secondImageView.addGestureRecognizer(tapGestureSecond)
    }
    
    func prepareCell(with delegate: CustomCellDelegate?) {
        self.delegate = delegate
    }
    
    @objc
    func didSelectFirstImageView() {
        delegate?.didSelectImageView(firstImageView)
    }
    
    @objc
    func didSelectSecondImageView() {
        delegate?.didSelectImageView(secondImageView)
    }
}
