//
//  TableViewController.swift
//  CustomTransitionSwift
//
//  Created by Ildar Zalyalov on 16.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, CustomCellDelegate, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:"reuseIdentifier")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CustomTableViewCell

        cell.prepareCell(with: self)
        return cell
    }
    

    //MARK: - CustomCellDelegate
  
    func didSelectImageView(_ imageView: UIImageView) {
        performSegue(withIdentifier: "segue", sender: imageView)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue", let destination = segue.destination as? ViewController, let imageView = sender as? UIImageView {
            
            destination.image = imageView.image
            destination.transitioningDelegate = self
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPopTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPopDismissTransition()
    }
}
