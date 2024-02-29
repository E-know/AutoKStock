//
//  PriceChartView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/21/24.
//

import Charts
import SwiftUI

struct PriceChartView: View {
    @Binding var data: PricePerMinData?
    var body: some View {
        ScrollView(.horizontal) {
            if let data {
                Chart(data.output2.sorted{ $0.stckCntgHour < $1.stckCntgHour }) {
                    BarMark(
                        x: .value("Time", $0.timeDate),
                        yStart: .value("startPrice", Int($0.stckOprc > $0.stckPrpr ? $0.stckPrpr : $0.stckOprc)!),
                        yEnd: .value("endPrice", Int($0.stckOprc <= $0.stckPrpr ? $0.stckPrpr : $0.stckOprc)!),
                        width: 10
                    )
                    .foregroundStyle($0.stckOprc > $0.stckPrpr ? Color.blue : Color.red)
                    
                    BarMark(
                        x: .value("Time", $0.timeDate),
                        yStart: .value("startPrice", Int($0.stckLwpr)!),
                        yEnd: .value("endPrice", Int($0.stckHgpr)!),
                        width: 3
                    )
                    .foregroundStyle($0.stckOprc > $0.stckPrpr ? Color.blue : Color.red)
                    
                }
                .chartScrollableAxes(.horizontal)
                .chartYScale(domain: [data.lowestPrice, data.highestPrice])
                .chartXScale(domain: [Date.krStockOpenDate, Date.krStockOpenDate.addingTimeInterval(60 * 60 * 6.5 * 3.05)])
                .chartXAxis {
                    AxisMarks(
                        preset: .extended,
                        position: .bottom,
                        values: .stride(by: .minute)) { value in
                            if value.as(Date.self)!.minute == "0" {
                                AxisGridLine()
                                let label = "\(value.as(Date.self)!.minute)\n\(value.as(Date.self)!.hour)시"
                                AxisValueLabel(label)
                            } else if value.as(Date.self)!.minute == "30" {
                                AxisGridLine()
                                let label = value.as(Date.self)!.minute
                                AxisValueLabel(label)
                            } else if Int(value.as(Date.self)!.minute)! % 2 == 0 {
                                let label = value.as(Date.self)!.minute
                                AxisValueLabel(label)
                            }
                        }
                }
                .frame(width: CGFloat(15 * data.output2.count))
            }
        }
    }
}

//#Preview {
//    PriceChartView(data: .constant(PricePerMinData(
//        output1: PriceTheDayData(acmlTrPbmn: "", acmlVol: "", htsKorIsnm: "", prdyCtrt: "", prdyVrss: "", prdyVrssSign: "", stckPrdyClpr: "", stckPrpr: ""),
//        output2: [
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090000", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "10000"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090100", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11300"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090200", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "10000"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090300", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "13000"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090400", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11200"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090500", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11400"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090600", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11500"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090700", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11600"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090800", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11700"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "090900", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11800"),
//            PriceMinuteData(acmlTrPbmn: "", cntgVol: "", stckBsopDate: "", stckCntgHour: "091000", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11000"),
////            
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090000", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "5000"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090100", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11300"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090200", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "10000"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090300", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "13000"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090400", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11200"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090500", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11400"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090600", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11500"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090700", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11600"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090800", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11700"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "090900", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11800"),
////            PriceMinuteData(acmlTrPbmn: "1", cntgVol: "", stckBsopDate: "", stckCntgHour: "091000", stckHgpr: "", stckLwpr: "", stckOprc: "", stckPrpr: "11000"),
////            
//            
//        ],
//        rtCd: "",
//        msgCd: "",
//        msg1: "")))
//}
