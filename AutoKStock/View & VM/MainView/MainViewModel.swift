//
//  MainViewModel.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/26/24.
//

import Foundation

@Observable final class MainViewModel {
    var candidates = [StockInfo]()
    var searchResult: StockInfo?
    var watchList = [StockInfo]()
    var watchListInfo = [StockInfo: PricePerMinData]()
    var liveStock = Set<String>() // ProductCode
    var selectedStock: StockInfo?
    
    var balance: BalanceData?
    
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
    
    func searchStock(_ term: String) {
        if let _ = Int(term) {
            do {
                searchResult = try StockInfoManager.shared.getStockFromCode(productCode: term)
            } catch {
                searchResult = nil
                print(error.localizedDescription)
            }
        } else {
            do {
                searchResult = try StockInfoManager.shared.getStockFromName(name: term.uppercased())
            } catch {
                searchResult = nil
                print(error.localizedDescription)
            }
        }
    }
    
    func getSocketAccessKey() async {
        do {
            let data: RealTimeAccessTokenData = try await NetworkManager()
                .method(method: .POST)
                .path(.TokenURL(.socket))
                .addHeader(field: "content-type", value: "application/json; utf-8")
                .addBody(key: "grant_type", value: "client_credentials")
                .addBody(key: "appkey", value: Configuration.shared.AppKey)
                .addBody(key: "secretkey", value: Configuration.shared.AppSecret)
                .decode()
            Configuration.shared.realTimeToken = data.approvalKey
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getRealTimeConclusionPrice(productCode: String) {
        Task {
            if Configuration.shared.realTimeToken == nil {
                await getSocketAccessKey()
            }
            
            do {
                try WebSocketManager.shared.openWebSocket(path: .SocketURL(.realTimeConclusionPrice)) { data in
                    print("Data count \(data.count)")
                }
                sleep(1) // FIXME: 이 부분이 문제로 생기는 듯 여기서 뭔가 오차가 생김
                try WebSocketManager.shared.register(productNumber: productCode) { [weak self] in
                    guard let self else { return }
                    self.liveStock.insert(productCode)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getBalcne() async {
        do {
            self.balance = try await OrderManager.shared.fetchBalance()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func revokeToken() {
        Task {
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
    
    private func getPricePerMinute(stockInfo: StockInfo) async throws {
        let response = try await PriceManager.shared.getPricePerMin(productNumber: stockInfo.productCode)
        // TODO: 얻은 가격으로 무엇을 할 것인가?
        watchListInfo[stockInfo] = response
    }
    
    func moveToWatchList(candidate: StockInfo) {
        Task {
            do {
                try await getPricePerMinute(stockInfo: candidate)
                
                candidates.removeAll(where: {candidate == $0 })
                appendWatchList(candidate: candidate)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
