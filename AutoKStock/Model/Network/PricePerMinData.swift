//
//  PricePerMinData.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/20/24.
//

import Foundation

struct PricePerMinData: Decodable {
    let output1: PriceTheDayData
    var output2: Set<PriceMinuteData>
    let rtCd: String
    let msgCd: String
    let msg1: String
    
    // 조회된 데이터 중 최저가
    var lowestPrice: Int {
        var value = Int.max
        
        for ele in output2 {
            guard let price = Int(ele.stckLwpr), value > price else { continue }
            value = price
        }
        return value != Int.max ? value : 0
    }
    
    var highestPrice: Int {
        var value = 0
        
        for ele in output2 {
            guard let price = Int(ele.stckHgpr), value < price else { continue }
            value = price
        }
        return value != 0 ? value : 10_000_000
    }
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
struct PriceMinuteData: Decodable, Hashable, Identifiable {
    var id: String { stckCntgHour }
    ///누적 거래 대금
    let acmlTrPbmn: String
    ///체결 거래량
    let cntgVol: String
    ///주식 영업 일자
    let stckBsopDate: String
    ///주식 체결 시간 ex. 095900
    let stckCntgHour: String
    ///주식 최고가
    let stckHgpr: String
    ///주식 최저가
    let stckLwpr: String
    ///주식 시가2
    let stckOprc: String
    ///주식 현재가
    let stckPrpr: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(stckCntgHour)
    }
    
    static func == (lhs: PriceMinuteData, rhs: PriceMinuteData) -> Bool {
        return lhs.stckCntgHour == rhs.stckCntgHour
    }
    
    var timeString: String {
        let df = DateFormatter()
        df.dateFormat = "HHmmss"
        let date = df.date(from: stckCntgHour)!
        df.dateFormat = "HH:mm"
        
        return df.string(from: date)
    }
    
    var timeDate: Date {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMddHHmmss"
        return df.date(from: stckBsopDate + stckCntgHour)!
    }
}
