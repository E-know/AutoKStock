//
//  StockInfoData.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/19/24.
//

import Foundation


// MARK: - Welcome
struct StockInfoData: Decodable {
    let output: Output
    let rtCd: String
    let msgCd: String
    let msg1: String
}

// MARK: - Output
struct Output: Decodable {
    ///상품번호
    let pdno: String
    ///상품유형코드
    let prdtTypeCd: String
    ///시장ID코드
    let mketIdCd: String
    ///증권그룹ID코드
    let sctyGrpIdCd: String
    ///거래소구분코드
    let excgDvsnCd: String
    ///결산월일
    let setlMmdd: String
    ///상장주수
    let lstgStqt: String
    ///상장자본금액
    let lstgCptlAmt: String
    ///자본금
    let cpta: String
    ///액면가
    let papr: String
    ///발행가격
    let issuPric: String
    ///코스피200종목여부
    let kospi200ItemYn: String
    ///유가증권시장상장일자
    let sctsMketLstgDt: String
    ///유가증권시장상장폐지일자
    let sctsMketLstgAbolDt: String
    ///코스닥시장상장일자
    let kosdaqMketLstgDt: String
    ///코스닥시장상장폐지일자
    let kosdaqMketLstgAbolDt: String
    ///리츠종류코드
    let reitsKindCd: String
    ///ETF구분코드
    let etfDvsnCd: String
    ///유전펀드여부
    let oilfFundYn: String
    ///지수업종대분류코드
    let idxBztpLclsCd: String
    ///지수업종중분류코드
    let idxBztpMclsCd: String
    ///지수업종소분류코드
    let idxBztpSclsCd: String
    ///주식종류코드
    let stckKindCd: String
    ///상품명
    let prdtName: String
    ///상품명120
    let prdtName120: String
    ///상품약어명(실제 주식 명)
    let prdtAbrvName: String
    ///표준상품번호
    let stdPdno: String
    ///상품영문명
    let prdtEngName: String
    ///상품영문명120
    let prdtEngName120: String
    ///상품영문약어명
    let prdtEngAbrvName: String
    ///ETF과세유형코드
    let etfTxtnTypeCd: String
    ///ETF유형코드
    let etfTypeCd: String
    ///상장폐지일자
    let lstgAbolDt: String
    ///거래정지여부
    let trStopYn: String
    ///관리종목여부
    let admnItemYn: String
    ///당일종가
    let thdtClpr: String
    ///전일종가
    let bfdyClpr: String
    ///종가변경일자
    let clprChngDt: String
    ///표준산업분류코드
    let stdIdstClsfCd: String
    ///표준산업분류코드명
    let stdIdstClsfCdName: String
    ///지수업종대분류코드명
    let idxBztpLclsCdName: String
    ///지수업종중분류코드명
    let idxBztpMclsCdName: String
    ///지수업종소분류코드명
    let idxBztpSclsCdName: String
}
