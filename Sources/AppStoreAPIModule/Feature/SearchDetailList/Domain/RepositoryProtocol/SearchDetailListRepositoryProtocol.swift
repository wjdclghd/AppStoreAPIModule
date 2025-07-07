//
//  SearchDetailListRepositoryProtocol.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

protocol SearchDetailListRepositoryProtocol {
    func searchDetailListRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error>
}
