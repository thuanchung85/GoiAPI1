
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
    
    @State var isShowReInput12SeedsView = false
    
    //kết quả trả ra bên ngoài package
    @Binding var isUserPass12SeedsWordView:Bool
    
    
    //===INIT===///
    public init(walletName:String, PIN_Number:String , isUserPass12SeedsWordView:Binding<Bool>) {
        self.walletName = walletName
        self.PIN_Number = PIN_Number
        self._isUserPass12SeedsWordView = isUserPass12SeedsWordView
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
                            ForEach(Array(data12Words.enumerated()), id: \.offset) { index,item in
                                Text("\(index + 1) : \(item)")
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
                    Text("Account Address:\n" + addressWallet).font(.body).padding(.horizontal)
                    
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
        //nếu load 12 từ xong thì show ra 12 từ đó, và chuẫn bị view "cho user nhập lại 12 từ"
        else{
            //nếu isShowReInput12SeedsView = false thì cứ show 12 từ ra bình thường.
            if(isShowReInput12SeedsView == false){
                //show 12 seed words View
                VStack(alignment: .center) {
                    
                    //title
                    Text("Here are 12 recovery words connected to your wallet.\n Please store it securely and never share it with anyone.")
                        .font(.custom("Arial ", size: 15))
                        .foregroundColor(.gray)
                        .padding(.bottom,10)
                    
                    //12 từ trong khung
                    ScrollView {
                        LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                            ForEach(Array(data12Words.enumerated()), id: \.offset) { index,item in
                                
                                    Text("\(index + 1) : \(item)")
                                        .frame(width: 130)
                                        .font(.custom("Arial ", size: 20))
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.green, lineWidth: 1)
                                        )
                                        
                                        
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 500)
                    
                    //nút next
                    let array_Data12Words = data12Words.map { i in
                        return i.components(separatedBy: ": ").last ?? " "
                    }
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            UIPasteboard.general.setValue(array_Data12Words,
                                                              forPasteboardType: UTType.plainText.identifier)
                            
                        }) {
                            Text("You can copy 12 words here! But this is NOT RECOMMEND.")
                                .font(.footnote)
                                .padding()
                                .foregroundColor(.red)
                        }
                        .background(Color.green)
                        .cornerRadius(30)
                        Spacer()
                    }//end VStack
                    
                    //show 12 từ
                    
                    Text(array_Data12Words.joined(separator: " "))
                        .font(.custom("Arial ", size: 20))
                        .padding(.horizontal,15)
                        .padding(.bottom,15)
                    
                    //nút next
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            self.isShowReInput12SeedsView = true
                            
                        }) {
                            Text("NEXT")
                                .padding()
                                .foregroundColor(.white)
                        }
                        .background(Color.green)
                        .cornerRadius(30)
                        Spacer()
                    }//end VStack
                    
                    
                }
            }
            //nếu user bấm next thì isShowReInput12SeedsView = true và show ra view cho user nhập lại 12 từ.
            else{
                ReInputMnemonicWordsView(isShowReInput12SeedsView: $isShowReInput12SeedsView,
                                         data12Words: $data12Words,walletName:$walletName,
                                         isUserPass12SeedsWordView:   $isUserPass12SeedsWordView)
            }
        }
        
       
        
    }//end body
    
    
    
    
}//end struct

