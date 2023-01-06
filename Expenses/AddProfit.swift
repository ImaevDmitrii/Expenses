//
//  AddProfit.swift
//  Expenses
//
//  Created by Дмитрий Имаев on 06.01.2023.
//

import SwiftUI

struct AddProfit: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var profit: Profit
    @State private var name = ""
    @State private var curency = "TL"
    @State private var amount = ""
    
    let types = ["TL","$","USDT"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Curency", selection: $curency) {
                    ForEach(self.types, id: \.self) {
                        Text($0)
                    }
                    
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add Profit")
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = Int(self.amount) {
                    let item = ProfitItem(name: self.name, curency: self.curency, amount: actualAmount)
                    self.profit.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            })
        }
        
    }
    
    struct AddProfit_Previews: PreviewProvider {
        static var previews: some View {
            AddProfit(profit: Profit())
        }
    }
}
