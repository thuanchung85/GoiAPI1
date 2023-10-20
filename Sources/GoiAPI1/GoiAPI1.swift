
import Foundation
import web3swift
import Web3Core

struct Web3Wallet: Equatable {
    let address: String
    let data: Data
    let name: String
    let type: WalletType
}
enum WalletType: Equatable {
    case normal
    case hd(mnemonics: [String])
}


public class GoiAPI1: ObservableObject {
    
    
    public init()  {
      
    }
    
    //===hàm chạy khởi tạo account..... trên iPhone===//
    public func createAccount(accountName: String, password:String)  -> [String]  {
        do {
            guard let mnemonicsString = try BIP39.generateMnemonics(bitsOfEntropy: 256)
            else {return ["no data: mnemonicsString error"]}
            
            guard let keystore = try BIP32Keystore(mnemonics: mnemonicsString, password: password, mnemonicsPassword: "", language: .english)
            else {return ["no data: keystore error"]}
            
            guard let address = keystore.addresses?.first?.address
            else {return ["no data: address error"]}
            
            let keyData = try JSONEncoder().encode(keystore.keystoreParams)
            print("keyData : ", keyData)
            let mnemonics = mnemonicsString.split(separator: " ").map(String.init)
            print("mnemonics : ", mnemonics)
           
            let wallet = Web3Wallet(address: address, data: keyData, name: accountName, type: .hd(mnemonics: mnemonics))
            print("wallet: -> " , wallet)
            return [wallet.address,wallet.name] + mnemonics
        } catch {
            print(error.localizedDescription)
            return [error.localizedDescription]
        }
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
    
   
  
}//end struct
