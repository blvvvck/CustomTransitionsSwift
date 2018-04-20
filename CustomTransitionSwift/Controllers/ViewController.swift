//
//  ViewController.swift
//  CustomTransitionSwift
//
//  Created by Ildar Zalyalov on 16.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView(with: image)
    }

    
    func setupImageView(with image: UIImage) {
        imageView.image = image
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

