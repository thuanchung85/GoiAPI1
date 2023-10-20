import Foundation
import web3swift
import Web3Core
import SwiftUI


public class GoiAPI1: ObservableObject {
    @Published var bip32keystore:BIP32Keystore?
    @Published var keystoremanager:KeystoreManager?
    @Published var InfuraMainnetWeb3: Web3?
    
    let userDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]+"/keystore/"
    
    public init() async {
        do{
            InfuraMainnetWeb3 = try await Web3.InfuraMainnetWeb3(accessToken: "b9ce386fa2b3415eb3df790155d24675")
            keystoremanager =  KeystoreManager.managerForPath(userDirPath, scanForHDwallets: true, suffix: "json")
            print("CONNECTED -> INFURA")
        } catch {
        print(error.localizedDescription)
        }
    }
    
    //===hàm chạy khởi tạo địa chỉ ví 0x..... trên iPhone===//
    //===hàm chạy khởi tạo 12 từ Mnemonic Phrase trên iPhone===//
    public func hamChayThu_tao_12Words(passwordString:String) async -> [String]{
        do {
            let mnemonic = try BIP39.generateMnemonics(bitsOfEntropy: 256)!
            
            //let keystore = try BIP32Keystore(mnemonics: mnemonic,password: passwordString,mnemonicsPassword: passwordString)
            
            InfuraMainnetWeb3!.addKeystoreManager(keystoremanager)
            self.bip32keystore = self.keystoremanager?.bip32keystores[0]
            let address = self.bip32keystore?.addresses?.first?.address
            
            return [mnemonic,address ?? "no data"]
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
            
            let transactionCount_pending =  try await InfuraMainnetWeb3.eth.getTransactionCount(for: EthereumAddress(address)!,onBlock: .pending)
            let transactionCount_earliest =  try await InfuraMainnetWeb3.eth.getTransactionCount(for: EthereumAddress(address)!,onBlock: .earliest)
            let transactionCount_latest =  try await InfuraMainnetWeb3.eth.getTransactionCount(for: EthereumAddress(address)!,onBlock: .latest)
          
            print("contract.transactionCount_pending: " , transactionCount_pending)
            print("contract.transactionCount_earliest: " , transactionCount_earliest)
            print("contract.transactionCount_latest: " , transactionCount_latest)
            return [" "]
        }
        catch {
            print(error.localizedDescription)
        }
        return ["no data"]
    }
}//end struct
