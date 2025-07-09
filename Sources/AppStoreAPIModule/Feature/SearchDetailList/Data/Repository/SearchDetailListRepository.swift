//
//  SearchDetailListRepository.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation

import Combine
import CoreModule

class SearchDetailListRepository: SearchDetailListRepositoryProtocol {
    let networkServiceProtocol: NetworkServiceProtocol

    init(networkServiceProtocol: NetworkServiceProtocol) {
        self.networkServiceProtocol = networkServiceProtocol
    }

    func searchDetailListRepositoryProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error> {
        networkServiceProtocol.request(.searchDetailList(searchKeyword: searchKeyword), type: SearchDetailListEntity.self)
            .map { $0.results }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
