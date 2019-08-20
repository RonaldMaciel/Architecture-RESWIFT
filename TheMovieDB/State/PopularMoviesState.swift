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
    var table: DataState
    var tableState: DataState
    var movies: [MoviesStruct]
}
