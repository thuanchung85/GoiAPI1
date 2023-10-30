
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
                do{
                    let mnemonic = try! BIP39.generateMnemonics(bitsOfEntropy: 128)!
                    data12Words = mnemonic.components(separatedBy: " ")
                    DispatchQueue.global(qos: .userInteractive).async {
                        let keystore = try! BIP32Keystore(mnemonics: mnemonic, password: "", mnemonicsPassword: "")
                        print(keystore as Any)
                        self.addressWallet = (keystore?.addresses?.first)!.address
                        print(self.addressWallet)
                    }
                    self.isStillLoading12Word = false
                }
                catch{
                    print("make mnemonic error!")
                }
                    let myWallet = Wallet()
                
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
