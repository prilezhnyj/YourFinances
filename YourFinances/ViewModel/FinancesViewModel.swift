//
//  FinancesViewModel.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.12.2022.
//

import SwiftUI

class FinancesViewModel: ObservableObject {
    
    // MARK: - Элементы, необходимы для создания новой операций
    @Published var selectedCategory = CategoryModel(title: "", image: "", locKey: "")
    @Published var operationAmount = ""
    
    // Флаг отвечающий за выбор операции в NewOperationView
    @Published var isExpense = true
    
    // Флаг отвечающий за раскрытие вьюшки и отображения всех категорий в ShowCategoriesView
    @Published var showAllCategories = false
    
    // Флаг отвечающий за раскрытие вьюшки Numpad в NewOperationView
    @Published var showNumpadView = false
    
    
    // MARK: - Детальное отображение операции на главном экране MainView
    @Published var currentItemForDetailedInformation = FinancesModel(type: .minus, amount: 0, category: CategoryModel(title: "", image: "", locKey: ""), date: Date())
    
    // Флаг отвечающий за раскрытие Вью с детальной информации на главном экране MainView
    @Published var showDetailedInformation = false
    
    // MARK: - Элементы для добавление новой категории
    @Published var newTitleCategory = ""
    @Published var newImageCategory = ""
    
    // Флаг отвечающий за выбор операции в NewCategoryView
    @Published var isExpenseNewCategory = true
    
    
    // MARK: - Массивы категорий
    @Published var expenseCategoriesArray = [
        CategoryModel(title: "Products", image: "🥬", locKey: "products"),
        CategoryModel(title: "Transport", image: "🚎", locKey: "transport"),
        CategoryModel(title: "House", image: "🏠", locKey: "house"),
        CategoryModel(title: "Sweets", image: "🍭", locKey: "sweets"),
        CategoryModel(title: "Hobby", image: "👟", locKey: "hobby")]
    
    @Published var profitsCategoriesArray = [
        CategoryModel(title: "Salary", image: "💰", locKey: "salary"),
        CategoryModel(title: "Donations", image: "🤑", locKey: "donations"),
        CategoryModel(title: "Savings", image: "💸", locKey: "savings"),
        CategoryModel(title: "Investment", image: "💶", locKey: "investment")]
    
    // MARK: - Массивы операций
    @Published var expenseArray = [FinancesModel]()
    @Published var profitsArray = [FinancesModel]()
    @Published var currentExpenseArray = [FinancesModel]()
    @Published var currentProfitsArray = [FinancesModel]()
    
    // MARK: - Операции с календарём
    private var calendar = Calendar.current
    @Published var currentDay = Date()
    @Published var selectedDayWeek = Date()
    @Published var currentWeek = [Date]()
    @Published var currentMonth = [Date]()
    
    // MARK: - Инициализатор
    init() {
        getCurrentWeek()
        mockData()
        filterOperationsDay()
    }
    
    func mockData() {
        expenseArray.append(FinancesModel(type: .minus, amount: 239, category: CategoryModel(title: "Products", image: "🥬", locKey: "products"), date: .now))
        profitsArray.append(FinancesModel(type: .plus, amount: 239, category: CategoryModel(title: "fdfd", image: "dfdd", locKey: "transport"), date: Date(timeIntervalSince1970: 1674326827)))
    }
    
    // MARK: - Сохранение расхода / дохода
    func saveOperation() {
        guard let amountDouble = Double(operationAmount) else {
            print("Ошибка преобразования стринги в дабл")
            return
        }
        
        if isExpense == true {
            expenseArray.append(FinancesModel(type: .minus, amount: amountDouble, category: selectedCategory, date: currentDay))
            print("Сохранение расхода")
        } else {
            profitsArray.append(FinancesModel(type: .plus, amount: amountDouble, category: selectedCategory, date: currentDay))
            print("Сохранение дохода")
        }
        
        filterOperationsDay()
    }
    
    // MARK: - Поиск элемента в массиве операций
    func findItem(item searchItem: FinancesModel, in array: [FinancesModel]) -> Int? {
        for (index, item) in array.enumerated() {
            if item.id == searchItem.id {
                return index
            }
        }
        return nil
    }
    
    // MARK: - Поиск категорий в массиве категории
    func findCategory(category searchCategory: CategoryModel, in array: [CategoryModel]) -> Int? {
        for (index, category) in array.enumerated() {
            if category.id == searchCategory.id {
                return index
            }
        }
        return nil
    }
    
