
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct MnemonicWordsView: View {
   
    @State var walletName:String
    @State var PIN_Number:String
    
    @State var data12Words = (1...12).map { "\($0). item" }
    @State var addressWallet:String = ""
    @State var isStillLoading12Word = true
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    //===INIT===///
    public init(walletName:String, PIN_Number:String) {
        self.walletName = walletName
        self.PIN_Number = PIN_Number
        print("TẠO 12 từ cho ví: ", self.walletName)
        print("ví có PIN: ", self.PIN_Number)
    }
    //====BODY====///
    public var body: some View{
        if(isStillLoading12Word == true){
            LoadingView(addressWallet: $addressWallet, data12Words: $data12Words, isStillLoading12Word: $isStillLoading12Word,
                        walletName: $walletName, PIN_Number: $PIN_Number, isShowing:  $isStillLoading12Word)
            {
                //12 seed words View
                VStack(alignment: .center) {
                    
                    Text("Your 12 words seed phrase").font(.title)
                        .padding(10)
                    Text("Below are 12 recovery words connected to your wallet. Please store it securely and never share it with anyone.")
                        .font(.footnote)
                        .padding(.bottom,10)
                    
                    //12 từ trong khung
                    ScrollView {
                        LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                            ForEach(data12Words, id: \.self) { item in
                                Text(item)
                                    .frame(width: 130)
                                    .font(.body)
                                    .foregroundColor(.blue)
                                    .padding()
                                    .border(.blue)
                                    .cornerRadius(5)
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 500)
                    
                    //show address ví của user
                    Text("Wallet Address:\n" + addressWallet).font(.body).padding(.horizontal)
                    
                    //nút next
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            
                            
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
                    }//end VStack
                    
                    
                }
            }
            
        }
        //nếu load 12 từ xong
        else{
            //12 seed words View
            VStack(alignment: .center) {
                
                Text("Your 12 words seed phrase").font(.title)
                    .padding(10)
                Text("Below are 12 recovery words connected to your wallet. Please store it securely and never share it with anyone.")
                    .font(.footnote)
                    .padding(.bottom,10)
                
                //12 từ trong khung
                ScrollView {
                    LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                        ForEach(data12Words, id: \.self) { item in
                            Text(item)
                                .frame(width: 130)
                                .font(.body)
                                .foregroundColor(.blue)
                                .padding()
                                .border(.blue)
                                .cornerRadius(5)
                            
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: 500)
                
                //show address ví của user
                Text("Wallet Address:\n" + addressWallet).font(.body).padding(.horizontal)
                
                //nút next
                HStack(alignment: .center){
                    Spacer()
                    Button(action: {
                        
                        
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
                }//end VStack
                
                
            }
            
        }
        
       
        
    }//end body
    
    
    
    
}//end struct


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
                
                DispatchQueue.global().async {
                    let myWallet = Wallet()
                    
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
                
            }
        }
    }

}
