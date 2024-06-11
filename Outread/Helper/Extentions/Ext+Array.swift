//
//  Ext+Array.swift
//  Outread
//
//  Created by AKASH BOGHANI on 09/06/24.
//

import Foundation

extension Array {
    func moveToFront(where condition: (Element) -> Bool) -> [Element] {
        guard let index = firstIndex(where: condition) else { return self }
        var array = self
        let element = array.remove(at: index)
        array.insert(element, at: 0)
        return array
    }
}
