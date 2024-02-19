//
//  BalanceData.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/19/24.
//
import Foundation

struct BalanceData: Codable {
    let ctxAreaFk100: String
    let ctxAreaNk100: String
    let output1: [BalanceStockData]
    let output2: [BalanceMoneyData]
    let rtCd, msgCd, msg1: String
}

// MARK: - BalanceStockData
struct BalanceStockData: Codable {
    /// 상품번호 (종목번호 뒷 6자리)
    let pdno: String
    /// 종목명
    let prdtName: String
    /// 매수매도구분
    let tradDvsnName: String
    /// 전일매수수량
    let bfdyBuyQty: String
    /// 전일매도수량
    let bfdySllQty: String
    /// 금일매수수량
    let thdtBuyqty : String
    /// 금일매도수량
    let thdtSllQty: String
    /// 보유수량
    let hldgQty: String
    /// 주문가능수량
    let ordPsblQty: String
    ///매입평균가격
    let pchsAvgPric: String
    ///매입금액
    let pchsAmt: String
    ///현재가
    let prpr: String
    ///평가금액
    let evluAmt: String
    ///평가손익금액
    let evluPflsAmt: String
    ///평가손익율
    let evluPflsRt: String
    /// 등락율
    let flttRt: String
    ///전일대비증감
    let bfdyCprsIcdc: String
}

// MARK: - BalanceMoneyData
struct BalanceMoneyData: Codable {
    /// 예수금총금액
    let dncaTotAmt: String
    /// D+1 예수금
    let nxdyExccAmt: String
    /// D+2 예수금
    let prvsRcdlExccAmt: String
    /// CMA 평가금액
    let cmaEvluAmt: String
    ///전일매수금액
    let bfdyBuyAmt: String
    ///금익매수금액
    let thdtBuyAmt:String
    ///익일자동상환금액
    let nxdyAutoRdptAmt: String
    ///전일매도금액
    let bfdySllAmt: String
    ///금일매도금액
    let thdtSllAmt: String
    ///D+2 자동상환금액
    let d2AutoRdptAmt: String
    ///유가평가금액
    let sctsEvluAmt: String
    ///총평가금액
    let totEvluAmt: String
    ///순자산금액
    let nassAmt: String
    ///매입금액합계금액
    let pchsAmtSmtlAmt: String
    ///평가금액합계금액
    let evluAmtSmtlAmt: String
    ///평가손익합계금액
    let evluPflsSmtlAmt: String
    ///전일총자산평가금액
    let bfdyTotAsstEvluAmt: String
    ///자산증감액
    let asstIcdcAmt: String
}
