//
//  SearchDetailListUseCase.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

final class SearchDetailListUseCase: SearchDetailListUseCaseProtocol {
    private let repository: SearchDetailListRepositoryProtocol

    init(repository: SearchDetailListRepositoryProtocol) {
        self.repository = repository
    }

    func searchDetailListUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error> {
        repository.searchDetailListRepositoryProtocol(searchKeyword: searchKeyword)
    }
}
