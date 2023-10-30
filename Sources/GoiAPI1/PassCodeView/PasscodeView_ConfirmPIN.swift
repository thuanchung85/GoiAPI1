
import SwiftUI


public struct PasscodeView_ConfirmPIN : View {
    
    @Binding var isUserPass_PIN_making:Bool
    
    @Binding var walletName:String
    @State var password:String = ""
    @State var passwordBuoc1:String = ""

    @State var isShowConFirmPassCodeView:Bool = false
    
    var textAskUserDo:String
    var textAskUserDo2:String
    
    //===INIT====///
    public init(textAskUserDo:String,textAskUserDo2:String,walletName: Binding<String>, isUserPass_PIN_making:Binding<Bool>) {
        self._walletName = walletName
        self.textAskUserDo = textAskUserDo
        self.textAskUserDo2 = textAskUserDo2
        self._isUserPass_PIN_making = isUserPass_PIN_making
    }
    
    //===BODY====//
    public var body: some View{
        //Bước 1: hiện page cho user nhập mã PIN trước
        if (isShowConFirmPassCodeView == false){
            VStack{
                
               
                
                Text(textAskUserDo)
                    .font(.custom("Arial ", size: 22))
                    .padding(.top,10)
                Text(textAskUserDo2)
                    .font(.custom("Arial ", size: 18))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.vertical,20)
                
                HStack(spacing: 22){
                    
                    // Password Circle View...
                    
                    ForEach(0..<6,id: \.self){index in
                        
                        PasswordView2(index: index, password: $password)
                    }
                }
                // for smaller size iphones...
                .padding(.top,10)
                
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                    
                    // Password Button ....
                    
                    ForEach(1...9,id: \.self){value in
                        
                        PasswordButton2(value: "\(value)",password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                    }
                    
                    PasswordButton2(value: "delete.fill",password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                    
                    PasswordButton2(value: "0", password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                }
                .padding(.bottom)
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
        //Bước 2: hiện page cho user confirm mã PIN sau khi bước 1 ok
        else{
            VStack{
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.top,20)
                
                Text("Please Confirm your PIN number")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.top,20)
                    .foregroundColor(.red)
                
                HStack(spacing: 15){
                    
                    // Password Circle View...
                    
                    ForEach(0..<6,id: \.self){index in
                        
                        PasswordView3(index: index, password: $password)
                    }
                }
                // for smaller size iphones...
                .padding(.top,10)
                
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                    
                    // Password Button ....
                    
                    ForEach(1...9,id: \.self){value in
                        
                        PasswordButton3(value: "\(value)",password: $password, passwordBuoc1: $passwordBuoc1, walletName: $walletName, isUserPass_PIN_making: $isUserPass_PIN_making)
                    }
                    
                    PasswordButton3(value: "delete.fill",password: $password, passwordBuoc1: $passwordBuoc1, walletName: $walletName, isUserPass_PIN_making: $isUserPass_PIN_making)
                    
                    PasswordButton3(value: "0", password: $password, passwordBuoc1: $passwordBuoc1, walletName: $walletName, isUserPass_PIN_making: $isUserPass_PIN_making)
                }
                .padding(.bottom)
                
                
                //Reset lại Pin nếu user quên mất lần nhập ở bước 1
                Button {
                    print("Reset your Passcode! return lại bước 1")
                    isShowConFirmPassCodeView = false
                    password.removeAll()
                } label: {
                    Text("Reset your Passcode!")
                        .font(.body)
                       
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

//================//////////

struct PasswordView2 : View {
    
    var index : Int
    @Binding var password : String
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.black,lineWidth: 1)
                .frame(width: 25, height: 25)
            
            // checking whether it is typed...
            
            if password.count > index{
                
                Circle()
                    .fill(Color.black)
                    .frame(width: 25, height: 25)
            }
        }
    }
}


//================//////////

struct PasswordView3 : View {
    
    var index : Int
    @Binding var password : String
    
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.red,lineWidth: 1)
                .frame(width: 25, height: 25)
            
            // checking whether it is typed...
            
            if password.count > index{
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 25, height: 25)
            }
        }
    }
}


///////////////========================////////////
struct PasswordButton2 : View {
    
    var value : String
    @Binding var password : String
    @Binding var passwordBuoc1 : String
    @Binding var isShowConFirmPassCodeView:Bool
    
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    ZStack{
                        Rectangle()
                            .frame(width: 30, height: 30)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        
                        Image(systemName: "delete.left")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                           
                           
                        
                    }
                }
                else{
                    ZStack{
                        Rectangle()
                            .frame(width: 30, height: 30)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        
                        Text(value)
                            .font(.body)
                            .foregroundColor(.black)
                           
                    }
                }
            }
            .padding()

        })
    }
    
    func setPassword(){
        
        // checking if backspace pressed...
        
        withAnimation{
            
            if value.count > 1{
                
                if password.count != 0{
                    
                    password.removeLast()
                }
            }
            else{
                
                if password.count != 6{
                    
                    password.append(value)
                    
                    // Delay Animation...
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        
                        withAnimation{
                            
                            if password.count == 6{
                                
                                print(password)
                               //gọi tiếp view confirm passcode
                                self.isShowConFirmPassCodeView = true
                                //bắn password ra cho bên view bên trên
                                self.passwordBuoc1 = password
                                //reset lại password để cho view sau trống trơn
                                password.removeAll()
                            }
                        }
                    }
                }
            }
        }
    }
}




////==============================
struct PasswordButton3 : View {
    
    var value : String
    @Binding var password : String
    @Binding var passwordBuoc1 : String
    @Binding var walletName: String
    @Binding var isUserPass_PIN_making:Bool
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.red)
                }
                else{
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
            .padding()

        })
    }
    
    func setPassword(){
        
        // checking if backspace pressed...
        
        withAnimation{
            
            if value.count > 1{
                
                if password.count != 0{
                    
                    password.removeLast()
                }
            }
            else{
                
                if password.count != 6{
                    
                    password.append(value)
                    
                    // Delay Animation...
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        
                        withAnimation{
                            
                            if password.count == 6{
                                print("password trước đó: ", passwordBuoc1)
                                print("password confirm: ",password)
                               //check if hai pass trùng hay không
                                if (passwordBuoc1 == password)
                                {
                                    print("OK PASS")
                                    //save pass vào keychain
                                    print("tạo ví tên là: ", walletName)
                                    let data = Data(password.utf8)
                                    keychain_save(data, service: "PoolsWallet_KeyChain_PIN", account: walletName)
                                    print("save vao key chain xong ví: ", walletName)
                                    let d = keychain_read(service: "PoolsWallet_KeyChain_PIN", account: walletName)
                                    print("mã pin là: ",String(decoding: d ?? Data(), as: UTF8.self))
                                    
                                    //nếu đã ok bước tạo mã pin, 2 mã pin trùng khớp, ta sẽ tạo wallet với 12 ký tự -> thông báo ra bên ngoài package
                                    //ghi vào userdefault để chạy app lần sau không cần load view tao wallet nữa mà dùng mã pin login chạy vào app luôn
                                    self.isUserPass_PIN_making = true
                                }
                                else{
                                    print("PASS CODE FAIL!")
                                    password.removeAll()
                                }
                               
                            }
                        }
                    }
                }
            }
        }
    }
}

