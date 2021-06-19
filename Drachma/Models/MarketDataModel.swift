//
//  MarketDataModel.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/19/21.
//

import Foundation


// JSON Data
/*
 
 
 URL : https://api.coingecko.com/api/v3/global
 
 JSON Response :
 
 {
   "data": {
     "active_cryptocurrencies": 8016,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 623,
     "total_market_cap": {
       "btc": 43208063.69269247,
       "eth": 693489234.1202013,
       "ltc": 9813908661.009123,
       "bch": 2710526180.4744277,
       "bnb": 4568892641.341417,
       "eos": 334769329379.55725,
       "xrp": 1958315794835.0034,
       "xlm": 5140888740161.401,
       "link": 72567577080.50883,
       "dot": 73738002017.35551,
       "yfi": 45202985.90083765,
       "usd": 1555038886149.373,
       "aed": 5711813332715.263,
       "ars": 148298014135915.06,
       "aud": 2079485080736.5647,
       "bdt": 131811104660276.92,
       "bhd": 586136142239.6257,
       "bmd": 1555038886149.373,
       "brl": 7915381186333.2295,
       "cad": 1938138266141.1333,
       "chf": 1435378643860.1787,
       "clp": 1164103254680040.8,
       "cny": 10034821436210.516,
       "czk": 33531303502038.926,
       "dkk": 9747613529133.143,
       "eur": 1310681630618.7458,
       "gbp": 1125901024894.2747,
       "hkd": 12070973803345.635,
       "huf": 466471234833770.8,
       "idr": 22531735940861344,
       "ils": 5097977282796.667,
       "inr": 115296958678547.48,
       "jpy": 171357454824248.72,
       "krw": 1765357895501073.2,
       "kwd": 468564317174.531,
       "lkr": 309114462959626.56,
       "mmk": 2560013714707318.5,
       "mxn": 32149729203639.516,
       "myr": 6437860988658.388,
       "ngn": 637565943321244.1,
       "nok": 13487007763462.129,
       "nzd": 2242143703266.677,
       "php": 75420563142681.36,
       "pkr": 243907849292528.9,
       "pln": 5967461725598.231,
       "rub": 113206208896120.06,
       "sar": 5831445584304.518,
       "sek": 13387500825137.424,
       "sgd": 2091115216566.0762,
       "thb": 48884855541323.79,
       "try": 13593994438829.217,
       "twd": 43221528321078.88,
       "uah": 42293011492081.17,
       "vef": 155706043670.13647,
       "vnd": 35920742396634372,
       "zar": 22318866667736.36,
       "xdr": 1088290854393.8662,
       "xag": 60268160048.4365,
       "xau": 881333839.1140192,
       "bits": 43208063692692.48,
       "sats": 4320806369269247.5
     },
     "total_volume": {
       "btc": 3018129.703397153,
       "eth": 48440968.59721825,
       "ltc": 685512071.2393231,
       "bch": 189333167.88525888,
       "bnb": 319142063.1699667,
       "eos": 23383997579.08305,
       "xrp": 136790463721.31062,
       "xlm": 359096605645.05237,
       "link": 5068923278.950068,
       "dot": 5150678719.152569,
       "yfi": 3157477.1644449825,
       "usd": 108621138072.86389,
       "aed": 398976302255.4364,
       "ars": 10358775727645.326,
       "aud": 145254268614.76556,
       "bdt": 9207147375133.455,
       "bhd": 40942239710.390434,
       "bmd": 108621138072.86389,
       "brl": 552897885961.588,
       "cad": 135381041648.49469,
       "chf": 100262741498.15701,
       "clp": 81313863906503.53,
       "cny": 700943066097.9978,
       "czk": 2342197600265.1636,
       "dkk": 680881285001.6292,
       "eur": 91552521057.23207,
       "gbp": 78645397083.44789,
       "hkd": 843170498079.2244,
       "huf": 32583517272269.188,
       "idr": 1573865980106761.8,
       "ils": 356099194212.5547,
       "inr": 8053616523388.21,
       "jpy": 11969502451716.396,
       "krw": 123312146997218.55,
       "kwd": 32729721324.115482,
       "lkr": 21591977577229.223,
       "mmk": 178819710330342.2,
       "mxn": 2245693150144.3276,
       "myr": 449691511621.6554,
       "ngn": 44534666609874.27,
       "nok": 942081992619.7559,
       "nzd": 156616148278.32535,
       "php": 5268207422735.417,
       "pkr": 17037225506728.684,
       "pln": 416833617354.616,
       "rub": 7907575403249.273,
       "sar": 407332743649.65875,
       "sek": 935131325994.4728,
       "sgd": 146066646106.41257,
       "thb": 3414659717336.5337,
       "try": 949555126919.1697,
       "twd": 3019070222166.2246,
       "uah": 2954212323380.631,
       "vef": 10876234555.235844,
       "vnd": 2509102476019886,
       "zar": 1558996832515.9675,
       "xdr": 76018286238.01762,
       "xag": 4209795775.73718,
       "xau": 61562116.21417637,
       "bits": 3018129703397.153,
       "sats": 301812970339715.3
     },
     "market_cap_percentage": {
       "btc": 43.36845116058547,
       "eth": 16.779601142379217,
       "usdt": 4.056347678367703,
       "bnb": 3.382896593105066,
       "ada": 2.934064624471322,
       "doge": 2.448855385720184,
       "xrp": 2.3590433755928073,
       "usdc": 1.563835198498191,
       "dot": 1.3607316412638244,
       "bch": 0.6927767018279061
     },
     "market_cap_change_percentage_24h_usd": -2.0995340724272107,
     "updated_at": 1624112260
   }
 }
 
 
 */

struct GlobalData: Codable {
    let data: MarketDataModel
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap : String {
//        if let item = totalMarketCap.first(where: { (key, value) in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        }
//
        // shorter method to write code above
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume : String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance : String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPercentString()
        }
        return ""
    }
}
