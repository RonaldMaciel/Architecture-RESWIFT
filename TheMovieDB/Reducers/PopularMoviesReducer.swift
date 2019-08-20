//
//  PopularMoviesReducer.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import ReSwift

func popularMoviesReducer(action: Action, state: PopularMoviesState?) -> PopularMoviesState {
    var state = state ?? PopularMoviesState(table: .loading, tableState: state!.tableState, movies: state!.movies)
    return state
}
