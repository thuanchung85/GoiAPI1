
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct ChooseCreate_or_RecoveryWallet_View: View {
   
    @State var walletName = ""
    @State var checkBoxisOn = false
    
    public init() {
       
    }
    
    public var body: some View{
        VStack(alignment: .center) {
            
            Spacer()
            Text("ALL in One Dapp").font(.title)
            Text("Store and protect all your decentralized assets within a Dapp").font(.body)
            
            //nút đi tới create new wallet view
            Button {
                _ = CreateNewWallet_View(walletName: $walletName, checkBoxisOn: $checkBoxisOn)
            } label: {
                Text("Create New Wallet")
                    .font(.body)
            }.padding(.top, 20)
            
            //nút đi tới recovery wallet view
            Button {
                
            } label: {
                Text("Recovery Wallet!")
                    .font(.body)
            }
            .padding(.top, 20)
        }
        .padding(.bottom,50)
    }
    
    
    
    
}//end struct

