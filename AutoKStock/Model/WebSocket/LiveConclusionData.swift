//
//  LiveConclusionData.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/27/24.
//

import Foundation

struct LiveConclusionData: WebsocketData {
    let encryption: String
    let trId: String
    let dataCount: Int
    let conclusionData: [ConclusionData]
    
    init?(stringData: String) {
        let line = stringData.split(separator: "|").map{ String($0) }
        
        encryption = line[0]
        trId = line[1]
        guard let count = Int(line[2]) else { return nil }
        dataCount = count
        
        let conclusionLine = line[3].split(separator: "^").map { String($0) }
        
        var conclusionArr = [ConclusionData]()
        
        for i in 0..<(conclusionLine.count / 45) {
            let sliceLine = Array(conclusionLine[(i * 45)..<((i + 1) * 45)])
            guard let conclusionData = ConclusionData(line: sliceLine) else { break }
            conclusionArr.append(conclusionData)
        }
        
        conclusionData = conclusionArr
    }
}


struct ConclusionData {
    /// 유가증권 단축 종목코드
    let MKSC_SHRN_ISCD: String
    ///주식 체결 시간
    let STCK_CNTG_HOUR:   String
    /// 주식 현재가
    let STCK_PRPR: String
    ///전일 대비 부호 (1 : 상한,  2 : 상승, 3 : 보합, 4 : 하한, 5 : 하락)
    let PRDY_VRSS_SIGN: String
    /// 전일 대비 가격차
    let PRDY_VRSS: String
    /// 전일 대비율
    let PRDY_CTRT: String
    /// 가중 평균 주식 가격
    let WGHN_AVRG_STCK_PRC: String
    /// 주식 시가
    let STCK_OPRC: String
    /// 주식 최고가
    let STCK_HGPR: String
    /// 주식 최저가
    let STCK_LWPR: String
    /// 매도호가1
    let ASKP1: String
    /// 매수호가1
    let BIDP1: String
    /// 체결 거래량
    let CNTG_VOL: String
    /// 누적 거래량
    let ACML_VOL: String
    /// 누적 거래 대금
    let ACML_TR_PBMN: String
    /// 매도 체결 건수
    let SELN_CNTG_CSNU: String
    /// 매수 체결 건수
    let SHNU_CNTG_CSNU: String
    /// 순매수 체결 건수
    let NTBY_CNTG_CSNU: String
    /// 체결강도
    let CTTR: String
    /// 총 매도 수량
    let SELN_CNTG_SMTN: String
    /// 총 매수 수량
    let SHNU_CNTG_SMTN: String
    /// 체결 구분 [ 1:매수(+), 3:장전, 5:매도(-) ]
    let CCLD_DVSN: String
    /// 매수비율
    let SHNU_RATE: String
    /// 전일 거래 대비 등락율
    let PRDY_VOL_VRSS_ACML_VOL_RATE: String
    /// 시가 시간
    let OPRC_HOUR: String
    /// 시가 대비 구분 (1 : 상한 / 2 : 상승 / 3 : 보합 / 4 : 하한 / 5 : 하락)
    let OPRC_VRSS_PRPR_SIGN: String
    /// 시가대비
    let OPRC_VRSS_PRPR: String
    /// 최고가 시간
    let HGPR_HOUR: String
    /// 고가대비구분 [1 : 상한 / 2 : 상승 / 3 : 보합 / 4 : 하한 / 5 : 하락]
    let HGPR_VRSS_PRPR_SIGN: String
    /// 고가대비
    let HGPR_VRSS_PRPR: String
    /// 최저가 시간
    let LWPR_HOUR: String
    /// 저가대비구분 [1 : 상한 / 2 : 상승 / 3 : 보합 / 4 : 하한 / 5 : 하락]
    let LWPR_VRSS_PRPR_SIGN: String
    /// 저가대비
    let LWPR_VRSS_PRPR: String
    /// 영업일자 ex. 20240227
    let BSOP_DATE: String
    /// 신 장운영 구분 코드
    /// 1) 첫 번째 비트
    ///    1 : 장개시전
    ///    2 : 장중
    ///    3 : 장종료후
    ///    4 : 시간외단일가
    ///    7 : 일반Buy-in
    ///    8 : 당일Buy-in
    ///
    ///    (2) 두 번째 비트
    ///    0 : 보통
    ///    1 : 종가
    ///    2 : 대량
    ///    3 : 바스켓
    ///    7 : 정리매매
    ///    8 : Buy-in
    let NEW_MKOP_CLS_CODE: String
    /// 거래정지여부 ex. Y = 거래정지
    let TRHT_YN: String
    /// 매도호가 잔량1
    let ASKP_RSQN1: String
    /// 매수호가 잔량1
    let BIDP_RSQN1: String
    /// 총 매도호가 잔량
    let TOTAL_ASKP_RSQN: String
    /// 총 매수호가 잔량
    let TOTAL_BIDP_RSQN: String
    /// 거래량 회전율
    let VOL_TNRT: String
    /// 전일 동시간 누적 거래량
    let PRDY_SMNS_HOUR_ACML_VOL: String
    /// 전일 동시간 누적 거래량 비율
    let PRDY_SMNS_HOUR_ACML_VOL_RAT: String
    /// 시간 구분 코드 (0 : 장중 A : 장후예상 B : 장전예상 C : 9시이후의 예상가, VI발동 D : 시간외 단일가 예상
    let HOUR_CLS_CODE: String
    /// 임의종료구분코드
    let MRKT_TRTM_CLS_CODE: String
    /// 정적VI발동기준가
    let VI_STND_PRC: String
    
