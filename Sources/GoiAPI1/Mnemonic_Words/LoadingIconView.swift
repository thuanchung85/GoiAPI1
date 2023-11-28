
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers
import web3swift
import Web3Core

//==========LOADING VIEW========///
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
struct LoadingView<Content>: View where Content: View {

    @Binding var addressWallet: String
    @Binding var data12Words: [String]
    @Binding var isStillLoading12Word:Bool
    @Binding var walletName:String
    @Binding var PIN_Number:String
    
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Making Wallet...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
            //genegater 12 từ
            .onAppear(){
                
                    let mnemonic = try! BIP39.generateMnemonics(bitsOfEntropy: 128)!
                    data12Words = mnemonic.components(separatedBy: " ")
                    print(data12Words)
                    let dataMnemonic = Data(mnemonic.utf8)
                    //save mnemonic vao keychain
                    keychain_save(dataMnemonic, service: "PoolsWallet_mnemonic", account: "mnemonic")
                
                    DispatchQueue.global(qos: .userInteractive).async {
                        let keystore = try! BIP32Keystore(mnemonics: mnemonic, password: "", mnemonicsPassword: "")
                        
                        //let keyData = try! JSONEncoder().encode(keystore!.keystoreParams)
                        //let wallet = Web3Wallet(address:  self.addressWallet,
                                                //data: keyData, name: self.walletName, type: .hd(mnemonics: mnemonic.components(separatedBy: " ")))
                       
                        self.addressWallet = (keystore?.addresses?.first)!.address
                       
                        let pkey = try! keystore!.UNSAFE_getPrivateKeyData(password: "", account: (keystore?.addresses?.first)!).toHexString()
                       //let privateKey = "0x"+pkey
                        let privateKey = pkey
                        UserDefaults.standard.set( self.addressWallet, forKey: "PoolsWallet_addressWallet")
                        print(self.addressWallet)
                        print("pkey :\(privateKey)")
                        let data = Data(privateKey.utf8)
                        //save privakey vao keychain
                        keychain_save(data, service: "PoolsWallet_\(self.addressWallet)_PKey", account: self.addressWallet)
                        
                        
                        //tạo signature của "wallet address nay"
                        guard let SIGNATURE_HASH = Bundle.main.object(forInfoDictionaryKey: "SignatureHash") as? String else {
                            fatalError("SignatureHash must not be empty in plist")
                        }
                        print(SIGNATURE_HASH)
                        let msgStr = SIGNATURE_HASH
                        let data_msgStr = msgStr.data(using: .utf8)
                        
                       
                        let keystoreManager = KeystoreManager([keystore!])
                        //Task{
                            //let web3Rinkeby = try! await Web3.InfuraRinkebyWeb3()
                            //web3Rinkeby.addKeystoreManager(keystoreManager)
                            //let signMsg = try! web3Rinkeby.wallet.signPersonalMessage(data_msgStr!,
                                                                                      //account:  keystoreManager.addresses![0],
                                                                                      //password: "");
                            //let strSignature = signMsg.base64EncodedString()
                            
                            let signMsg = try! Web3Signer.signPersonalMessage(data_msgStr!, keystore: keystore!,
                                                                         account: keystoreManager.addresses![0],
                                                                         password: "")
                            let strSignature = "0x" + (signMsg?.toHexString())!
                            //let strSignature = (signMsg?.toHexString())!
                            print("strSignature: ",strSignature as Any);
                            print("cho ADDRESS: ",keystoreManager.addresses![0].address);
                            
                            
                            //save vào user default giá trị strSignature của chính địa chỉ này
                            let KK = "signatureOfAccount<->\(keystoreManager.addresses![0].address)"
                            print("KK: ", KK)
                            UserDefaults.standard.set( strSignature, forKey: KK)
                            //ok thoat khỏi loading screen
                            self.isStillLoading12Word = false
                        //}
                    }
                
                    //save vao2 user default wallet name va addressWallet
                    UserDefaults.standard.set( self.walletName, forKey: "PoolsWallet_walletName")
                   
                
                    //ok thoat khỏi loading screen
                    //self.isStillLoading12Word = false
                
               
                    //let myWallet = Wallet()
                
                /*
                DispatchQueue.global().async {
                    let HDWallet_1_Data = myWallet.create_HDWallet_BIP32_Init(accountName: self.walletName,password: self.PIN_Number)
                    addressWallet = HDWallet_1_Data.first ?? ""
                    print("[String] wallet Data: ", HDWallet_1_Data)
                    let array_12Words = HDWallet_1_Data[1].split(separator: " ").map(String.init)
                    self.data12Words = array_12Words.enumerated().map { (index, element) in
                        return "\(index + 1): \(element)"
                    }
                    self.isStillLoading12Word = false
                    //let retestWalletby12Words = myWallet.recover_HDWallet_BIP32_with12Words(with12Words: HDWallet_1_Data[1], newName: "newname")
                    
                    //print("[reset] wallet address recover by 12 words: ", retestWalletby12Words)
                }
                */
            }
        }
    }

}
