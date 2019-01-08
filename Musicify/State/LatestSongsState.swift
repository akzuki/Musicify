//
//  LatestSongsState.swift
//  Musicify
//
//  Created by Hai Phan on 08/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import ReSwift

struct LatestSongsState: StateType {
    var songs: [Song]
    var loading: Bool
    var error: String?
}
