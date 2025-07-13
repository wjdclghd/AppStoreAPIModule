//
//  SearchDetailListEntity.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation

struct SearchDetailListEntity: Codable {
    let resultCount: Int
    let results: [SearchDetailEntity]
}
