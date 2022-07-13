//
//  Particle.swift
//  Motion
//
//  Created by Igor Denisiuk on 13.07.22.
//

import Foundation

struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
}
