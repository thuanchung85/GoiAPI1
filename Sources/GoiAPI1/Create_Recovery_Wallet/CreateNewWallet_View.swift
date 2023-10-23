
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
         
        VStack(alignment: .leading)
        {
         
            //phần nhập tên ví
            VStack(alignment: .leading){
                Text("WALLET NAME").font(.title)
                TextField("Enter your wallet name", text: $walletName)
                    .font(.body)
                    .textFieldStyle(.roundedBorder)
            }
            
           
            //phần nhắc nhở
            VStack(alignment: .leading){
                Text("PROTECT YOUR WALLET").font(.title)
                Text("Add one or more security layer to protect your crypto assets").font(.body)
            }.padding(.top, 15)
            
            //phần check box ok
            VStack(alignment: .leading){
                Toggle(isOn: $checkBoxisOn) {
                    Text("I have read and agree to the Term of service and Privacy policy").font(.footnote)
                }
                .toggleStyle(CheckboxToggleStyle())
                
                
            }
            Spacer()
            
            //nút NEXT
            HStack(alignment: .center){
                Spacer()
                Button(action: {
                    
                }) {
                    VStack {
                        Text("NEXT")
                    }
                    .padding()
                    .accentColor(Color(.systemBlue))
                    .background(Color(UIColor.systemRed.withAlphaComponent(0.4)))
                    .cornerRadius(4.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4).stroke(Color(.systemBlue), lineWidth: 2)
                    )
                }
                Spacer()
            }
           
            
        }
        .padding(.bottom,50)
    }
    
    
    
    
}//end struct

// Define a custom toggle style to make our Toggle look like a checkbox
struct CheckboxToggleStyle: ToggleStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    HStack {
      Image(systemName: configuration.isOn ? "checkmark.square" : "square")
        .resizable()
        .frame(width: 24, height: 24)
        .onTapGesture { configuration.isOn.toggle() }
        
        configuration.label.padding(.leading,10)
    }
  }
}
