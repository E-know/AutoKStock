//
//  HomeView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/17/24.
//

import SwiftUI

struct MainView: View {
    @State var productTerm = ""
    @State var vm = MainViewModel()
    
    var body: some View {
        VStack {
            MainTopInfoView(vm: $vm)
                .padding()
            
            HStack {
                SearchView(vm: $vm)
                .padding()
                .frame(width: Configuration.shared.screenSize.width / 3)
                
                CandidateView(vm: $vm)
                .padding()
                .frame(width: Configuration.shared.screenSize.width / 3)
                
                WatchListView(vm: $vm)
                .padding()
                .frame(width: Configuration.shared.screenSize.width / 3)
            }
        
            // 여기에 차트
            if let stockInfo = vm.selectedStock {
                PriceChartView(data: $vm.watchListInfo[stockInfo])
            }
            
            Spacer()
        }
        .task {
            await vm.getBalcne()
        }
        .onAppear { // MARK: 디버그 전용
            print(Configuration.shared.tokenDescription)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
}
