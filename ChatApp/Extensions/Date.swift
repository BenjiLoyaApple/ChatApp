//
//  Date.swift
//  ChatApp
//
//  Created by Benji Loya on 13.08.2023.
//

import Firebase
import Foundation

extension Timestamp {
    func timestampString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self.dateValue(), to: Date()) ?? ""
    }
}

/*
extension Date {
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }
    
    private  var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }
    
    private func timeString() -> String {
        return timeFormatter.string(from: self)
    }
    
    private func dateString() -> String {
        return dayFormatter.string(from: self)
    }
    
    func timestampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return dateString()
        }
    }
    
        func timeAgoString() -> String {
            let currentDate = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.second, .minute, .hour, .day, .month], from: self, to: currentDate)
            
            if let days = components.day, days >= 5 {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM dd"
                return formatter.string(from: self)
            } else if let days = components.day, days >= 2 {
                return "\(days) days ago"
            } else if let days = components.day, days == 1 {
                return "yesterday"
            } else if let hours = components.hour, hours >= 2 {
                return "\(hours) hours ago"
            } else if let hours = components.hour, hours >= 1 {
                return "1 hour ago"
            } else if let minutes = components.minute, minutes >= 2 {
                return "\(minutes) min ago"
            } else if let minutes = components.minute, minutes >= 1 {
                return "1 minute ago"
            } else if let seconds = components.second, seconds >= 2 {
                return "\(seconds) sec ago"
            } else {
                return "just now"
            }
        }
    

    
}
*/
