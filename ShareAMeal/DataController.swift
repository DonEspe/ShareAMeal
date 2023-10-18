//
//  DataController.swift
//  ShareAMeal
//
//  Created by Don Espe on 10/17/23.
//

import Foundation

enum LoadState {
    case loading, failed, loaded([Foodbank])
}

@Observable
class DataController {
    private(set) var selectedFoodBank: Foodbank?

    func select(_ foodbank: Foodbank?) {
        selectedFoodBank = foodbank
        save()
    }

    private let savePath = URL.documentsDirectory.appending(path: "SelectedFoodbank")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let savedFoodbank = try JSONDecoder().decode(Foodbank.self, from: data)
            select(savedFoodbank)
        } catch {

        }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(selectedFoodBank)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }

    func loadFoodbanks(near postCode: String) async -> LoadState {
        let fullURL = "https://www.givefood.org.uk/api/2/foodbanks/search/?address=\(postCode)"

        guard let url = URL(string: fullURL) else {
            return .failed
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let foodbanks = try JSONDecoder().decode([Foodbank].self, from: data)
            return .loaded(foodbanks)
        } catch {
            print(fullURL)
            return .failed
        }
    }
}
