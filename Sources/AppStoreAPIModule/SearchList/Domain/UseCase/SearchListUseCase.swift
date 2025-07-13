//
//  SearchListUseCase.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

class SearchListUseCase: SearchListUseCaseProtocol {
    private let repository: SearchListRepositoryProtocol
    
    init(repository: SearchListRepositoryProtocol) {
        self.repository = repository
    }
    
    func insertUseCaseProtocol(searchKeyword: String) -> AnyPublisher<Void, Error> {
        return repository.selectRepositoryProtocol(searchKeyword: searchKeyword)
            .flatMap { existingKeywords -> AnyPublisher<Void, Error> in
                if existingKeywords.contains(where: { $0.searchKeyword == searchKeyword }) {
                    return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
                } else {
                    return self.repository.insertRepositoryProtocol(searchKeyword: searchKeyword)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        return repository.updateRepositoryProtocol(searchKeyword: searchKeyword)
    }
    
    func deleteUseCaseProtocol(searchKeyword: String) -> AnyPublisher<Void, Error> {
        return repository.deleteRepositoryProtocol(searchKeyword: searchKeyword)
    }
    
    func deleteAllUseCaseProtocol() -> AnyPublisher<Void, Error> {
        return repository.deleteAllRepositoryProtocol()
    }
    
    func selectUseCaseProtocol(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        let trimmedSearchKeyword = searchKeyword.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedSearchKeyword.isEmpty else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return repository.selectRepositoryProtocol(searchKeyword: searchKeyword)
    }
    
    func selectAllUseCaseProtocol() -> AnyPublisher<[SearchListEntity], Error> {
        return repository.selectAllRepositoryProtocol()
    }
    
    func selectSearchKeywordBind(searchKeyword: String) -> AnyPublisher<[SearchListEntity], Error> {
        let trimmedSearchKeyword = searchKeyword.trimmingCharacters(in: .whitespaces)
        
        if trimmedSearchKeyword.isEmpty {
            return repository.selectAllRepositoryProtocol()
        } else {
            return repository.selectRepositoryProtocol(searchKeyword: trimmedSearchKeyword)
        }
    }
}
