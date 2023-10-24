
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers
import Combine

public struct MnemonicWordsView: View {
   
     var walletName:String
     var PIN_Number:String
    @ObservedObject var myWallet: Wallet 
   
    @State var data12Words = (1...12).map { "\($0). item" }
    @State var addressWallet:String = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    //===INIT===///
    public init(walletName:String, PIN_Number:String) {
        self.walletName = walletName
        myWallet = Wallet(walletName: walletName)
        
        self.PIN_Number = PIN_Number
        print("TẠO 12 từ cho ví: ", self.walletName)
        print("ví có PIN: ", self.PIN_Number)
        
       
    }
    //====BODY====///
    public var body: some View{
        NavigationView {
            //Choose View
            VStack(alignment: .center) {
                Text("Your 12 words seed phrase").font(.title)
                    .padding(10)
                Text("Below are 12 recovery words connected to your wallet. Please store it securely and never share it with anyone.")
                    .font(.footnote)
                    .padding(.bottom,10)
                
                //12 từ trong khung
                ScrollView {
                           LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                               ForEach(data12Words, id: \.self) { item in
                                   Text(item)
                                       .frame(width: 130)
                                       .font(.body)
                                       .foregroundColor(.blue)
                                       .padding()
                                       .border(.blue)
                                       .cornerRadius(5)
                                        
                               }
                           }
                           .padding(.horizontal)
                       }
                       .frame(maxHeight: 500)
                
                //show address ví của user
                Text("Wallet Address:\n" + addressWallet).font(.body).padding(.horizontal)
                
                //nút next
                HStack(alignment: .center){
                    Spacer()
                    Button(action: {
                        
                        
                    }) {
                        VStack {
                            Text("NEXT")
                        }
                        .padding()
                        .accentColor(Color(.systemBlue))
                        .cornerRadius(4.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4).stroke(Color(.systemBlue), lineWidth: 2)
                        )
                    }
                    Spacer()
                }
                
            }//end VStack
           
            
        }
        //genegater 12 từ
        .onAppear(){
           
        }
    }//end body
    
    
    
    
}//end struct

