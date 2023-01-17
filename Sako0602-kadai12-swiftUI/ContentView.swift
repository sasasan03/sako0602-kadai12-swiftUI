//
//  ContentView.swift
//  Sako0602-kadai12-swiftUI
//
//  Created by sako0602 on 2023/01/08.
//

import SwiftUI


struct ContentView: View {
    
    @State private var nonTaxPriceText = ""
    @State private var taxNumText = ""
    @State private var totalPrice = 0
    
    let KeyZeiritsu = "zeiritsu"
    
    var body: some View {
        VStack {
            HStack{
                Text("税抜価格")
                TextField("", text: $nonTaxPriceText)
                    .keyboardType(.numberPad)
                    .frame(width: 70,height: 30)
                    .border(Color.black)
                Text("円")
            }
            .padding()
            
            HStack{
                Text("消費税率")
                TextField("", text: $taxNumText)
                    .keyboardType(.numberPad)
                    .frame(width: 70,height: 30)
                    .border(Color.black)
                Text("%")
            }
            .padding()
            
            Button("計算"){
                calculation()
                UserDefaults.standard.set(taxNumText, forKey: KeyZeiritsu )
            }
            .padding()
            
            HStack{
                Text("税込金額")
                Text("\(totalPrice)")
                Text("円")
            }
            .padding()
            .onAppear(){
                //UserDefaults.standard.string()だけだと適切に保存できていない場合がある。
                //３つなど複数保存したい場合はset関数をよび、１回synchronize()を呼ぶ。
                //synchronize()確実に保存したい場合に呼ぶ。
                guard let storageTaxNumText = UserDefaults.standard.string(forKey: KeyZeiritsu ) ,UserDefaults.standard.synchronize() else {
                    return
                }
                taxNumText = storageTaxNumText
            }
        }
    }
    
  private  func calculation() {
        let unwrappedNonTaxPrice = Double(nonTaxPriceText) ?? 0
        let unwrappedTaxNumText = Double(taxNumText) ?? 0
        let taxRate = (unwrappedTaxNumText + 100) / 100
        totalPrice = Int(unwrappedNonTaxPrice * taxRate)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
