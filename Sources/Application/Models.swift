//
//  Models.swift
//  Application
//
//  Created by David Dunn on 11/09/2018.
//

import Foundation
import SwiftKueryORM


struct ARModel: Model {
    let id: String
    let text: String
    let lattitude: Double
    let longitude: Double
}
