//
//  MainViewController.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import UIKit
import ReSwift

class MainViewController: UIViewController {

    // Outlets
    // @
    @IBOutlet weak var nowPlayingCollection: UICollectionView!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingCollection.delegate = self
        nowPlayingCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //
    }
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! NowPlayingCollectionViewCell
        cell.hatingLabel.text = "4.0"
        cell.movieTitleLabel.text = "LalaLand"
        return cell
    }
    
}


extension MainViewController: StoreSubscriber {
    func newState(state: NowPlayingState) {
        switch state.movies {
        case .loading:
            print("a")
        case .done:
            print("b")
        case .networkError:
            print("c")
        }
    }
    
}


