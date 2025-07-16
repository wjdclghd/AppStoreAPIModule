//
//  SearchDetailListViewModel.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

public final class SearchDetailListViewModel: ObservableObject {
    @Published private(set) var searchDetailResults: [SearchDetailEntity] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let useCase: SearchDetailListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    public init(useCase: SearchDetailListUseCaseProtocol, searchKeyword: String) {
        self.useCase = useCase
        
        searchDetailList(searchKeyword: searchKeyword)
    }

    public func searchDetailList(searchKeyword: String) {
        isLoading = true
        errorMessage = nil
        
        useCase.searchDetailListUseCaseProtocol(searchKeyword: searchKeyword)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] results in
                self?.searchDetailResults = results
            })
            .store(in: &cancellables)
    }
}
