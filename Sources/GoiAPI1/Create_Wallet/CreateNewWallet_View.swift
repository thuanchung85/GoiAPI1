
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct CreateNewWallet_View: View {
   
    @Binding var walletName:String
    @Binding var isUserPass_MakeNewWalletView:Bool
    
    
    @State var checkBoxisOn:Bool = false
    @State var isShow_PasscodeView_ConfirmPIN = false
    @State var isUserPass_PIN_making:Bool = false
    
    public init(walletName: Binding<String>, isUserPass_MakeNewWalletView:Binding<Bool>) {
        self._walletName = walletName
        self._isUserPass_MakeNewWalletView = isUserPass_MakeNewWalletView
        
    }
    
    public var body: some View{
         
        //mới vô show nhập tên ví và ok thì mới cho next button hiện ra
        if(self.isShow_PasscodeView_ConfirmPIN == false){
            
            
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
                    Button(action: {
                        //call PasscodeView_ConfirmPIN
                        self.isShow_PasscodeView_ConfirmPIN = true
                    }) {
                        VStack {
                            Text("NEXT")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                        }
                        .padding(5)
                        .accentColor(Color(.red))
                    }
                    
                    
                }
                
            }//end VStack
            
        }//end if
        
        
        //nếu user nhập xong tên và bấm next thì tới nhập mã Pin view
        if(self.isShow_PasscodeView_ConfirmPIN == true)
        {
            //Nếu user chưa pass nhập mã Pin thì còn ở view nhập mã PIN
            if(self.isUserPass_PIN_making == false){
                //===nút đi tới create new wallet view của gói API 1===//
                PasscodeView_ConfirmPIN(textAskUserDo: "Enter PIN Number for your wallet",
                                        walletName:  $walletName,
                                        isUserPass_PIN_making: $isUserPass_PIN_making)
            }
            
            //nếu user pass Bước Nhập mã PIN, thì show tiếp view 12 từ seed
            if(self.isUserPass_PIN_making == true)
            {
                //call trang tạo 12 từ khóa
                MnemonicWordsView(walletName: walletName,
                                  PIN_Number: String(decoding: keychain_read(service: "PoolsWallet_KeyChain_PIN", account: walletName) ?? Data(), as: UTF8.self),
                                  isUserPass12SeedsWordView: $isUserPass_MakeNewWalletView )
                
            }
        }//end if
        
       
        
    }//end Body
    
   
    
    
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
