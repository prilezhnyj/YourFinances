//
//  FinancesViewModel.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.12.2022.
//

import Foundation

class FinancesViewModel: ObservableObject {
    
    // MARK: - Элементы, необходимы для создания новой операций
    @Published var selectedCategory = CategoryModel(title: "", image: "")
    @Published var operationAmount = ""
    @Published var operationDescription = ""
    
    // Флаг отвечающий за выбор операции в NewOperationView
    @Published var isMinus = true
    
    // Флаг отвечающий за раскрытие вьюшки и отображения всех категорий в ShowCategoriesView
    @Published var showFullCategories = false
    
    // Флаг отвечающий за раскрытие вьюшки Numpad в NewOperationView
    @Published var isPresentedNumpadView = false
    
    
    // MARK: - Детальное отображение операции на главном экране MainView
    @Published var currentItem = FinancesModel(type: .minus, amount: 0, category: CategoryModel(title: "", image: ""), description: "")
    
    // Флаг отвечающий за раскрытие Вью с детальной информации на главном экране MainView
    @Published var showItem = false
    
    
    // MARK: - Элементы для добавление новой категории
    @Published var titleCategory = ""
    @Published var imageCategory = ""
    
    // Флаг отвечающий за выбор операции в NewCategoryView
    @Published var isMinusNewCategory = true
    
    
    // MARK: - Массивы категорий
    @Published var categoryMinusArray = [
        CategoryModel(title: "Продукты", image: "🥬"),
        CategoryModel(title: "Транспорт", image: "🚎"),
        CategoryModel(title: "Дом", image: "🏠"),
        CategoryModel(title: "Сладости", image: "🍭"),
        CategoryModel(title: "Хобби", image: "👟")]
    
    @Published var categoryPlusArray = [
        CategoryModel(title: "Зарплата", image: "💰"),
        CategoryModel(title: "Донаты", image: "🤑"),
        CategoryModel(title: "Сбережения", image: "💸"),
        CategoryModel(title: "Инвестиции", image: "💶")]
    
    
    // MARK: - Массивы операций
    @Published var minusArray = [FinancesModel]()
    @Published var plusArray = [FinancesModel]()
    
    
    // MARK: - Операции с календарём
    @Published var currentDay = Date()
    @Published var currentWeek = [Date]()
    @Published var currentMonth = [Date]()
    private var calendar = Calendar.current
    
    
    // MARK: - Инициализатор
    init() {
        getCurrentWeek()
        mockData()
    }
    
    
    // MARK: - Тестовая фейковая дата
    // !!! После введения базы данных необходимо будет удалить
    func mockData() {
        minusArray.append(FinancesModel(type: .minus, amount: 647, category: CategoryModel(title: "Продукты", image: "🥬"), description: ""))
        plusArray.append(FinancesModel(type: .plus, amount: 34913, category: CategoryModel(title: "Зарплата", image: "💰"), description: ""))
    }
    
    
    // MARK: - Сохранение расхода / дохода
    func saveOperation() {
        guard let amountDouble = Double(operationAmount) else {
            print("Ошибка преобразования стринги в дабл")
            return
        }
        
        if isMinus == true {
            minusArray.append(FinancesModel(type: .minus, amount: amountDouble, category: selectedCategory, description: operationDescription))
            print("Сохранение расхода")
        } else {
            plusArray.append(FinancesModel(type: .plus, amount: amountDouble, category: selectedCategory, description: operationDescription))
            print("Сохранение дохода")
        }
    }
    
    // MARK: - Поиск элемента в массиве операций
    func findItem(value searchValue: FinancesModel, in array: [FinancesModel]) -> Int? {
        for (index, value) in array.enumerated() {
            if value.id == searchValue.id {
                return index
            }
        }
        return nil
    }
    
    // MARK: - Поиск категорий в массиве категории
    func findCategory(value searchValue: CategoryModel, in array: [CategoryModel]) -> Int? {
        for (index, value) in array.enumerated() {
            if value.id == searchValue.id {
                return index
            }
        }
        return nil
    }
    
    // MARK: - Удаление нужно категории
    func deleteCategory(item: CategoryModel) {
        // Флаг отвечающий за категория траты это или нет
        var isMinus: Bool? = false
        
        // Индекc элемента в каждой катеорий. Один из элементов должен быть nil
        let minusIndex = findCategory(value: item, in: categoryMinusArray)
        let plusIndex = findCategory(value: item, in: categoryPlusArray)
        
        // Проверка на nil
        if findCategory(value: item, in: categoryMinusArray) != nil {
            isMinus = true
        }
        
        // Проверка и удаление нужного элемента
        if isMinus! {
            categoryMinusArray.remove(at: minusIndex!)
        } else {
            categoryPlusArray.remove(at: plusIndex!)
        }
    }
    
    // MARK: - Удаление операций в детальном окне главного меню
    func deleteItem(item: FinancesModel) {
        if item.type == .minus {
            let index = findItem(value: item, in: minusArray)
            minusArray.remove(at: index!)
        } else {
            let index = findItem(value: item, in: plusArray)
            plusArray.remove(at: index!)
        }
    }
    
    // MARK: - Добавление новой категории
    func addNewCategory() {
        if isMinusNewCategory == true {
            categoryMinusArray.insert(CategoryModel(title: titleCategory, image: imageCategory), at: 0)
        } else {
            categoryPlusArray.insert(CategoryModel(title: titleCategory, image: imageCategory), at: 0)
        }
    }
    
    // MARK: - Получение суммы по архиву
    func getSum(for array: [FinancesModel]) -> Double {
        var amount: Double = 0
        
        for item in array {
            amount = amount + item.amount
        }
        
        return amount
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
        
        guard let firstDayWeek = week?.start else { return }
        
        (1...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstDayWeek) {
                currentWeek.append(weekDay)
            }
        }
    }
    
    // MARK: - Получение названия дня недели по дате
    func getTitleWeekDay(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date).capitalized
        return weekDay
    }
    
    // MARK: - Получение названия месяца для виджета
    func getTitleMonth(for date: Date) -> String {
        let components = calendar.dateComponents([.month], from: date)
        let month = components.month!
        
        let result: String
        
        switch month {
        case 1: result = "январь"
        case 2: result = "февраль"
        case 3: result = "март"
        case 4: result = "апрель"
        case 5: result = "май"
        case 6: result = "июнь"
        case 7: result = "июль"
        case 8: result = "август"
        case 9: result = "сентябрь"
        case 10: result = "октябрь"
        case 11: result = "ноябрь"
        default: result = "декабрь"
        }
        return result
    }
}
