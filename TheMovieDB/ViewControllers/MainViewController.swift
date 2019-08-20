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
    
    var cache = NSCache<NSString, AnyObject>()
    
    @IBOutlet weak var tableView: UITableView!
    
    var moviesNowPlaying: [MoviesStruct] = []
    var moviesPopular: [MoviesStruct] = []
    var image = UIImage()
     
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    
        Network.nowPlaying() { result, error in
            if let error = error {
                print("error")
                return
            }
            
            guard let result = result else { return }
            
            
            if let imageObject = self.cache.object(forKey: "/keym7MPn1icW1wWfzMnW3HeuzWU.jpg") {
                print("Cache hit!")
            }
            //            else {
            //                Network.moviePoster(imagePath: result[0].posterPath!, completionHandler: { (data, path) in
            //                    DispatchQueue.main.async { [weak self] in
            //                        guard let self = self else { return }
            //                        guard let data = data else { return }
            //                        guard let path = path else { return }
            //
            //                        self.image = UIImage(data: data)!
            //                        // self.imageView.image = image
            //                        self.cache.setObject(self.image, forKey: NSString(string: path))
            //
            //                    }
            //                })
            //            }
            
            for movie in result {
                var auxMovie = MoviesStruct(image: "", title: "", rating: 0, description: "", genres: [])
                
                auxMovie.image = movie.posterPath!
                
                print("Isso é a imagem")
                print("\(movie.posterPath!)")
                
                Network.movieDetails(id: movie.id!, completionHandler: { details, error in
                    if let error = error {
                        print("error")
                        return
                    }
                    
                    guard let details = details else { return }
                    print("\n\(details.originalTitle!)")
                    auxMovie.title = details.originalTitle!
                    auxMovie.rating = details.voteAverage!
                    auxMovie.description = details.overview ?? ""
                    for genre in details.genres! {
                        auxMovie.genres.append(genre.name ?? "")
                        print(auxMovie.genres)
                    }
                    print(self.moviesNowPlaying)
                    
                    self.moviesNowPlaying.append(auxMovie)
                })
            }
            
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
        
        
        Network.popular(){ result, error in
            if let error = error {
                print("error")
                return
            }
            
            guard let result = result else { return }
            
            
            if let imageObject = self.cache.object(forKey: "/keym7MPn1icW1wWfzMnW3HeuzWU.jpg") {
                print("Cache hit!")
            }
            //            else {
            //                Network.moviePoster(imagePath: result[0].posterPath!, completionHandler: { (data, path) in
            //                    DispatchQueue.main.async { [weak self] in
            //                        guard let self = self else { return }
            //                        guard let data = data else { return }
            //                        guard let path = path else { return }
            //
            //                        self.image = UIImage(data: data)!
            //                        // self.imageView.image = image
            //                        self.cache.setObject(self.image, forKey: NSString(string: path))
            //
            //                    }
            //                })
            //            }
            
            for movie in result {
                var auxMovie = MoviesStruct(image: "", title: "", rating: 0, description: "", genres: [])
                
                auxMovie.image = movie.posterPath!
                
                print("Isso é a imagem")
                print("\(movie.posterPath!)")
                
                Network.movieDetails(id: movie.id!, completionHandler: { details, error in
                    if let error = error {
                        print("error")
                        return
                    }
                    
                    guard let details = details else { return }
//                    print("\n\(details.originalTitle)")
                    auxMovie.title = details.originalTitle ?? ""
                    auxMovie.rating = details.voteAverage ?? -1
                    auxMovie.description = details.overview ?? ""
                    for genre in details.genres ?? [] {
                        auxMovie.genres.append(genre.name ?? "")
//                        print(auxMovie.genres)
                    }
                    
                    self.moviesPopular.append(auxMovie)
                    
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCollection" {
            guard let destination = segue.destination as? NowPlayingFullCollectionViewController else {return}
            destination.nowPlayingMovies = moviesNowPlaying
        } else if segue.identifier == "goToDetail"{
            guard let destination = segue.destination as? DetailViewController else {return}
            let aux = sender as! MoviesStruct
            destination.descript = aux.description
            destination.movieTitle = aux.title
            destination.genre = aux.genres
            destination.image = aux.image
            destination.rating = aux.rating
            
        }
        
    }
    @IBAction func seeAllAction(_ sender: UIButton) {
        
    print("Alo galera de piao")
       performSegue(withIdentifier: "goToCollection", sender: nil)
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesPopular.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = moviesPopular[indexPath.row]
        self.navigationController?.isNavigationBarHidden = false

        performSegue(withIdentifier: "goToDetail", sender: cell)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:"NowPlayingTableViewCell", for: indexPath) as! NowPlayingTableViewCell
            cell.nowPlayingCollection.delegate = self
            cell.nowPlayingCollection.dataSource = self
            cell.nowPlayingCollection.reloadData()
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier:"PopularMoviesTitle", for: indexPath)
            cell.isUserInteractionEnabled = false
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier:"PopularTableViewCell", for: indexPath) as! PopularMovieTableViewCell
            cell.movieTitleLabel.text = moviesPopular[indexPath.row].title
            cell.movieRatingLabel.text = "\(moviesPopular[indexPath.row].rating)"
            cell.movieDescriptionLabel.text = moviesPopular[indexPath.row].description
            cell.genre = moviesPopular[indexPath.row].genres
            
            Network.getImageAPI(imagePath: moviesPopular[indexPath.row].image, completion: { image in
                cell.movieImageView.image = image
            })
            
            
            return cell
        }
        
        
    }
    
    
}
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if moviesNowPlaying.count <= 5{
            return moviesNowPlaying.count
        } else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = moviesNowPlaying[indexPath.row]
        self.navigationController?.isNavigationBarHidden = false

        performSegue(withIdentifier: "goToDetail", sender: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as! NowPlayingCollectionViewCell
        cell.ratingLabel.text = "\(moviesNowPlaying[indexPath.row].rating)"
        cell.movieTitleLabel.text = moviesNowPlaying[indexPath.row].title
        cell.movieDescription = moviesNowPlaying[indexPath.row].description
        cell.genre = moviesNowPlaying[indexPath.row].genres
        Network.getImageAPI(imagePath: moviesNowPlaying[indexPath.row].image, completion: { image in
            cell.movieImageView.image = image
        })
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


