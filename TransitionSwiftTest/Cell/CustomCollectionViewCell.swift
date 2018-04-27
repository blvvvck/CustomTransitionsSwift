//
//  CustomCollectionViewCell.swift
//  TransitionSwiftTest
//
//  Created by BLVCK on 16/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var songImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func prepareCell(with song: Song) {
        songImageView.image = song.artwork
    }
    
}
