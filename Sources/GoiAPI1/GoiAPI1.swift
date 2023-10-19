import Foundation
import web3swift
import Web3Core



public struct GoiAPI1 {
    public private(set) var text = "Hello, This is GoiAPI1!"

    public init() {
    }
    
    public func hamChayThu_tao_keystore(passwordString:String) -> String{
        do {
         let keystore = try EthereumKeystoreV3.init(password: passwordString)
            let string1 = keystore?.addresses
            
            let returnString = string1?.first?.address
            return returnString ?? "no data"
         } catch {
         print(error.localizedDescription)
         }
       return "no data"
    }
    
    
}
