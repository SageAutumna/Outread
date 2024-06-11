//
//  Globals.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import Foundation

// MARK: - TypeAlice
typealias TaskBag = Set<TaskCancellable>

// MARK: - Properties
public let queue = DispatchQueue.main

enum Globals {
    // API SECRETS
    static let CONUMER_KEY = "ck_613654b429f3f735d867c2bd6f1ef1f27702e2fd"
    static let CONUMER_SECRET = "cs_e74484bfc016c729317db18c9cde9338eaaba4ba"
}
