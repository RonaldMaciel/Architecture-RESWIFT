//
//  NowPlayingReducer.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import ReSwift

func nowPlayingReducer(action: Action, state: NowPlayingState?) -> NowPlayingState {
    var state = state ?? NowPlayingState(movies: nil, collectionState: .loading, posters: nil, error: nil)
    
    switch action {
    case _ as GetPlayingNow:
        state.collectionState = .loading
        state.error = nil
    case let action as SetPlayingNow:
        state.movies = action.movies
        state.posters = action.posters
        state.collectionState = .done
    case let action as ErrorAction:
        state.collectionState = .error
        state.error = action.error
    default:
        break
    }
    return state
}
