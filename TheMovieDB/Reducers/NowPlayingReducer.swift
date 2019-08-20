//
//  NowPlayingReducer.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import ReSwift

func nowPlayingReducer(action: Action, state: NowPlayingState?) -> NowPlayingState {
    var state = state ?? NowPlayingState(movies: .loading, collectionState: (state?.collectionState)!)
    return state
}
