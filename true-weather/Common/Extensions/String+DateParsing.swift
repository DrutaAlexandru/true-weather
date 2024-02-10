//
//  String+DateParsing.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

extension String {
    func formatDateToDayName(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        guard let date = dateFormatter.date(from: self) else {
            return "Invalid Date"
        }
        
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Now"
        } else {
            let dayOfWeek = calendar.component(.weekday, from: date)
            let weekdaySymbols = calendar.shortWeekdaySymbols
            let dayName = weekdaySymbols[dayOfWeek - 1]
            return dayName
        }
    }
}
