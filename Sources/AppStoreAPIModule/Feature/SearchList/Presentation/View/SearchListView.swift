//
//  SearchListView.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import SwiftUI

struct SearchListView: View {
    @StateObject private var viewModel: SearchListViewModel
    @EnvironmentObject private var coordinator: NavigationCoordinator

    init(viewModel: @autoclosure @escaping () -> SearchListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack(spacing: 0) {
                TextField("검색어를 입력하세요", text: $viewModel.searchKeyword)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onSubmit {
                        let searchKeyword = viewModel.searchKeyword.trimmingCharacters(in: .whitespaces)
                        guard !searchKeyword.isEmpty else {
                            return
                        }

                        viewModel.searchKeywordSave(searchKeyword: viewModel.searchKeyword)
                        
                        coordinator.push(route: .searchDetailList(searchKeyword: viewModel.searchKeyword))
                    }
                
                ZStack {
                    if viewModel.isLoading {
                        ProgressView("로딩 중...")
                    } else if viewModel.searchEntitys.isEmpty {
                        Text("검색 결과가 없습니다.")
                            .foregroundColor(.gray)
                    } else {
                        List(viewModel.searchEntitys, id: \.searchKeyword) { entity in
                            Button {
                                coordinator.push(route: .searchDetailList(searchKeyword: entity.searchKeyword))
                            } label: {
                                Text(entity.searchKeyword)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top, 4)
                }
            }
            .navigationTitle("검색 기록")
            .navigationDestination(for: AppRoute.self) { appRoute in
                coordinator.build(route: appRoute)
            }
        }
    }
}
