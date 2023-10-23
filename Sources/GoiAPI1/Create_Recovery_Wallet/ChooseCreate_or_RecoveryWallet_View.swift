
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
        NavigationView {
            //Choose View
            VStack(alignment: .center) {
                
                Spacer()
                Text("ALL in One Dapp").font(.title)
                Text("Store and protect all your decentralized assets within a Dapp").font(.body)
                
                //nút đi tới create new wallet view
                NavigationLink(destination:  CreateNewWallet_View(walletName: $walletName, checkBoxisOn: $checkBoxisOn))
                {
                    Text("Create New Wallet")
                        .foregroundColor(.white)
                        .padding(12)
                    
                }
                .background(Color.black)
                .cornerRadius(12)
                
               
                
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
        //
    }
    
    
    
    
}//end struct

