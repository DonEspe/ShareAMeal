//
//  SelectFoodbankView.swift
//  ShareAMeal
//
//  Created by Don Espe on 10/17/23.
//

import SwiftUI

struct SelectFoodbankView: View {
    @Environment(DataController.self) private var dataController
    @State private var state = LoadState.loading

    var postCode: String

    var body: some View {
        Group {
            switch state {
                case .loading:
                    ProgressView("Loading...")

                case .failed:
                    ContentUnavailableView {
                        Label("Load failed", systemImage: "exclamationmark.triangle")
                    } description: {
                        Text("Loading failed; please try again.")
                    } actions: {
                        Button("Retry", systemImage: "arrow.circlepath", action:  fetchFoodbanks)
                            .buttonStyle(.borderedProminent)
                    }

                case .loaded(let foodbanks):
                    List {
                        ForEach(foodbanks) { foodbank in
                            Section(foodbank.distanceFormatted) {
                                VStack(alignment: .leading) {
                                    Text(foodbank.name)
                                        .font(.title)

                                    Text(foodbank.address)

                                    Button("Select this foodbank") {
                                        withAnimation {
                                            dataController.select(foodbank)
                                        }
                                    }
                                    .buttonStyle(.borderless)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, 5)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
            }
        }
        .navigationTitle("Nearby Foodbanks")
        .task {
            fetchFoodbanks()
        }
    }

    func fetchFoodbanks() {
        state = .loading

        Task {
            try await Task.sleep(for: .seconds(0.5))

            state = try await dataController.loadFoodbanks(near: postCode)
        }
    }
}

#Preview {
    NavigationStack {
        SelectFoodbankView(postCode: "SW1 1AA")
            .environment(DataController())
    }
}
