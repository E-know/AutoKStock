//
//  FirstSettingView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import SwiftUI

struct FirstSettingView: View {
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
                HomeView()
            })
        }
    }
    
    private func goHomeView() {
        Configuration.shared.ismockEnvironment = mockEnvironment
        
        Task {
            await getToken()
            path.append(0)
        }
    }
    
    private func getToken() async {
        do {
            let response: IssueTokenData = try await NetworkManager()
                .method(method: .POST)
                .path(URLType.TokenURL(.issue))
                .addBody(IssueTokenBody())
                .decode()
            
            Configuration.shared.accessToken = response.accessToken
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    FirstSettingView()
}
