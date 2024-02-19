//
//  TradingVolumeRanking.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/17/24.
//

import Foundation

struct TradingVolumeRankingData: Decodable {
    let output: [TradingVolumeRankingOutput]
    let rtCd, msgCd, msg1: String
}

struct TradingVolumeRankingOutput: Decodable {
    let htsKorIsnm, mkscShrnIscd, dataRank, stckPrpr: String
    let prdyVrssSign, prdyVrss, prdyCtrt, acmlVol: String
    let prdyVol, lstnStcn, avrgVol, nBefrClprVrssPrprRate: String
    let volInrt, volTnrt, ndayVolTnrt, avrgTrPbmn: String
    let trPbmnTnrt, ndayTrPbmnTnrt, acmlTrPbmn: String
}
