import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://out-read.com/wp-json/wc/v3/"
    
    func updateEmail(newEmail: String, completion: @escaping (Bool, Error?) -> Void) {
        // Replace with your actual API URL and request setup
        let url = URL(string: "https://yourapi.com/update-email")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": newEmail]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to update email: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } else {
                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? 500
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to update email"])
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
        }.resume()
    }
}


