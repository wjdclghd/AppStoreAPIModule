//
//  SearchListEntity.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
//import CoreDatabase
import CoreModule

struct SearchListEntity: Codable, RealmSwiftDBSearchListEntityProtocol {
    let searchKeyword: String
}
