import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://out-read.com/wp-json/wc/v3/"
    
    // Fetching articles using WordPress API
    func fetchArticles() -> AnyPublisher<[Article], Error> {
        let urlString = "https://out-read.com/wp-json/wp/v2/article?_embed&per_page=30"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Article].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchArticleContent(from url: String, completion: @escaping (Article?) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            do {
                let article = try JSONDecoder().decode(Article.self, from: data)
                DispatchQueue.main.async {
                    completion(article)
                }
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // Fetching categories using WooCommerce API
    
    
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


