
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct MnemonicWordsView: View {
   
     var walletName:String
     var PIN_Number:String
    
    let data = (1...12).map { "\($0). item" }

    let columns = [
        GridItem(.fixed(100)),
        GridItem(.flexible()),
    ]
    
    //===INIT===///
    public init(walletName:String, PIN_Number:String) {
        self.walletName = walletName
        self.PIN_Number = PIN_Number
        print("TẠO 12 từ cho ví: ", self.walletName)
        print("ví có PIN: ", self.PIN_Number)
    }
    //====BODY====///
    public var body: some View{
        NavigationView {
            //Choose View
            VStack(alignment: .center) {
                Text("YOUR 12 MNEMONIC WORDS").font(.title)
                    .padding(10)
                Text("Below are 12 recovery words connected to your wallet. Please store it securely and never share it with anyone.")
                    .font(.footnote)
                    .padding(.bottom,10)
                
                
                ScrollView {
                           LazyVGrid(columns: columns, spacing: 20) {
                               ForEach(data, id: \.self) { item in
                                   Text(item)
                               }
                           }
                           .padding(.horizontal)
                       }
                       .frame(maxHeight: 500)
                
                
            }//end VStack
            .padding(.bottom,50)
            
        }
        //genegater 12 từ
        .onAppear(){
            DispatchQueue.main.async {
                let myWallet = Wallet()
                
                let HDWallet_1_Data = myWallet.create_HDWallet_BIP32_Init(accountName: self.walletName,password: self.PIN_Number)
                
                print("[String] wallet Data: ", HDWallet_1_Data)
                
                let retestWalletby12Words = myWallet.recover_HDWallet_BIP32_with12Words(with12Words: HDWallet_1_Data[1], newName: "newname")
                
                print("[reset] wallet address recover by 12 words: ", retestWalletby12Words)
            }
        }
    }//end body
    
    
    
    
}//end struct

