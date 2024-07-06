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
            
            /*
             // Extract and style headings (h2)
             if let headings = try body?.select("h1") {
             for heading in headings {
             let headingText = try heading.text()
             let headingAttributedString = NSMutableAttributedString(string: headingText + "\n\n", attributes: [
             .font: UIFont.boldSystemFont(ofSize: 24)
             ])
             arr.append(ListType(str1: headingAttributedString.string, str2: ""))
             }
             } else if let headings = try body?.select("h2") {
             for heading in headings {
             let headingText = try heading.text()
             let headingAttributedString = NSMutableAttributedString(string: headingText + "\n\n", attributes: [
             .font: UIFont.boldSystemFont(ofSize: 24)
             ])
             arr.append(ListType(str1: headingAttributedString.string, str2: ""))
             }
             } else if let headings = try body?.select("h3") {
             for heading in headings {
             let headingText = try heading.text()
             let headingAttributedString = NSMutableAttributedString(string: headingText + "\n\n", attributes: [
             .font: UIFont.boldSystemFont(ofSize: 24)
             ])
             arr.append(ListType(str1: headingAttributedString.string, str2: ""))
             }
             } else if let headings = try body?.select("h4") {
             for heading in headings {
             let headingText = try heading.text()
             let headingAttributedString = NSMutableAttributedString(string: headingText + "\n\n", attributes: [
             .font: UIFont.boldSystemFont(ofSize: 24)
             ])
             arr.append(ListType(str1: headingAttributedString.string, str2: ""))
             }
             } else if let headings = try body?.select("h5") {
             for heading in headings {
             let headingText = try heading.text()
             let headingAttributedString = NSMutableAttributedString(string: headingText + "\n", attributes: [
             .font: UIFont.boldSystemFont(ofSize: 24)
             ])
             arr.append(ListType(str1: headingAttributedString.string, str2: ""))
             }
             }
             */
            
            // Extract and style paragraphs
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