    // MARK: - Удаление нужно категории
    func deleteCategory(category: CategoryModel) {
        // Флаг отвечающий за категория траты это или нет
        var isExpense: Bool? = false
        
        // Индекc элемента в каждой катеорий. Один из элементов должен быть nil
        let expenseCategories = findCategory(category: category, in: expenseCategoriesArray)
        let profitsCategories = findCategory(category: category, in: profitsCategoriesArray)
        
        // Проверка на nil
        if findCategory(category: category, in: expenseCategoriesArray) != nil {
            isExpense = true
        }
        
        // Проверка и удаление нужного элемента
        if isExpense! {
            expenseCategoriesArray.remove(at: expenseCategories!)
        } else {
            profitsCategoriesArray.remove(at: profitsCategories!)
        }
    }
    
    // MARK: - Удаление операций в детальном окне главного меню
    func deleteItem(item: FinancesModel) {
        if item.type == .minus {
            let index = findItem(item: item, in: expenseArray)
            expenseArray.remove(at: index!)
        } else {
            let index = findItem(item: item, in: profitsArray)
            profitsArray.remove(at: index!)
        }
        
        filterOperationsDay()
    }
    
    // MARK: - Добавление новой категории
    func addNewCategory() {
        if isExpenseNewCategory == true {
            expenseCategoriesArray.insert(CategoryModel(title: newTitleCategory, image: newImageCategory, locKey: newTitleCategory.lowercased()), at: 0)
        } else {
            profitsCategoriesArray.insert(CategoryModel(title: newTitleCategory, image: newImageCategory, locKey: newTitleCategory.lowercased()), at: 0)
        }
    }
    
    // MARK: - Получение суммы по архиву
    func getAmount(for array: [FinancesModel]) -> Double {
        var amount: Double = 0
        
        for item in array {
            amount = amount + item.amount
        }
        
        return amount
    }
    
    // MARK: - Получение сохранённой сумммы
    func getGapBetweenAmounts(for profitArray: [FinancesModel], and expenseArray: [FinancesModel]) -> Double {
        var profitAmount: Double = 0
        var expenseAmount: Double = 0
        
        for item in profitArray {
            profitAmount = profitAmount + item.amount
        }
        
        for item in expenseArray {
            expenseAmount = expenseAmount + item.amount
        }
        
        return profitAmount - expenseAmount
    }
    
    // MARK: - Получение процента потраченых денег от все суммы для прогрессБара на виджет
    func getPercentageTotalAmount() -> CGFloat {
        let expenseAmount = getAmount(for: expenseArray)
        let profitAmount = getAmount(for: profitsArray)
        let res = 100 / (profitAmount / expenseAmount)
        return 1 - (res / 100)
    }
    
    // MARK: - Получение текущей даты
    func getCurrentDate(for date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // MARK: - Получение текущей недели
    func getCurrentWeek() {
        let today = Date()
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        let firstDayWeek = week?.start
        
        (1 ... 7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstDayWeek!) {
                currentWeek.append(weekDay)
            }
        }
    }
    
    // MARK: - Общая формула с форматом даты
    func extractDate(for date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // MARK: - Получения сегодняшнего дня. Если TRUE, то день закрашивается чёрным
    func isToday(for date: Date) -> Bool {
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func filterOperationsDay() {
        DispatchQueue.global(qos: .userInteractive).async {
            let expenseFilter = self.expenseArray.filter { item in
                return self.calendar.isDate(item.date, inSameDayAs: self.selectedDayWeek)
            }
            
            let profitFilter = self.profitsArray.filter { item in
                return self.calendar.isDate(item.date, inSameDayAs: self.selectedDayWeek)
            }
            
            DispatchQueue.main.async {
                self.currentExpenseArray = expenseFilter
                self.currentProfitsArray = profitFilter
            }
            
        }
    }
    
    // MARK: - Получение названия месяца для виджета
    func getTitleMonth(for date: Date) -> LocalizedStringKey {
        let components = calendar.dateComponents([.month], from: date)
        let month = components.month!
        
        let result: LocalizedStringKey
        
        switch month {
        case 1: result = "january"
        case 2: result = "february"
        case 3: result = "march"
        case 4: result = "april"
        case 5: result = "may"
        case 6: result = "june"
        case 7: result = "july"
        case 8: result = "august"
        case 9: result = "september"
        case 10: result = "october"
        case 11: result = "november"
        default: result = "december"
        }
        return result
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
