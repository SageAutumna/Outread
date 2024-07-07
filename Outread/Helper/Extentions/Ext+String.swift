//
//  Ext+String.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import UIKit
import SwiftSoup

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

extension String {
    func setStyledTextFromHtml() -> [ListType] {
        var arr = [ListType]()
        do {
            let document: Document = try SwiftSoup.parse(self)
            let body = document.body()
            
            if let paragraphs = try body?.select("p") {
                for element in paragraphs {
                    if let style = try? element.attr("style"), style.contains("font-size") {
                        if let fontSizeValue = style.split(separator: ";").first(where: { $0.contains("font-size") })?.split(separator: ":").last {
                            if let fontSize = Int(fontSizeValue.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "px", with: "")), fontSize >= 25 {
                                let text = try element.text()
                                arr.append(ListType(str1: text, str2: ""))
                            } else {
                                if var last = arr.popLast() {
                                    let text = try element.text()
                                    last.str2 += text
                                    arr.append(last)
                                }
                            }
                        } else {
                            if var last = arr.popLast() {
                                let text = try element.text()
                                last.str2 += text
                                arr.append(last)
                            }
                        }
                    } else if element.children().count > 0 {
                        for child in element.children() {
                            if let style = try? child.attr("style"), style.contains("font-size") {
                                if let fontSizeValue = style.split(separator: ";").first(where: { $0.contains("font-size") })?.split(separator: ":").last {
                                    if let fontSize = Int(fontSizeValue.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "px", with: "")), fontSize >= 25 {
                                        let text = try element.text()
                                        arr.append(ListType(str1: text, str2: ""))
                                    } else {
                                        if var last = arr.popLast() {
                                            let text = try element.text()
                                            last.str2 += text
                                            arr.append(last)
                                        }
                                    }
                                } else {
                                    if var last = arr.popLast() {
                                        let text = try element.text()
                                        last.str2 += text
                                        arr.append(last)
                                    }
                                }
                            } else if child.children().count > 0 {
                                for subChild in child.children() {
                                    if let subStyle = try? subChild.attr("style"), subStyle.contains("font-size") {
                                        if let fontSizeValue = subStyle.split(separator: ";").first(where: { $0.contains("font-size") })?.split(separator: ":").last {
                                            if let fontSize = Int(fontSizeValue.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "px", with: "")), fontSize >= 25 {
                                                let text = try element.text()
                                                arr.append(ListType(str1: text, str2: ""))
                                            }  else {
                                                if var last = arr.popLast() {
                                                    let text = try element.text()
                                                    last.str2 += text
                                                    arr.append(last)
                                                }
                                            }
                                        }  else {
                                            if var last = arr.popLast() {
                                                let text = try element.text()
                                                last.str2 += text
                                                arr.append(last)
                                            }
                                        }
                                    } else {
                                        if var last = arr.popLast() {
                                            let text = try element.text()
                                            last.str2 += text
                                            arr.append(last)
                                        }
                                    }
                                }
                            } else {
                                if var last = arr.popLast() {
                                    let text = try element.text()
                                    last.str2 += text
                                    arr.append(last)
                                }
                            }
                        }
                    } else {
                        if var last = arr.popLast() {
                            let text = try element.text()
                            last.str2 += text
                            arr.append(last)
                        }
                    }
                }
            }
            
            if let divTag = try body?.select("div") {
                let paragraphs = try divTag.select("p")
                for element in paragraphs {
                    let strongParas = try element.select("strong")
                    
                    for strongpara in strongParas {
                        let text = try strongpara.text()
                        let textAttributedString = NSMutableAttributedString(string: text, attributes: [
                            .font: UIFont.boldSystemFont(ofSize: 24)
                        ])
                        if !textAttributedString.string.contains("Figure") {
                            arr.append(ListType(str1: textAttributedString.string, str2: ""))
                        }
                    }
                    
                    if var last = arr.popLast() {
                        let text = try element.text()
                        last.str2 += text
                        arr.append(last)
                    }
                }
            }
        } catch {
            print("Error parsing HTML: \(error)")
        }
        
        return arr
    }
}

extension String {
    // MARK: - isEmail
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }
    }

    // MARK: - isPhoneNumber
    var isPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return false
        }
        if let match = detector.matches(in: self, options: [], range: NSRange(location: 0, length: count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }

    // MARK: - isValidPassword
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }
    }
}

