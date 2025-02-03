import Foundation

class ExerciseAPI {
    private let apiKey = "X-Api-Key"
    private let baseUrl = "https://api.api-ninjas.com/v1/exercises"
    
    // fetch
    func fetchExercises(for name: String, completion: @escaping ([[String: String]]?) -> Void) {
        let urlString = "\(baseUrl)?name=\(name)"  // Using muscle for search instead of name
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        

        var request = URLRequest(url: url)
        request.setValue("qhUDKW50ybuBG3XaGvavlOtCMnQx7kngZPnBnHB9" , forHTTPHeaderField: apiKey)  // Updated header key
//        request.allHTTPHeaderFields = [
//            apiKey: "qhUDKW50ybuBG3XaGvavlOtCMnQx7kngZPnBnHB9",
//        ]
        
//        let (data, _) = try await URLSession.shared.data(with: request)
        
        request.httpMethod  = "GET"

        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                            print(error)
//                        } else if let data = data ,let responseCode = response as? HTTPURLResponse {
//                            do {
//                              // Parse your response here.
//                                print("response")
////                               }
//                            }
////                                catch {
////                                print("error on parsing request to JSON")
////                            }
//                        }
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                // parse response as array of dictionaries
                // represents an exercise with keys like "name", "muscle", "equipment", etc.
                if let exercises = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
                    completion(exercises)
                } else {
                    completion(nil)
                }
            } catch {
                print("Failed to parse exercises: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
