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
    
    //==hàm chạy lấy số dư của một địa chỉ EthereumAddress===//
    public func hamChayThu_get_BalanceEthereumAddress(address:String) async -> [String]{
        do {
            
            let InfuraMainnetWeb3 = try await Web3.InfuraMainnetWeb3(accessToken: "b9ce386fa2b3415eb3df790155d24675")
            print("InfuraMainnetWeb3: ", InfuraMainnetWeb3)
            let balanceETH = try await InfuraMainnetWeb3.eth.getBalance(for: EthereumAddress(address)!)
                print("balanceETH: ", balanceETH)
            
            return [String(balanceETH)]
        }
        catch {
            print(error.localizedDescription)
        }
        return ["no data"]
    }
    
    //==hàm chạy lấy transactions của một địa chỉ EthereumAddress===//
    public func hamChayThu_get_TransactionEthereumAddress(address:String) async -> [String]{
        do {
            let InfuraMainnetWeb3 = try await Web3.InfuraMainnetWeb3(accessToken: "b9ce386fa2b3415eb3df790155d24675")
            
            let contract =  InfuraMainnetWeb3.contract(Web3Utils.erc20ABI, at: EthereumAddress(address)!, abiVersion: 2)?.transaction.hash.map({ item in
                String(item.hashValue)
            })
            print("contract: " ,contract as Any)
            return [contract!]
        }
        catch {
            print(error.localizedDescription)
        }
        return ["no data"]
    }
}//end struct
