//
//  SongsCollectionViewController.swift
//  TransitionSwiftTest
//
//  Created by BLVCK on 16/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let customCellNibName = "CustomCollectionViewCell"

class SongsCollectionViewController: UICollectionViewController {

    var selectedFrame: CGRect!
    var selectedSong: Song!
    var customInteractor: CustomInteractor!
    
    private var songs: [Song] = [Song(title: "Dolor", artist: "Pharaoh", artwork: UIImage(named: "dolor")!), Song(title: "Phosphor", artist: "Pharaoh", artwork: UIImage(named: "phosphor")!), Song(title: "Pink Phloyd", artist: "Pharaoh", artwork: UIImage(named: "pinkPhloyd")!) ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        songs.append(contentsOf: songs)
        self.navigationController?.delegate = self
        registerCell()
    }
    
    func registerCell() {
        let nib = UINib(nibName: customCellNibName, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView!.frame.width / 3, height: self.collectionView!.frame.width / 3)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.prepareCell(with: songs[indexPath.row])
 
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSong = songs[indexPath.row]
        let theAttributes: UICollectionViewLayoutAttributes = collectionView.layoutAttributesForItem(at: indexPath)!
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        performSegue(withIdentifier: "Song", sender: selectedSong)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Song") {
            let songVC = segue.destination as! ViewController
            songVC.song = sender as? Song
        }
    }
}

extension SongsCollectionViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let frame = self.selectedFrame else { return nil }
        guard let song = self.selectedSong else { return nil }
        
        switch operation {
        case .push:
            self.customInteractor = CustomInteractor(attachTo: toVC as! ViewController)
            return CustomAnimator(duration: 2, isPresenting: true, originFrame: frame, image: song.artwork)
        default:
            return CustomAnimator(duration: TimeInterval(UINavigationControllerHideShowBarDuration), isPresenting: false, originFrame: frame, image: song.artwork)

        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = customInteractor else { return nil }
        return ci.transitionInProgress ? customInteractor : nil
    }
    

}

