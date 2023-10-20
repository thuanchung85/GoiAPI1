
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
    
    //===hàm chạy khởi tạo HDWALLET dạng data là BIP32Keystore..... trên iPhone===//
    public func create_HDWallet_BIP32_Init(accountName: String, password:String? = "")  -> [Data?]  {
        do {
            guard let mnemonicsString = try BIP39.generateMnemonics(bitsOfEntropy: 256)
            else {return [nil]}
            print("mnemonicsString : ", mnemonicsString)
            guard let keystore = try BIP32Keystore(mnemonics: mnemonicsString, password: password!, mnemonicsPassword: "", language: .english)
            else {return [nil]}
            
            guard let address = keystore.addresses?.first?.address
            else {return [nil]}
            
            let keyData = try JSONEncoder().encode(keystore.keystoreParams)
           
            let mnemonics = mnemonicsString.split(separator: " ").map(String.init)
            print("mnemonics array: ", mnemonics)
           
            let wallet = Web3Wallet(address: address, data: keyData, name: accountName, type: .hd(mnemonics: mnemonics))
            print("wallet: -> " , wallet.data)
            let d = wallet.data
            return [d]
        } catch {
            print(error.localizedDescription)
            return [nil]
        }
    }
    
    //===hàm chạy nhập 12 từ để tái tạo lại ví HDWALLET..... trên iPhone===//
    public func recover_HDWallet_BIP32_with12Words(with12Words: String, newName:String ,password:String? = "")  -> [Data?]  {
        do {
             let mnemonicsString = with12Words
            print("mnemonicsString FOR RECOVERY WALLET: ", mnemonicsString)
            guard let keystore = try BIP32Keystore(mnemonics: mnemonicsString, password: password!, mnemonicsPassword: "", language: .english)
            else {return [nil]}
            
            guard let address = keystore.addresses?.first?.address
            else {return [nil]}
            
            let keyData = try JSONEncoder().encode(keystore.keystoreParams)
           
            let mnemonics = mnemonicsString.split(separator: " ").map(String.init)
            print("mnemonics array: ", mnemonics)
           
            let wallet = Web3Wallet(address: address, data: keyData, name: newName, type: .hd(mnemonics: mnemonics))
            print("wallet data RECOVERY: -> " , wallet.data)
            let d = wallet.data
            return [d]
        } catch {
            print(error.localizedDescription)
            return [nil]
        }
    }
    
    
    //==hàm export account PrivateKey của dạng BIP32==//
    public func exportPrivatekey_HDWALLET_BIP32(walletData: Data, password:String)  -> [String]
    {
        let keystore = BIP32Keystore(walletData)
        print("BIP32Keystore: " , keystore as Any)
        let address = keystore?.addresses?.first
        let km = KeystoreManager([keystore!])
        
        do{
            let key = try km.UNSAFE_getPrivateKeyData(password: password, account: address!).toHexString()
            print("THIS IS YOUR PRIVATE KEY")
            return [key]
        }
        catch{
            return ["error exportAccount_PrivateKeyType : keyStoreManager.UNSAFE_getPrivateKeyData not ok"]
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
