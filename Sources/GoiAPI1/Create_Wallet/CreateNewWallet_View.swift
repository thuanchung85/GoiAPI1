
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct CreateNewWallet_View: View {
   
    @Binding var walletName:String
    @Binding var walletAddress:String
    
    @Binding var isUserPass_MakeNewWalletView:Bool
    @Binding var isBack:Bool
    
    @State var checkBoxisOn:Bool = false
    @State var isShow_PasscodeView_ConfirmPIN = false
    @State var isUserPass_PIN_making:Bool = false
    
    //==init==//
    public init(walletName: Binding<String>,walletAddress: Binding<String>, isUserPass_MakeNewWalletView:Binding<Bool>, isBack:Binding<Bool>) {
        self._walletName = walletName
        self._isUserPass_MakeNewWalletView = isUserPass_MakeNewWalletView
        self._walletAddress = walletAddress
        self._isBack = isBack
    }
    
    //==BODY==//
    public var body: some View{
         
        //mới vô show nhập tên ví và ok thì mới cho next button hiện ra
        if(self.isShow_PasscodeView_ConfirmPIN == false){
            
            
            VStack(alignment: .leading)
            {
                //title
                HStack(alignment: .center){
                    Spacer()
                    Button(action: {
                        //call PasscodeView_ConfirmPIN
                        self.isBack = true
                    }) {
                        Text("<")
                            .padding()
                            .foregroundColor(.white)
                    }
                    .background(Color.green)
                    .cornerRadius(30)
                    
                    Text("Create a New Wallet")
                        .font(.custom("Arial Bold", size: 20))
                        .padding(.bottom, 20)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                        .scaledToFit()
                        .minimumScaleFactor(0.05)
                    Spacer()
                }
                
                //phần nhập tên ví
                VStack(alignment: .leading){
                    Text("WALLET NAME")
                        .font(.custom("Arial ", size: 22))
                        .padding(.bottom,5)
                    TextField("Enter your wallet name", text: $walletName)
                        .font(.body)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                }
                
                
                //phần nhắc nhở
                VStack(alignment: .leading){
                    Text("PROTECT YOUR WALLET")
                        .font(.custom("Arial ", size: 22))
                        .padding(.bottom,5)
                    Text("Add one or more security layer to protect your crypto assets")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }.padding(.vertical, 20)
                Spacer()
                //phần check box ok
                VStack(alignment: .leading){
                    Toggle(isOn: $checkBoxisOn) {
                        Text("I have read and agree to the Term of service and Privacy policy").font(.footnote)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    
                    
                }
                Spacer()
                
                //nút Create PIN code đi tới nhập mã PIN view
                if(self.checkBoxisOn == true) && (self.walletName.isEmpty == false){
                    HStack{
                        Spacer()
                        Button(action: {
                            //call PasscodeView_ConfirmPIN
                            self.isShow_PasscodeView_ConfirmPIN = true
                        }) {
                            Text("Next")
                                .padding()
                                .foregroundColor(.white)
                        }
                        .background(Color.green)
                        .cornerRadius(30)
                        Spacer()
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
                PasscodeView_ConfirmPIN(textAskUserDo: "Put in your pin number",
                                        textAskUserDo2: "(This pincode will unlock your Pools wallet only on this device)",
                                        walletName:  $walletName,
                                        isUserPass_PIN_making: $isUserPass_PIN_making)
            }
            
            //nếu user pass Bước Nhập mã PIN, thì show tiếp view 12 từ seed
            if(self.isUserPass_PIN_making == true)
            {
                //call trang tạo 12 từ khóa
                MnemonicWordsView(walletName: walletName, walletAddress:$walletAddress,
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
              .renderingMode(.template)
              .foregroundColor(.blue)
            
              .frame(width: 24, height: 24)
              .onTapGesture {
                  configuration.isOn.toggle()
              }
              
          configuration.label.padding(.leading,10)
      }
  }
}
