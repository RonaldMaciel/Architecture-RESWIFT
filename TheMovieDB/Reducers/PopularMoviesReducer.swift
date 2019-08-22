//
//  PopularMoviesReducer.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import ReSwift

func popularMoviesReducer(action: Action, state: PopularMoviesState?) -> PopularMoviesState {
    var state = state ?? PopularMoviesState(tableState: .loading, movies: nil, error: nil, posters: nil)
    
    switch action {
    case _ as GetPlayingNow:
        state.tableState = .loading
        state.error = nil
    case let action as SetPlayingNow:
        state.movies = action.movies
        state.posters = action.posters
        state.tableState = .done
    case let action as ErrorAction:
        state.tableState = .error
        state.error = action.error
    default:
        break
    }
    return state
}
