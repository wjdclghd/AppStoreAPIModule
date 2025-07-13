//
//  SearchListEntity.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import CoreDatabase

public struct SearchListEntity: Codable, RealmSwiftDBSearchListEntityProtocol {
    public let searchKeyword: String
    
    public init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
    }
}
