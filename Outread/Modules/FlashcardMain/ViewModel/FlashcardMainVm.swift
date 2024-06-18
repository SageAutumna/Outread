//
//  FlashcardMainVm.swift
//  Outread
//
//  Created by AKASH BOGHANI on 17/06/24.
//

import UIKit

@MainActor
final class FlashcardMainVm: ObservableObject {
    //MARK: - Properties
    @Published var articleContent: String?
    @Published var list = [ListType]()
    private var taskDisposeBag = TaskBag()
    private let networkHandler: NetworkServices
    
    //MARK: - Life-Cycle
    init(networkHandler: NetworkServices = NetworkHandler()) {
        self.networkHandler = networkHandler
    }
    
    //MARK: - Functions
    func loadArticle(name: String) {
        Task {
            do {
                let str = try await networkHandler.fetchArticleByTitle(name: name)
                if let content = str {
                    articleContent = content.htmlToString
                    list = content.extractParagraphs()
                }
            } catch let error as APIError {
                UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.description)
            } catch {
                UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
            }
        }
    }
}

extension String {
    func extractParagraphs() -> [ListType] {
        let bodyStrings = self.allStringsBetween(start: "<p>", end: "</p>")
        var result = [ListType]()
        
        for paragraph in bodyStrings {
            if let paragraph = paragraph as? String {
                if paragraph.count < 100 {
                    result.append(ListType(str1: paragraph.htmlToString, str2: ""))
                } else {
                    if var last = result.popLast() {
                        last.str2 += "\n\(paragraph.htmlToString)"
                        result.append(last)
                    }
                }
            }
        }
        
        return result.filter { !$0.str2.isEmpty }
    }
}
