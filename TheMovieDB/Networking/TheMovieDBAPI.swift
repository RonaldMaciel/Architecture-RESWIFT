// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import UIKit

private let apiKey = "1edfceba775463029aa5c3bb03d50769"

class Network {
    
    static func nowPlaying(completionHandler: @escaping ([Result]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            
            let decoder = JSONDecoder()
            let resp = try? decoder.decode(NowPlaying.self, from: data!)
            completionHandler(resp?.results, nil)
        }
        task.resume()
    }
    
    
    static func popular(completionHandler: @escaping ([Result]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            } else if let data = data{
                let decoder = JSONDecoder()
                let resp = try?  decoder.decode(Popular.self, from: data)
                completionHandler(resp?.results, nil)
            }
            
        }
        task.resume()
    }
    
    static func movieDetails(id: Int, completionHandler: @escaping (Details?, Error?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            } else if let data = data {
                let decoder = JSONDecoder()
                let resp = try? decoder.decode(Details.self, from: data)
                completionHandler(resp, nil)
            }
        }
        task.resume()
    }
    
    
    static func moviePoster(imagePath: String, completioHandler: @escaping (Data?, String?) -> Void) {
        let urlBase = "https://image.tmdb.org/t/p/w500"
        let finalURL = urlBase + imagePath
        
        if let url = URL(string: finalURL) {
            DispatchQueue.global(qos: .background).async {
                if let data =  try? Data(contentsOf: url) {
                    completioHandler(data, imagePath)
                } else {
                    completioHandler(nil, nil)
                }
            }
        } else {
            completioHandler(nil, nil)
        }
    }
    
}






// MARK: - NowPlaying
struct NowPlaying: Codable {
    let results: [Result]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

// MARK: - Popular
struct Popular: Codable {
    let page, totalResults, totalPages: Int?
    let results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}


// MARK: - Details
struct Details: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage, voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}


// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}


// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}


// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639_1, name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}


// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Result
struct Result: Codable{
    let voteCount: Int?
    let id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id = "id"
        case video = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
}
