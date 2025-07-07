//
//  SearchDetailListViewModel.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

final class SearchDetailListViewModel: ObservableObject {
    @Published private(set) var searchDetailEntitys: [SearchDetailEntity] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    private let useCase: SearchDetailListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(useCase: SearchDetailListUseCaseProtocol, searchKeyword: String) {
        self.useCase = useCase
        
        searchDetailList(searchKeyword: searchKeyword)
    }

    func searchDetailList(searchKeyword: String) {
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
                self?.searchDetailEntitys = results
            })
            .store(in: &cancellables)
    }
}
