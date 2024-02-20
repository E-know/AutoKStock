//
//  HomeView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/17/24.
//

import SwiftUI

struct HomeView: View {
    @State var balance: BalanceData?
    @State var productTerm = ""
    var vm = HomeViewModel()
    
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
                    TextField("종목번호, 혹은 이름으로 검색하세요.", text: $productTerm)
                        .onSubmit {
                            vm.setCandidate(term: productTerm)
                        }
                    
                    if let searchResult = vm.searchResult {
                        Text(searchResult.name)
                        
                        Button(action: { vm.appendCandidate(candidate: searchResult) } ) {
                            Text("➡️")
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(width: Configuration.shared.screenSize.width / 3)
                
                VStack {
                    if vm.candidates.count > 0 {
                        Text("후보 주식 목록")
                        
                        HStack {
                            List {
                                ForEach(vm.candidates, id: \.productCode) { stockInfo in
                                    HStack {
                                        Text("\(stockInfo.productCode) | \(stockInfo.name)")
                                        
                                        Spacer()
                                        
                                        Button(action: { vm.removeCandidate(candidate: stockInfo)} ) {
                                            Text("⬅️")
                                        }
                                        .padding()
                                        
                                        Button(action: {
                                            Task {
                                                let response = try await PriceManager.shared.getPricePerMin(productNumber: stockInfo.productCode)
                                                // TODO: 얻은 가격으로 무엇을 할 것인가?
                                                vm.moveCandidateToWatchList(candidate: stockInfo)
                                            }
                                        } ) {
                                            Text("➡️")
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .frame(width: Configuration.shared.screenSize.width / 3)
                
                VStack {
                    if vm.watchList.count > 0 {
                        Text("주시 주식 목록")
                        
                        HStack {
                            List {
                                ForEach(vm.watchList, id: \.productCode) { stockInfo in
                                    HStack {
                                        Text("\(stockInfo.productCode) | \(stockInfo.name)")
                                        
                                        Spacer()
                                        
                                        Button(action: { vm.removeWatchList(candidate: stockInfo)} ) {
                                            Text("⬅️")
                                        }
                                        .padding()
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .frame(width: Configuration.shared.screenSize.width / 3)
            }
            
            Spacer()
        }
        .task {
            print(Configuration.shared.tokenDescription)
            do {
                self.balance = try await OrderManager.shared.fetchBalance()
            } catch {
                print(error.localizedDescription)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func revokeToken() async {
        do {
            let response = try await TokenManager.shared.revokeToken()
            Configuration.shared.accessToken = nil
            Configuration.shared.tokenExpiredDate = nil
            print(response.message)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    HomeView()
}

@Observable final class HomeViewModel {
    var candidates = [StockInfo]()
    var searchResult: StockInfo?
    var watchList = [StockInfo]()
    
    func appendCandidate(candidate: StockInfo) {
        searchResult = nil
        candidates.append(candidate)
    }
    
    func removeCandidate(candidate: StockInfo) {
        candidates.removeAll(where: { candidate == $0 })
    }
    
    func moveCandidateToWatchList(candidate: StockInfo) {
        candidates.removeAll(where: {candidate == $0 })
        appendWatchList(candidate: candidate)
    }
    
    func appendWatchList(candidate: StockInfo) {
        watchList.append(candidate)
    }
    
    func removeWatchList(candidate: StockInfo) {
        watchList.removeAll(where: {candidate == $0})
        appendCandidate(candidate: candidate)
    }
    
    func setCandidate(term: String) {
        
        if let _ = Int(term) {
            do {
                searchResult = try StockInfoManager.shared.getStockFromName(productCode: term)
            } catch {
                searchResult = nil
                print(error.localizedDescription)
            }
        } else {
            do {
                searchResult = try StockInfoManager.shared.getStockFromCode(name: term.uppercased())
            } catch {
                searchResult = nil
                print(error.localizedDescription)
            }
        }
    }
}
