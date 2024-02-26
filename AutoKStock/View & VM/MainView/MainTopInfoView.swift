//
//  MainTopInfoView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/26/24.
//

import SwiftUI

struct MainTopInfoView: View {
    @Binding var vm: MainViewModel
    
    var body: some View {
        HStack {
            Text(Configuration.shared.ismockEnvironment ? "모의투자" : "실전투자")
                .bold()
            
            Spacer()
            
            if let balance = vm.balance {
                Text("예수금: \(balance.output2[0].dncaTotAmt)")
                    .padding()
            }
            
            Button(action: { vm.revokeToken() }) {
                Text("토큰 폐기하기")
            }
            .padding()
            
            Button(action: { Configuration.shared.realTimeToken = nil } ) {
                Text("실시간 토큰 폐기하기")
            }
            .padding()
        }
    }
}

#Preview {
    MainTopInfoView(vm: .constant(MainViewModel()))
}
