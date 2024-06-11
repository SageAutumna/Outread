import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://out-read.com/wp-json/wc/v3/"
    
    func fetchCategories(excludingParentID parentID: Int) -> AnyPublisher<[Category], Error> {
        let urlString = "\(baseURL)products/categories?consumer_key=\(Globals.CONUMER_KEY)&consumer_secret=\(Globals.CONUMER_SECRET)&per_page=100"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Category].self, decoder: JSONDecoder())
            .map { categories in
                categories.filter { (($0.parent ?? -1) != parentID ) && $0.colorCategory != ""}
            }
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Category], Error> in
                print("Decoding error: \(error)")
                return Just([]) // Return an empty array of Category
                    .setFailureType(to: Error.self) // Correctly set failure type to Error
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    
    // Fetching products using WooCommerce API
    func fetchProducts(completion: @escaping ([Product]?) -> Void) {
        let urlString = "\(baseURL)products?consumer_key=\(Globals.CONUMER_KEY)&consumer_secret=\(Globals.CONUMER_SECRET)"
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error: Response status code \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error: No data received")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let products = try decoder.decode([Product].self, from: data)
                completion(products)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchAllProducts(page:Int) -> AnyPublisher<[Product], Error> {
        let urlString = "\(baseURL)products?consumer_key=\(Globals.CONUMER_KEY)&consumer_secret=\(Globals.CONUMER_SECRET)&per_page=100&page=\(page)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .catch { error in
                Just([]).setFailureType(to: Error.self) // Convert to a failing publisher with an empty array on error
            }
            .eraseToAnyPublisher()
    }
    
    
    func fetchPlayList() -> AnyPublisher<[Playlist], Error> {
        let urlString = "\(baseURL)products/categories?parent=134&consumer_key=\(Globals.CONUMER_KEY)&consumer_secret=\(Globals.CONUMER_SECRET)&per_page=100"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [Playlist].self, decoder: JSONDecoder())
            .catch { error in
                Just([]).setFailureType(to: Error.self)
                // Convert to a failing publisher with an empty array on error
            }
            .eraseToAnyPublisher()
    }
    
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


