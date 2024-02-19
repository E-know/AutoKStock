//
//  CurrentStockPrice.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/17/24.
//

import Foundation

struct CurrentStockPriceData: Decodable {
    let output: [String: String]
    let rtCd, msgCd, msg1: String
}

struct CurrentStockPriceOutput: Decodable {
    let iscdStatClsCode, margRate, rprsMrktKorName, bstpKorIsnm: String
    let tempStopYn, oprcRangContYn, clprRangContYn, crdtAbleYn: String
    let grmnRateClsCode: String
    let elwPblcYn, stckPrpr, prdyVrss, prdyVrssSign: String
    let prdyCtrt, acmlTrPbmn, acmlVol, prdyVrssVolRate: String
    let stckOprc, stckHgpr, stckLwpr, stckMxpr: String
    let stckLlam, stckSdpr: String
}
