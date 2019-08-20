//
//  NowPlayingFullCollectionViewController.swift
//  TheMovieDB
//
//  Created by Eduardo Sarmanho on 20/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import UIKit

class NowPlayingFullCollectionViewController: UIViewController {
    var nowPlayingMovies: [MoviesStruct] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "goToDetailFromFull" {
            guard let destination = segue.destination as? DetailViewController else { return }
            let auxilar = sender as! MoviesStruct
//            destination.descript = sender.description
            destination.descript = auxilar.description
            destination.movieTitle = auxilar.title
            destination.genre = auxilar.genres
            destination.rating = auxilar.rating
            destination.image = auxilar.image
//            destination.events = sender as? CellType
//            //            destination.isFavorite = cellSelectedIsFavorite
//            //            destination.teste = isFavorite as? Bool
//            //            cellSelectedIsFavorite = false
        }
        
    }
}


extension NowPlayingFullCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countLabel.text = "Showing \(nowPlayingMovies.count) results"
        return nowPlayingMovies.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingFull", for: indexPath) as! NowPlayingFullCollectionViewCell
        cell.ratingLabel.text = "\(nowPlayingMovies[indexPath.row].rating)"
        cell.titleMovieLabel.text = nowPlayingMovies[indexPath.row].title
        cell.genre = nowPlayingMovies[indexPath.row].genres
        cell.movieDescription = nowPlayingMovies[indexPath.row].description

        Network.getImageAPI(imagePath: nowPlayingMovies[indexPath.row].image, completion: { image in
            cell.imageView.image = image
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = nowPlayingMovies[indexPath.row]
        self.performSegue(withIdentifier: "goToDetailFromFull", sender: cell)
    }
}
