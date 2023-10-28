
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct CreateNewWallet_View: View {
   
    @Binding var walletName:String
    @State var checkBoxisOn:Bool = false
    
    @State var isUserPass_PIN_making:Bool = false
    
    public init(walletName: Binding<String>) {
        self._walletName = walletName
        //self._checkBoxisOn = checkBoxisOn
        //self._isUserPass_PIN_making = isUserPass_PIN_making
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
            if(self.checkBoxisOn == true) && (self.walletName.isEmpty == false){
                //===nút đi tới create new wallet view của gói API 1===//
                NavigationLink(destination:  PasscodeView_ConfirmPIN(textAskUserDo: "Enter PIN Number for your wallet",
                                                                     walletName:  $walletName,
                                                                     isUserPass_PIN_making: $isUserPass_PIN_making))
                {
                    Text("NEXT")
                        .foregroundColor(.white)
                        .padding(12)
                    
                }
                .background(Color.black)
                .cornerRadius(12)
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
