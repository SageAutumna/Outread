//
//  Ext+String.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import UIKit

extension String {
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}

extension String {
    var htmlToString: String {
        guard let data = data(using: .utf8) else { return "" }
        do {
            let nsAttributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return nsAttributedString.string
        } catch {
            print("Error:", error)
            return ""
        }
    }
}

extension String{
    func allStringsBetween(start: String, end: String) -> [Any] {
        var strings = [Any]()
        var startRange: NSRange = (self as NSString).range(of: start)
        
        while true {
            if startRange.location != NSNotFound {
                var targetRange = NSRange()
                targetRange.location = startRange.location + startRange.length
                targetRange.length = self.count - targetRange.location
                let endRange: NSRange = (self as NSString).range(of: end, options: [], range: targetRange)
                if endRange.location != NSNotFound {
                    targetRange.length = endRange.location - targetRange.location
                    strings.append((self as NSString).substring(with: targetRange))
                    var restOfString =  NSRange()
                    restOfString.location = endRange.location + endRange.length
                    restOfString.length = self.count - restOfString.location
                    startRange = (self as NSString).range(of: start, options: [], range: restOfString)
                } else {
                    break
                }
            } else {
                break
            }
        }
        return strings
    }
}

