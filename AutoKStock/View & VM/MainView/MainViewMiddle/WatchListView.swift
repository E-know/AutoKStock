//
//  WatchListView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/27/24.
//

import SwiftUI

struct WatchListView: View {
    @Binding var vm: MainViewModel
    
    var body: some View {
        VStack {
            Text("주시 주식 목록")
            
            List {
                ScrollView {
                    ForEach(vm.watchList, id: \.productCode) { stockInfo in
                        HStack {
                            Text("\(stockInfo.productCode) | \(stockInfo.name)")
                            
                            Spacer()
                            
                            Button(action: { vm.removeWatchList(candidate: stockInfo)} ) {
                                Text("⬅️")
                            }
                            
                            LiveButton(stockInfo: stockInfo)
                                .padding()
                            
                        }
                        .onTapGesture {
                            vm.selectedStock = stockInfo
                        }
                    }
                }
            }
        }
    }
    
    private func LiveButton(stockInfo: StockInfo) -> some View {
        let isLive = vm.liveStock.contains(stockInfo.productCode)
        
        return Button(action: { vm.getRealTimeConclusionPrice(productCode: stockInfo.productCode)
            Task {
                sleep(10)
                print(vm.liveStock)
            }
        }) {
            Text(isLive ? "Unlive" : "Live")
                .foregroundStyle(isLive ? Color.blue : Color.red)
        }
    }
}

#Preview {
    WatchListView(vm: .constant(MainViewModel()))
}
