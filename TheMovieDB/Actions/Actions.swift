//
//  Actions.swift
//  TheMovieDB
//
//  Created by Ronald Maciel on 20/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import Foundation
import ReSwift

struct GetPopular: Action {}

struct GetPlayingNow: Action {}

struct GetDetails: Action {}


struct SetPopular: Action {
    let movies: [Movie]
    let posters: [String: Data?]
    
}

struct SetPlayingNow: Action {
    let movies: [Movie]
    let posters: [String: Data?]
    
}

struct SetDetails: Action {
    let id: Int
    let details: Details
}

struct ErrorAction: Action {
    let error: Error
}

