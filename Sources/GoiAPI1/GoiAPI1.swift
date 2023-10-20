
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
            let s = String(data: wallet.data, encoding: . utf8)!
            return [wallet.address,wallet.name, s] + mnemonics
        } catch {
            print(error.localizedDescription)
            return [error.localizedDescription]
        }
    }
    
    //===hàm import account===//
    public func importAccount(by privateKey: String, name: String, password:String)  -> [String] {
        let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let dataKey = Data.fromHex(formattedKey)
        else { return ["error cannot get dataKey or EthereumKeystoreV3 by this privateKey"] }
        do{
            guard let keystore = try EthereumKeystoreV3(privateKey: dataKey, password: password)
            else{   return ["error cannot get dataKey or EthereumKeystoreV3 by this privateKey"]}
            
            guard let address = keystore.addresses?.first?.address
            else { return ["error cannot address by this privateKey"] }
            
            let keyData = try JSONEncoder().encode(keystore.keystoreParams)
            print("keyData get back by PrivateKey: ", keyData)
            let s = String(data: keyData, encoding: . utf8)!
            return [address, s]
        }
        catch{
            return ["error cannot get dataKey or EthereumKeystoreV3 by this privateKey"]
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