    init?(line: [String]) {
        MKSC_SHRN_ISCD = line[0]
        STCK_CNTG_HOUR = line[1]
        STCK_PRPR = line[2]
        PRDY_VRSS_SIGN = line[3]
        PRDY_VRSS = line[4]
        PRDY_CTRT = line[5]
        WGHN_AVRG_STCK_PRC = line[6]
        STCK_OPRC = line[7]
        STCK_HGPR = line[8]
        STCK_LWPR = line[9]
        ASKP1 = line[10]
        BIDP1 = line[11]
        CNTG_VOL = line[12]
        ACML_VOL = line[13]
        ACML_TR_PBMN = line[14]
        SELN_CNTG_CSNU = line[15]
        SHNU_CNTG_CSNU = line[16]
        NTBY_CNTG_CSNU = line[17]
        CTTR = line[18]
        SELN_CNTG_SMTN = line[19]
        SHNU_CNTG_SMTN = line[20]
        CCLD_DVSN = line[21]
        SHNU_RATE = line[22]
        PRDY_VOL_VRSS_ACML_VOL_RATE = line[23]
        OPRC_HOUR = line[24]
        OPRC_VRSS_PRPR_SIGN = line[25]
        OPRC_VRSS_PRPR = line[26]
        HGPR_HOUR = line[27]
        HGPR_VRSS_PRPR_SIGN = line[28]
        HGPR_VRSS_PRPR = line[29]
        LWPR_HOUR = line[30]
        LWPR_VRSS_PRPR_SIGN = line[31]
        LWPR_VRSS_PRPR = line[32]
        BSOP_DATE = line[33]
        NEW_MKOP_CLS_CODE = line[34]
        TRHT_YN = line[35]
        ASKP_RSQN1 = line[36]
        BIDP_RSQN1 = line[37]
        TOTAL_ASKP_RSQN = line[37]
        TOTAL_BIDP_RSQN = line[38]
        VOL_TNRT = line[39]
        PRDY_SMNS_HOUR_ACML_VOL = line[40]
        PRDY_SMNS_HOUR_ACML_VOL_RAT = line[41]
        HOUR_CLS_CODE = line[42]
        MRKT_TRTM_CLS_CODE = line[43]
        VI_STND_PRC = line[44]
    }
    
    var toPriceMinuteData: PriceMinuteData {
        let startIdx = STCK_CNTG_HOUR.startIndex
        let hour = STCK_CNTG_HOUR[startIdx..<STCK_CNTG_HOUR.index(startIdx, offsetBy: 2)]
        let min = STCK_CNTG_HOUR[STCK_CNTG_HOUR.index(startIdx, offsetBy: 2)..<STCK_CNTG_HOUR.index(startIdx, offsetBy: 4)]
        let timeString = String(hour + min) + "00"
        let data = PriceMinuteData(
            acmlTrPbmn: ACML_VOL,
            cntgVol: CNTG_VOL,
            stckBsopDate: BSOP_DATE,
            stckCntgHour: timeString,
            stckHgpr: STCK_HGPR,
            stckLwpr: STCK_LWPR,
            stckOprc: STCK_OPRC,
            stckPrpr: STCK_PRPR
        )
        
        return data
    }
}
