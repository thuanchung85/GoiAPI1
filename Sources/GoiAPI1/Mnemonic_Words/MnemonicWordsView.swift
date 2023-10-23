
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct MnemonicWordsView: View {
   
     var walletName:String
     var PIN_Number:String
    
    @State var data12Words = (1...12).map { "\($0). item" }

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
                Text("Your 12-word seed phrase").font(.title)
                    .padding(10)
                Text("Below are 12 recovery words connected to your wallet. Please store it securely and never share it with anyone.")
                    .font(.footnote)
                    .padding(.bottom,10)
                
                
                ScrollView {
                           LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                               ForEach(data12Words, id: \.self) { item in
                                   Text(item)
                                       .frame(width: 100)
                                       .font(.body)
                                       .foregroundColor(.blue)
                                       .padding()
                                       .overlay(
                                               RoundedRectangle(cornerRadius: 16)
                                                   .stroke(.blue, lineWidth: 2)
                                           )
                                        
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
                let array_12Words = HDWallet_1_Data[1].split(separator: " ").map(String.init)
                self.data12Words = array_12Words.enumerated().map { (index, element) in
                    return "\(index + 1): \(element)"
                }
                
                let retestWalletby12Words = myWallet.recover_HDWallet_BIP32_with12Words(with12Words: HDWallet_1_Data[1], newName: "newname")
                
                print("[reset] wallet address recover by 12 words: ", retestWalletby12Words)
            }
        }
    }//end body
    
    
    
    
}//end struct

