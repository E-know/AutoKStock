//
//  PricePerMinData.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/20/24.
//

import Foundation

struct PricePerMinData: Decodable {
    let output1: PriceTheDayData
    var output2: [PriceMinuteData]
    let rtCd: String
    let msgCd: String
    let msg1: String
}

// MARK: - PriceTheDayData
struct PriceTheDayData: Decodable {
    ///누적 거래 대금
    let acmlTrPbmn: String
    ///누적 거래량
    let acmlVol: String
    ///HTS 한글 종목명
    let htsKorIsnm: String
    ///전일 대비율
    let prdyCtrt: String
    ///전일 대비
    let prdyVrss: String
    ///전일 대비 부호
    let prdyVrssSign: String
    ///주식 전일 종가
    let stckPrdyClpr: String
    ///주식 현재가
    let stckPrpr: String
}

// MARK: - PriceMinuteData
struct PriceMinuteData: Decodable, Hashable {
    ///누적 거래 대금
    let acmlTrPbmn: String
    ///체결 거래량
    let cntgVol: String
    ///주식 영업 일자
    let stckBsopDate: String
    ///주식 체결 시간
    let stckCntgHour: String
    ///주식 최고가
    let stckHgpr: String
    ///주식 최저가
    let stckLwpr: String
    ///주식 시가2
    let stckOprc: String
    ///주식 현재가
    let stckPrpr: String
}
