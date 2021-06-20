//
//  CoinDetailDataService.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/20/21.
//

import Foundation
import Combine


class CoinDetailDataService {
    @Published var coinDetails : CoinDetailModel? = nil
    var coinDetailSubscription : AnyCancellable?
    let coin: Coin
    
    init(coin: Coin){
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
        
        coinDetailSubscription =
            NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
        //            .store(in: &cancellables)
    }
}
