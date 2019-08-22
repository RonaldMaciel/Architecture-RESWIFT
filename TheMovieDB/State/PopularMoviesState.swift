//
//  PopularMoviesState.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import Foundation
import ReSwift

struct PopularMoviesState: StateType {
    var tableState: DataState
    var movies: [Movie]?
    var error: Error?
    var posters: [String: Data?]?
    
    
}
