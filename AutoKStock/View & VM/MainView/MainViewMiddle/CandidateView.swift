//
//  CandidateView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/26/24.
//

import SwiftUI

struct CandidateView: View {
    @Binding var vm: MainViewModel
    
    var body: some View {
        VStack {
            Text("후보 주식 목록")
                
            List {
                ForEach(vm.candidates, id: \.productCode) { stockInfo in
                    HStack {
                        Text("\(stockInfo.productCode) | \(stockInfo.name)")
                        
                        Spacer()
                        
                        Button(action: { vm.removeCandidate(candidate: stockInfo)} ) {
                            Text("⛔️")
                        }
                        .padding()
                        
                        Button(action: {
                            vm.moveToWatchList(candidate: stockInfo)
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

#Preview {
    CandidateView(vm: .constant(MainViewModel()))
}
