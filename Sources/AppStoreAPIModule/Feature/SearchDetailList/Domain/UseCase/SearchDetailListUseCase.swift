//
//  SearchDetailListUseCase.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

public final class SearchDetailListUseCase: SearchDetailListUseCaseProtocol {
    private let repository: SearchDetailListRepositoryProtocol

    public init(repository: SearchDetailListRepositoryProtocol) {
        self.repository = repository
    }

    public func searchDetailListUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchDetailEntity], Error> {
        repository.searchDetailListRepositoryProtocol(searchKeyword: searchKeyword)
    }
}
