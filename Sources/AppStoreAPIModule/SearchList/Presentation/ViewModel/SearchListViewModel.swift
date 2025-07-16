//
//  SearchListViewModel.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import Combine

public final class SearchListViewModel: ObservableObject {
    @Published var searchKeyword: String = ""
    @Published private(set) var searchEntitys: [SearchListEntity] = []
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading: Bool = false

    private let useCase: SearchListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    public init(useCase: SearchListUseCaseProtocol) {
        self.useCase = useCase
        
        self.searchKeywordAllList()
        searchKeywordBind()
    }
    
    public func searchKeywordBind() {
        $searchKeyword
            .dropFirst()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { [weak self] searchKeyword -> AnyPublisher<[SearchListEntity], Never> in
                guard let self else {
                    return Just([]).eraseToAnyPublisher()
                }
                
                self.isLoading = true
                
                return self.useCase.selectSearchKeywordBind(searchKeyword: searchKeyword)
                    .catch { [weak self] error -> Just<[SearchListEntity]> in
                        self?.errorMessage = error.localizedDescription
                        
                        return Just([])
                    }
                    .handleEvents(
                        receiveOutput: { [weak self] _ in self?.isLoading = false
                            self?.isLoading = false
                        }
                    )
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.searchEntitys, on: self)
            .store(in: &cancellables)
    }

    public func searchKeywordList(searchKeyword: String) {
        isLoading = true
        errorMessage = nil

        useCase.selectUseCaseProtocol(searchKeyword: searchKeyword)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    
                    if case let .failure(error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] results in
                    self?.isLoading = false
                    self?.searchEntitys = results
                }
            )
            .store(in: &cancellables)
    }
    
    public func searchKeywordAllList() {
        isLoading = true
        errorMessage = nil

        useCase.selectAllUseCaseProtocol()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    
                    if case let .failure(error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] results in
                    self?.isLoading = false
                    self?.searchEntitys = results
                }
            )
            .store(in: &cancellables)
    }

    public func searchKeywordSave(searchKeyword: String) {
        isLoading = true
        errorMessage = nil
        
        useCase.insertUseCaseProtocol(searchKeyword: searchKeyword)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    
                    if case let .failure(error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] _ in
                    self?.searchKeywordAllList()
                }
            )
            .store(in: &cancellables)
    }
}
