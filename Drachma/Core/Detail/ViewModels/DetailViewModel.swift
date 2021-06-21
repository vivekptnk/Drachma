//
//  DetailViewModel.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/20/21.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
    @Published var coin : Coin
    private var coinDetailService : CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var overviewStatistic : [Statistic] = []
    @Published var additionalStatistic : [Statistic] = []
    @Published var coinDescription : String? = nil
    @Published var websiteURL : String? = nil
    @Published var redditURL : String? = nil
    
    init(coin : Coin) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDetailToStatistics)
            .sink { [weak self] (returnedArrays) in

                self?.overviewStatistic = returnedArrays.overview
                self?.additionalStatistic = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink {[weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func createOverviewArray(coinModel : Coin) -> [Statistic] {
        // overview
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let pricePercentageStat = Statistic(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketPercentCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketPercentCapChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)
        
        let overviewArray : [Statistic] = [
            pricePercentageStat, marketCapStat, rankStat, volumeStat
        ]
        
        return overviewArray
        
    }
    private func createAdditionalArray(coinDetailModel : CoinDetailModel?, coinModel : Coin) -> [Statistic]{
        
        //additional
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h High Price Change", value: priceChange, percentageChange: pricePercentageChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime  = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing  = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray : [Statistic] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        
        return additionalArray
    }
    
    private func mapDetailToStatistics(coinDetailModel : CoinDetailModel?, coinModel : Coin) -> (overview: [Statistic], additional : [Statistic]) {
        
        let overviewArray = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        
        return (overviewArray, additionalArray)
    }
}
