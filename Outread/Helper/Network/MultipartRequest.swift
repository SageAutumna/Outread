//
//  MultipartRequest.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 17/12/23.
//

import Foundation

/**
 * A struct for creating multipart/form-data requests.
 */
public struct MultipartRequest {
    // MARK: - Properties
    /**
     The boundary used to separate parts of the request.
     */
    public let boundary: String
    private let separator: String = "\r\n"
    private var data: Data

    // MARK: - Life cycle
    /**
     Initializes a new instance with the specified boundary.

     - Parameter boundary: The boundary to use for separating parts of the request.
     */
    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        data = .init()
    }

    // MARK: - Functions
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }

    private mutating func appendSeparator() {
        data.append(separator)
    }

    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }

    /**
     Adds a new part to the request with the specified key and value.

     - Parameter key: The name of the part.
     - Parameter value: The value of the part.
     */
    public mutating func add(key: String, value: String) {
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }

    /**
     Adds a new file part to the request with the specified key, file name, and file data.

     - Parameter key: The name of the part.
     - Parameter fileName: The name of the file.
     - Parameter fileMimeType: The MIME type of the file.
     - Parameter fileData: The data of the file.
     */
    public mutating func add(key: String, fileName: String, fileMimeType: String, fileData: Data) {
        appendBoundarySeparator()
        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }

    /**
     Returns the value to use for the Content-Type header of the HTTP request.

     - Returns: The value for the Content-Type header.
     */
    public var httpContentTypeHeadeValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    /**
     Returns the data to use for the HTTP request body.

     - Returns: The data for the HTTP request body.
     */
    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}
