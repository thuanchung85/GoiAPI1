
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct MnemonicWordsView: View {
   
    @Binding var walletName:String
    @Binding var PIN_Number:String
    
    let data = (1...12).map { "\($0). item" }

    let columns = [
        GridItem(.fixed(100)),
        GridItem(.flexible()),
    ]
    
    //===INIT===///
    public init(walletName: Binding<String>, PIN_Number:Binding<String>) {
        self._walletName = walletName
        self._PIN_Number = PIN_Number
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
                var myWallet = Wallet()
                
                let HDWallet_1_Data = myWallet.create_HDWallet_BIP32_Init(accountName: self.walletName,password: self.PIN_Number)
                let convertData =  String(data:HDWallet_1_Data.first!!, encoding: . utf8)!
                print("convert wallet Data: ", convertData)
            }
        }
    }//end body
    
    
    
    
}//end struct

