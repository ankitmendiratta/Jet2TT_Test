//
//  Date.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

extension Date {
    
    func dateToString(format : Formatters) -> String?{
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.get()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}

extension String{
    
    func stringToDate(format : Formatters) -> Date?{
        
        let formatter = DateFormatter()
        formatter.dateFormat =  format.get()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
        
    }
}

extension Date{
    func compareWith (date : Date) -> String?{
        
        let components = Calendar.current.dateComponents([.hour,.day,.month, .minute, .second], from: date, to: self)
        let hours = components.hour ?? 0
        let day = components.day ?? 0
        let month = components.month ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        if month == 0{
            if day == 0{
                if hours == 0{
                    if minutes == 0{
                        return "\(abs(seconds)) Sec Ago"
                    }else{
                        return  "\(abs(minutes)) Min Ago"
                    }
                }else{
                    return  "\(abs(hours)) Hours Ago"
                }
            }else{
                return "\(abs(day)) Day Ago"
            }
        }else{
            return "\(abs(month)) Month Ago"
        }
    }
}

extension Double {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self / 1000))
    }
}


extension UIDatePicker {
    func setPastDateValidation() {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.second = 2
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year =  150
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.minimumDate = maxDate
        self.maximumDate = minDate
    }
}
