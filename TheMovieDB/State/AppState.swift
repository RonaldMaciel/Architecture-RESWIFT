//
//  AppState.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    let nowPlayingState: NowPlayingState
    let popularMoviesState: PopularMoviesState
}


