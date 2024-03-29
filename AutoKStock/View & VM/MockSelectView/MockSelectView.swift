//
//  MockSelectView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import SwiftUI

struct MockSelectView: View {
    @State private var mockEnvironment = true
    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Picker("투자 환경", selection: $mockEnvironment) {
                    Text("모의 투자 환경")
                        .tag(true)
                    Text("실제 투자 환경")
                        .tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button(action: { goHomeView() } ) {
                    Text("입 장")
                }
            }
            .navigationDestination(for: Int.self, destination: { _ in
                MainView()
            })
        }
    }
    
    private func goHomeView() {
        Configuration.shared.ismockEnvironment = mockEnvironment
        
        if Configuration.shared.isTokenExpired {
            Task {
                do {
                    try await getToken()
                    path.append(0)
                } catch {
                    print(error.localizedDescription)
                    print("토큰 발급에 실패했습니다.")
                }
            }
        } else {
            path.append(0)
        }
    } 
    
    private func getToken() async throws {
        let response = try await TokenManager.shared.getToken()
        
        Configuration.shared.accessToken = response.accessToken
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        Configuration.shared.tokenExpiredDate = df.date(from: response.accessTokenTokenExpired)
    }
}

#Preview {
    MockSelectView()
}
