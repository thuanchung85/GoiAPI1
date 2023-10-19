import Foundation
import web3swift
import Web3Core



public struct GoiAPI1 {
    public private(set) var text = "Hello, This is GoiAPI1!"

    public init() {
    }
    
    //===hàm chạy khởi tạo địa chỉ ví 0x..... trên iPhone===//
    public func hamChayThu_tao_keystore(passwordString:String) -> String{
        do {
         let keystore = try EthereumKeystoreV3.init(password: passwordString)
         
            return keystore?.addresses?.first?.address ?? "no data"
         } catch {
         print(error.localizedDescription)
         }
       return "no data"
    }
    
    //===hàm chạy khởi tạo 12 từ Mnemonic Phrase trên iPhone===//
    public func hamChayThu_tao_12Words(passwordString:String) -> [String]{
        do {
            let mnemonic = try BIP39.generateMnemonics(bitsOfEntropy: 256)!
            
            let keystore = try BIP32Keystore(mnemonics: mnemonic,
                                              password: passwordString,
                                              mnemonicsPassword: passwordString)
            
            return [mnemonic,keystore?.addresses?.first?.address ?? "no data"]
         } catch {
         print(error.localizedDescription)
         }
        return ["no data"]
    }
    
}
