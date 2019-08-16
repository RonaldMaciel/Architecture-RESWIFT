//
//  AppReducer.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(nowPlayingState: nowPlayingReducer(action: action, state: state?.nowPlayingState), popularMoviesState: popularMoviesReducer(action: action, state: state?.popularMoviesState))
    
    
}
