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
    func allStringsBetween(start: String, end: String) -> [String] {
        var strings = [String]()
        var startRange: NSRange = (self as NSString).range(of: start)
        
        while startRange.location != NSNotFound {
            var targetRange = NSRange(location: startRange.location + startRange.length,
                                      length: self.count - (startRange.location + startRange.length))
            let endRange: NSRange = (self as NSString).range(of: end, options: [], range: targetRange)
            
            if endRange.location != NSNotFound {
                targetRange.length = endRange.location - targetRange.location
                var foundString = (self as NSString).substring(with: targetRange)
                foundString = foundString.replacingOccurrences(of: "\n", with: "")
                foundString = foundString.trimmingCharacters(in: .whitespacesAndNewlines)
                strings.append(foundString)
                
                let restOfStringRange = NSRange(location: endRange.location + endRange.length,
                                                    length: self.count - (endRange.location + endRange.length))
                startRange = (self as NSString).range(of: start, options: [], range: restOfStringRange)
            } else {
                break
            }
        }
        
        return strings
    }
}

