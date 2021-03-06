//
//  MenuViewController.swift
//  Project3_WordGame
//
//  Created by Christian Purdy on 3/5/18.
//  Copyright © 2018 Christian Purdy. All rights reserved.
//

import UIKit

class MenuViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DatasetDelegate {
    
    var delegateID: String = UUIDVendor.vendUUID()
    private static var cellReuseIdentifier = "CollectionViewController.DatasetItemsCellIdentifier"
    private let gradient = Gradient();

    
    func datasetUpdated() {
        collectionView?.reloadData()
    }
    
    let cell = "cellID"
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.setNeedsDisplay()
        collectionView?.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        collectionView?.backgroundView = gradient
        super.viewDidLoad()
        navigationItem.title = "Active Games"
        datasetUpdated()
        let newGame = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addGame))
        navigationItem.rightBarButtonItem = newGame
        collectionView?.delegate = self
        collectionView?.dataSource = self
        Dataset.registerDelegate(self)
        collectionView?.register(GameCell.self, forCellWithReuseIdentifier: MenuViewController.cellReuseIdentifier)

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return number of Games in collection view
        return Dataset.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> GameCell {
        guard collectionView == self.collectionView, indexPath.section == 0, indexPath.row < Dataset.count
            else{
                return GameCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuViewController.cellReuseIdentifier, for: indexPath) as! GameCell
        print("INDEXPATH.ROW", indexPath.row)
        cell.label.text = "\(Dataset.getEntry(atIndex: indexPath.row).name), Score: \(Dataset.getEntry(atIndex: indexPath.row).score)"
        cell.backgroundColor = UIColor.white
        return cell
       
    }
    
    //pushes a GameViewController when a collectionview Cell is pressed
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView === self.collectionView, indexPath.section == 0, indexPath.row < Dataset.count else {
            return
        }
        let cell = Dataset.getEntry(atIndex: indexPath.row)
        navigationController?.pushViewController(GameViewController(gameModel: cell.Game), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 25, height: collectionView.frame.width/4)
    }
    
    //worker function, adds alarm console view to list of alarms
    @objc func addGame() {
        print("add game")
        let newGame = GameCell()
        Dataset.appendEntry(newGame)        
    }
    
    
    
    
}
