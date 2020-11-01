//
//  Foundation+RedditClient.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation

extension Date {
    
    var timeAgo: String? {
        let now = Date()
        let difference = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: self, to: now)
        let months = difference.month ?? 0
        let days = difference.day ?? 0
        let hours = difference.hour ?? 0
        let minutes = difference.minute ?? 0
        
        if months > 0 {
            return months > 1 ? "\(months) months ago" : "1 month ago"
        } else if days > 0 {
            return days > 1 ? "\(days) days ago" : "yesterday"
        } else if hours > 0 {
            return hours > 1 ? "\(hours) hours ago": "1 hour ago"
        } else if minutes > 0 {
            return minutes > 1 ? "\(minutes) minutes ago": "1 minute ago"
        } else {
            return "seconds ago"
        }
    }
}

extension String {
    
    var isImageUrl: Bool {
        let pathExtension = (self as NSString).pathExtension
        let imageFormats = ["jpg", "jpeg", "png", "gif"]
        return imageFormats.contains(pathExtension)
    }
    
}
