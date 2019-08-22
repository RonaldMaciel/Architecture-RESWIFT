//
//  NowPlayingState.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 16/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//
import ReSwift

struct NowPlayingState: StateType {
    var movies: [Movie]?
    var collectionState: DataState
    var posters: [String: Data?]?
    var error: Error?
}

enum DataState {
    case loading
    case done
    case error
}
