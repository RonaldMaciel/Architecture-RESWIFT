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
    
    var movies: [MoviesStruct] = []
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
                    
                    for genre in details.genres! {
                        auxMovie.genres.append(genre.name ?? "")
                        print(auxMovie.genres)
                    }
                    print(self.movies)
                    
                    self.movies.append(auxMovie)
                })
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getNowPlaying() {
        
        
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:"NowPlayingTableViewCell", for: indexPath) as! NowPlayingTableViewCell
            cell.nowPlayingCollection.delegate = self
            cell.nowPlayingCollection.dataSource = self
            cell.nowPlayingCollection.reloadData()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:"PopularTableViewCell", for: indexPath) as! PopularMovieTableViewCell
            return cell
        }
        
        
    }
    
    
}
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as! NowPlayingCollectionViewCell
        cell.ratingLabel.text = "\(movies[indexPath.row].rating)"
        
        cell.movieTitleLabel.text = movies[indexPath.row].title
        Network.getImageAPI(imagePath: movies[indexPath.row].image, completion: { image in
            cell.movieImageView.image = image
        })
        
        return cell
    }

    
    
}

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            let data = try! Data(contentsOf: url)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            
        }
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


