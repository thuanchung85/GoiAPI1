
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct CreateNewWallet_View: View {
   
    @Binding var walletName:String
    @Binding var checkBoxisOn:Bool
    @Binding var isUserPass_ChooseCreate_or_RecoveryWallet_View:Bool
    
    public init(walletName: Binding<String>, checkBoxisOn : Binding<Bool>, isUserPass_ChooseCreate_or_RecoveryWallet_View: Binding<Bool>) {
        self._walletName = walletName
        self._checkBoxisOn = checkBoxisOn
        self._isUserPass_ChooseCreate_or_RecoveryWallet_View = isUserPass_ChooseCreate_or_RecoveryWallet_View
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
                HStack(alignment: .center){
                    Spacer()
                    Button(action: {
                        //Ok xác nhận user đã pass qua giai đoạn tạo name và check xác nhận
                        //tryền biến isUserPass_ChooseCreate_or_RecoveryWallet_View về cho view bên ngoài
                        isUserPass_ChooseCreate_or_RecoveryWallet_View = true
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
