//
//  HomeViewModel.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/11/21.
//

import Foundation
import Combine
class HomeViewModel : ObservableObject {
    
    @Published var statistics : [Statistic] = [
        Statistic(title: "Title", value: "value", percentageChange: 1),
        Statistic(title: "Title", value: "value" ),
        Statistic(title: "Title", value: "value"),
        Statistic(title: "Title", value: "value", percentageChange: 7)
    ]
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText : String = ""
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    init(){
        addSubscribers()
    }
    
    func addSubscribers() {
//        dataService.$allCoins
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
//
        // function upates allcoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text : String, coins : [Coin]) -> [Coin]{
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
    }
}
