//
//  HomeView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/17/24.
//

import SwiftUI

struct HomeView: View {
    @State var balance: BalanceData?
    @State var productNumber = ""
    @State var searchResult: CurrentStockPriceData?
    
    var body: some View {
        VStack {
            HStack {
                Text(Configuration.shared.ismockEnvironment ? "모의투자" : "실전투자")
                    .bold()
                Spacer()
                if let balance {
                    Text("예수금: \(balance.output2[0].dncaTotAmt)")
                        .padding()
                }
                
                Button(action: { Task { await revokeToken()}}) {
                    Text("토큰 폐기하기")
                }
                .padding()
            }
            .padding()
            
            HStack {
                VStack {
                    TextField("종목번호로 검색하세요.", text: $productNumber)
                        .onSubmit { Task {
                            self.searchResult = try await PriceManager.shared.(productNumber: productNumber)
                            print(searchResult)
                        }
                        }
                    if let searchResult {
                        
                    }
                }
            }
            
            Spacer()
        }
        .task {
            do {
                self.balance = try await OrderManager.shared.fetchBalance()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func revokeToken() async {
        do {
            let response = try await TokenManager.shared.revokeToken()
            Configuration.shared.accessToken = nil
            print(response.message)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    HomeView()
}
