//
//  ContentView.swift
//  Expenses
//
//  Created by Дмитрий Имаев on 06.01.2023.
//

import SwiftUI


struct ProfitItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let curency: String
    let amount: Int
}

class Profit: ObservableObject {
    @Published var items = [ProfitItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "ItemsProfit")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "ItemsProfit"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ProfitItem].self, from: items){
                self.items = decoded
                return
            }
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let curency: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "ItemsExpense")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "ItemsExpense"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }
    }
}


struct ContentView: View {
    @State private var showingAddExpense = false
    @State private var showingAddProfit = false
    @ObservedObject var expenses = Expenses()
    @ObservedObject var profit = Profit()
    
    var body: some View {
        NavigationView {
            VStack{
                Text ("Profit")
                    .font(.title)
                    .fontDesign(.serif)
                
                List {
                    ForEach (profit.items) { item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                            }
                            Spacer()
                            Text(item.curency)
                            Text("\(item.amount)")
                        }
                    }
                    .onDelete(perform: removeProfitItems)
                }
                Text ("Expense")
                    .font(.title)
                    .fontDesign(.serif)
                List {
                    ForEach (expenses.items) { item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                            }
                            Spacer()
                            Text(item.curency)
                            Text("\(item.amount)")
                        }
                    }
                    .onDelete(perform: removeExpensesItems)
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.showingAddProfit = true
                } ) {
                    Image(systemName: "plus")
                }
                )
                .sheet(isPresented: $showingAddProfit) {
                    AddProfit(profit: self.profit)
                }
                
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.showingAddExpense = true
                } ) {
                    Image(systemName: "minus")
                }
                )
                .sheet(isPresented: $showingAddExpense) {
                    AddExpense(expenses: self.expenses)
                }
            }
        }
    }
    
    
    func removeExpensesItems(as offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removeProfitItems(as offsets: IndexSet) {
        profit.items.remove(atOffsets: offsets)
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}


