//
//  SearchDetailListEntity.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation

public struct SearchDetailListEntity: Codable {
    public let resultCount: Int
    public let results: [SearchDetailEntity]
    
    public init(resultCount: Int, results: [SearchDetailEntity]) {
        self.resultCount = resultCount
        self.results = results
    }
}
