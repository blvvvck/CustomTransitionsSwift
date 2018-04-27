//
//  ViewController.swift
//  TransitionSwiftTest
//
//  Created by BLVCK on 16/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var artworkImageView: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentSong = song else { return }
        artworkImageView.image = currentSong.artwork
        makeUI()
    }

    func makeUI() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeController))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    @objc func closeController() {
        navigationController?.popViewController(animated: true)
    }
}

