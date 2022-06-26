//
//  Challenge.swift
//  Increment
//
//  Created by Taewoo Kim on 2022/06/26.
//

import Foundation

struct Challenge: Codable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}
