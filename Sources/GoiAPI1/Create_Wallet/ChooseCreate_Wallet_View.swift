
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct ChooseCreate_Wallet_View: View {
   
    @State var walletName = ""
    @State var checkBoxisOn = false
    @Binding var isUserPass_ChooseCreateWallet_View:Bool
    
    
    public init(isUserPass_ChooseCreateWallet_View: Binding<Bool>) {
        self._isUserPass_ChooseCreateWallet_View = isUserPass_ChooseCreateWallet_View
    }
    
    public var body: some View{
        NavigationView {
            //Choose View
            VStack(alignment: .center) {
                
                Spacer()
                Text("ALL in One Dapp").font(.title)
                Text("Store and protect all your decentralized assets within a Dapp").font(.body)
                
                //nút đi tới create new wallet view
                NavigationLink(destination:  CreateNewWallet_View(walletName: $walletName,
                                                                  checkBoxisOn: $checkBoxisOn,
                                                                  isUserPass_ChooseCreateWallet_View: $isUserPass_ChooseCreateWallet_View
                                                                 ))
                {
                    Text("Create New Wallet")
                        .foregroundColor(.white)
                        .padding(12)
                    
                }
                .background(Color.black)
                .cornerRadius(12)
                
            }
            .padding(.bottom,50)
            
        }
        //
    }
    
    
    
    
}//end struct

