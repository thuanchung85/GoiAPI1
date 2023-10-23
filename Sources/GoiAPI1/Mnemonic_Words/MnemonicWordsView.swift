
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct MnemonicWordsView: View {
   
    let data = (1...100).map { "Item \($0)" }

       let columns = [
           GridItem(.fixed(100)),
           GridItem(.flexible()),
       ]
    
    public init() {
      
    }
    
    public var body: some View{
        NavigationView {
            //Choose View
            VStack(alignment: .center) {
                Text("YOUR 12 MNEMONIC WORDS").font(.caption)
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
                       .frame(maxHeight: 300)
                
                
            }//end VStack
            .padding(.bottom,50)
            
        }
        //
    }
    
    
    
    
}//end struct

