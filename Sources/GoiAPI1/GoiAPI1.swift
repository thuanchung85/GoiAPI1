import Foundation
import web3swift
import Web3Core




public struct GoiAPI1 {
    public private(set) var text = "Hello, This is GoiAPI1!"

    public init() {
    }
    
    public func hamChayThu_tao_keystore(){
        do {
         let keystore = try EthereumKeystoreV3.init(password: "12345")
            print("hamChayThu_tao_keystore: ", keystore as Any)
         } catch {
         print(error.localizedDescription)
         }
       
    }
    
    
}
