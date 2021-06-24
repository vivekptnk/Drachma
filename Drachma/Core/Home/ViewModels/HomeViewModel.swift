//
//  HomeViewModel.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/11/21.
//

import Foundation
import Combine
class HomeViewModel : ObservableObject {
    
    @Published var statistics : [Statistic] = []
    @Published var isLoading : Bool = false
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText : String = ""
    @Published var sortOptions : sortOption = .holdings
    
//    @State var selectedPortfolioCoin : Coin? = nil
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum sortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
        
    }
    
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
            .combineLatest(coinDataService.$allCoins, $sortOptions)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates potfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink {[weak self] (returnedCoins) in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updatess global data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    
    func updatePortfolio(coin : Coin, amount : Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData(){
        coinDataService.getCoins()
        marketDataService.getData()
        isLoading = true
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text : String, coins : [Coin], sort : sortOption) -> [Coin] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: sortOption, coins : inout [Coin]) {
        switch sort {
        case .rank, .holdings:
            
            coins.sort(by: {$0.rank < $1.rank}) // shorter and condensed
        //            return coins.sorted { coin1, coin2 in
        //                return coin1.rank < coin2.rank
        //            }
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins : [Coin]) -> [Coin] {
        // sort my holdings or rev holdings if needed
        switch sortOptions {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldings! > $1.currentHoldings! })
        case .holdingsReversed :
            return coins.sorted(by: {$0.currentHoldings! < $1.currentHoldings! })
        default:
            return coins
        }
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
    
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities : [PortfolioEntity]) -> [Coin]{
        allCoins
            .compactMap { (coin) -> Coin? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
                
            }
    }
    
    
    private func mapGlobalMarketData (marketDataModel : MarketDataModel?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats : [Statistic] = []
        guard let data = marketDataModel else {return stats}
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        //        let portfolioValue = portfolioCoins.map { (coin) -> Double in
        //            return coin.currentHoldingsValue
        //        }
        //
        let portfolioValue = portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue =
            portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H! / 100    // 25% -> 25
                let previousValue = (currentValue / (1 + percentChange))
                return previousValue
                // 110 / (1 + 0.1) = 100
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = Statistic(title: "Portfolio", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
