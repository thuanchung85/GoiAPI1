
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct CreateWalletView: View {
   
    
    public init() {
       
    }
    
    public var body: some View{
         
        VStack(alignment: .center) {
            Text("ALL in One Dapp")
            Text("Store and protect all your decentralized assets within a Dapp")
            
            Button {
                
            } label: {
                Text("Create New Wallet")
                    .font(.body)
            }
            
            
            Button {
                
            } label: {
                Text("Recovery Wallet!")
                    .font(.body)
            }
        }
    }
    
    
    
    
}//end struct

