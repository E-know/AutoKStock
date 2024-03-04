//
//  SearchView.swift
//  AutoKStock
//
//  Created by Inho Choi on 2/26/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var vm: MainViewModel
    @State var term = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("종목번호 혹은 이름으로 검색하세요.")
            
            TextField("ex) 삼성전자, 000270", text: $term)
                .onSubmit {
                    vm.searchStock(term)
                }
            
            if let searchResult = vm.searchResult {
                List {
                    ForEach(searchResult, id: \.productCode) {
                        SearchResultCell(data: $0)
                    }
                }
            }
            
            Spacer()
        }
    }
    
    private func SearchResultCell(data: StockInfo) -> some View {
        HStack {
            Text(data.name)
            
            Text("|")
                .padding()
            
            Text(data.productCode)
            
            Spacer()
                .frame(maxWidth: 30)
            
            Button(action: { vm.appendCandidate(candidate: data) } ) {
                Text("➡️")
            }
        }
    }
}

#Preview {
    SearchView(vm: .constant(MainViewModel()))
}
