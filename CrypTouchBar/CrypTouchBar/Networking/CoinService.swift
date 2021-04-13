import SwiftyJSON
import Foundation

enum Response {
    case success(data: Data)
    case failure(error: Error)
}

class CoinService {
    static let shared = CoinService()

    private init() {}

    private let currentPriceApi = "https://api.binance.com/api/v3"
    
    func getAllSymbols(completion: @escaping ((BinanceSymbolsResponse) -> Void), onError: ((String) -> Void)? = nil) {
        let api = "\(currentPriceApi)/exchangeInfo"
        sendGetRequest(forApi: api, completion: { response in
            switch response {
            case .success(let data):
                guard let jsonData = try? JSON(data: data),
                      let response = BinanceSymbolsResponse.decode(fromJson: jsonData) else {
                    onError?("Something went wrong")
                    return
                }
                completion(response)
            case .failure(let error):
                onError?((error as NSError).localizedDescription)
            }

        })
    }

    func getCurrentPrice(symbol: String,
                         completion: ((DisplayCoin) -> Void)?,
                         onError: ((String) -> Void)? = nil) {
        let api = "\(currentPriceApi)/ticker/price?symbol=\(symbol)"
        sendGetRequest(forApi: api, completion: { response in
            switch response {
            case .success(let data):
                guard let jsonData = try? JSON(data:  data),
                      let response = DisplayCoin.decode(fromJson: jsonData) else {
                    onError?("Something went wrong")
                    return
                }
                
                completion?(response)
            case .failure(let error):
                onError?((error as NSError).localizedDescription)
            }
        })
    }

    private func sendGetRequest(forApi api: String, completion: ((Response) -> Void)?) {
        let url = URL(string: api)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data {
                completion?(Response.success(data: data))
            } else if let error = error {
                completion?(Response.failure(error: error))
            }
        }

        task.resume()
    }
    
}
