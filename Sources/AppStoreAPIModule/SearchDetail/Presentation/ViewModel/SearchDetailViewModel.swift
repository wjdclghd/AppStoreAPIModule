//
//  SearchDetailViewModel.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation

final class SearchDetailViewModel: ObservableObject {
    @Published var searchDetailEntity: SearchDetailEntity?

    init(entity: SearchDetailEntity) {
        self.searchDetailEntity = entity
    }
}
