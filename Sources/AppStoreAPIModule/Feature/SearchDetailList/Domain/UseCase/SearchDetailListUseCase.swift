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
        let trimmedSearchKeyword = searchKeyword.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedSearchKeyword.isEmpty else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return repository.searchDetailListRepositoryProtocol(searchKeyword: searchKeyword)
    }
}
