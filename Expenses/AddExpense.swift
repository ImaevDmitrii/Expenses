//
//  AddExpense.swift
//  Expenses
//
//  Created by Дмитрий Имаев on 06.01.2023.
//

import SwiftUI


struct AddExpense: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
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
            
                .navigationBarTitle("Add Expense")
                .navigationBarItems(trailing: Button("Save"){
                    if let actualAmount = Int(self.amount) {
                        let item = ExpenseItem(name: self.name, curency: self.curency, amount: actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                })
        }
    }
    
    
    struct AddExpense_Previews: PreviewProvider {
        static var previews: some View {
            AddExpense(expenses: Expenses())
        }
    }
    
}
