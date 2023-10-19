import Foundation
import web3swift
import Web3Core


func json(from object:Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
        return nil
    }
    return String(data: data, encoding: String.Encoding.utf8)
}


public struct GoiAPI1 {
    public private(set) var text = "Hello, This is GoiAPI1!"

    public init() {
    }
    
    public func hamChayThu_tao_keystore() -> String{
        do {
         let keystore = try EthereumKeystoreV3.init(password: "12345")
            let string1 = keystore?.addresses
            let json_string1 = json(from:string1 as Any)
            
            
            let returnString = json_string1
            return returnString ?? "no data"
         } catch {
         print(error.localizedDescription)
         }
       return "no data"
    }
    
    
}
