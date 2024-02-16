//
//  FirstSettingView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/16/24.
//

import SwiftUI

struct FirstSettingView: View {
    @State private var mockEnvironment = true {
        didSet {
            Configuration.shared.ismockEnvironment = mockEnvironment
        }
    }
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
                
                Button(action: { getToken() }, label: {
                    Text("입 장")
                })
            }
            .navigationDestination(for: Int.self, destination: { _ in
                Text("안뇽")
            })
        }
    }
    
    private func getToken() {
        Task {
            do {
                let response: IssueTokenOutput = try await NetworkManager()
                    .method(method: .POST)
                    .path(.issue)
                    .addBody(IssueTokenInput())
                    .decode()
                
                Configuration.shared.accessToken = response.accessToken
                
                withAnimation{
                    path.append(0)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    FirstSettingView()
}
