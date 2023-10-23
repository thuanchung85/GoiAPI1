
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct CreateNewWallet_View: View {
   
    @Binding var walletName:String
    @Binding var checkBoxisOn:Bool
    
    public init(walletName: Binding<String>, checkBoxisOn : Binding<Bool>) {
        self._walletName = walletName
        self._checkBoxisOn = checkBoxisOn
    }
    
    public var body: some View{
         
        VStack(alignment: .center) {
            
            //phần title và nút back
            HStack(alignment: .center){
                ZStack(alignment: .leading){
                    HStack(alignment: .center){
                        Spacer()
                        Text("CREATE NEW WALLET").font(.title)
                        Spacer()
                    }
                    
                    //nút back
                    Button {
                        
                    } label: {
                        Text("Back")
                            .font(.body)
                    }.padding(.top, 20)
                    
                }
            }
            
            
            Text("WALLET NAME").font(.title)
            TextField("Enter your wallet name", text: $walletName).font(.body)
            
            Text("PROTECT YOUR WALLET").font(.title)
            Text("Add one or more security layer to protect your crypto assets").font(.body)
            
            //check box
            Toggle(isOn: $checkBoxisOn) {
                       Text("I have read and agree to the Term of service and Privacy policy")
                   }
            .toggleStyle(CheckboxToggleStyle())
            
            //nút NEXT
            Button {
               
            } label: {
                Text("NEXT")
                    .font(.body)
            }.padding(.top, 20)
            
           
            
        }
        .padding(.bottom,50)
    }
    
    
    
    
}//end struct

// Define a custom toggle style to make our Toggle look like a checkbox
struct CheckboxToggleStyle: ToggleStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()
      Image(systemName: configuration.isOn ? "checkmark.square" : "square")
        .resizable()
        .frame(width: 24, height: 24)
        .onTapGesture { configuration.isOn.toggle() }
    }
  }
}
