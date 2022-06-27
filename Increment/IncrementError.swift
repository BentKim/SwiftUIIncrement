//
//  IncrementError.swift
//  Increment
//
//  Created by Taewoo Kim on 2022/06/27.
//

import Foundation

enum IncrementError:LocalizedError {
    case auth(description: String)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth( description):
            return description
        case let .default( description):
            return description ?? "뭔가틀림"
        }
    }
}
