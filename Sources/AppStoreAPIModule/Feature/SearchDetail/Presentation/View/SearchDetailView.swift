//
//  SearchDetailView.swift
//  CleanArchitectureiOS
//
//  Created by jch on 6/29/25.
//

import Foundation
import SwiftUI

struct SearchDetailView: View {
    @StateObject var viewModel: SearchDetailViewModel
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    var body: some View {
        ScrollView {
            if let entity = viewModel.searchDetailEntity {
                VStack(alignment: .leading, spacing: 16) {
                    if let urlString = entity.artworkUrl100,
                       let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .padding(.bottom, 8)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(entity.trackName ?? "앱 이름 없음")
                            .font(.title)
                            .fontWeight(.bold)

                        Text(entity.artistName ?? "개발자 없음")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    if let rating = entity.averageUserRating {
                        Text("평점: \(rating, specifier: "%.1f")점")
                            .font(.subheadline)
                    }

                    if let genres = entity.genres {
                        Text("장르: \(genres.joined(separator: ", "))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }

                    if let description = entity.description {
                        Text(description)
                            .font(.body)
                            .padding(.top, 8)
                    }

                    Button(action: {
                        coordinator.pop()
                    }) {
                        Text("뒤로 가기")
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                    .padding(.top, 16)
                }
                .padding()
            } else {
                VStack {
                    Text("데이터가 없습니다.")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
        }
        .navigationTitle("앱 상세")
        .navigationBarTitleDisplayMode(.inline)
    }
}
