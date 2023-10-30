
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct ReInputMnemonicWordsView: View {
    @Binding var walletName:String
    @Binding var isShowReInput12SeedsView:Bool
    @Binding var data12Words:[String]
    
    @State var seedsTextString = ["1:...","2:...","3:...","4:...",
                                  "5:...","6:...","7:...","8:...",
                                  "9:...","10:...","11:...","12:..."]
    
    //các biến phục vụ quá trình check và nhập seed lại
    @State var currentIndexSeed = 0
    @State var finalReCheckResult = false
    @State var isInput12SeedsDone = false
    //kết quả trả ra bên ngoài package
    @Binding var isUserPass12SeedsWordView:Bool
    
    @State var showQRCodePage = false
  
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    //===INIT===///
    public init(isShowReInput12SeedsView:Binding<Bool>, data12Words:Binding<[String]>,walletName:Binding<String>, isUserPass12SeedsWordView:Binding<Bool>) {
        self._isShowReInput12SeedsView = isShowReInput12SeedsView
        self._data12Words = data12Words
        self._isUserPass12SeedsWordView = isUserPass12SeedsWordView
        self._walletName = walletName
    }
    
    public var body: some View{
        VStack(alignment: .center) {
            //show page tập input 12 từ cho user
            if(showQRCodePage == false){
                Text("ReEnter Your 12 words seed phrase").font(.title)
                    .padding(10)
                Text("Please tap your 12 words follow previous order. ")
                    .font(.footnote)
                    .padding(.bottom,5)
                
                //12 từ trong khung
                Text(seedsTextString.joined(separator: " "))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                    .font(.body)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .padding(10)
                    .cornerRadius(5)
                    .lineSpacing(10)
                //nút delete 1 từ
                HStack(){
                    Spacer()
                    if(isInput12SeedsDone == false){
                        Button(action: {
                            if(currentIndexSeed > 0){
                                currentIndexSeed -= 1
                                seedsTextString[currentIndexSeed] = String(currentIndexSeed + 1) + ":..."
                            }
                        }) {
                            VStack {
                                Text("Delete")
                            }
                            .padding(5)
                            .accentColor(Color(.red))
                        }
                        
                    }
                }//end HStack
                
                Divider()
                
                //nếu vẫn chưa ok re check 12 words thì chưa show next button
                if(finalReCheckResult == false){
                    if(isInput12SeedsDone == false){
                        //12 button seeds
                        ScrollView {
                            LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                                ForEach(Array(data12Words.enumerated()), id: \.offset) { index,item in
                                    let s = item.components(separatedBy: ": ").last ?? " "
                                   
                                    if(seedsTextString.contains(s) == false){
                                        Text("\(index + 1) : \(s)")
                                            .frame(width: 80)
                                            .font(.custom("Arial ", size: 15))
                                            .foregroundColor(.green)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(20)
                                            .scaledToFill()
                                            .minimumScaleFactor(0.5)
                                            .lineLimit(1)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.green, lineWidth: 1)
                                            )
                                            .onTapGesture {
                                                print("seed word: \(currentIndexSeed)", s)
                                                seedsTextString[currentIndexSeed] = s
                                                currentIndexSeed += 1
                                                
                                                //nếu là từ cuối cùng thì check kết quả luôn
                                                if(currentIndexSeed >= 12){
                                                    print("ket qua re check : ", seedsTextString)
                                                    let array_Data12Words = data12Words.map { i in
                                                        return i.components(separatedBy: ": ").last ?? " "
                                                    }
                                                    print("data12Words : ", array_Data12Words)
                                                    if(seedsTextString == array_Data12Words){
                                                        self.finalReCheckResult = true
                                                    }
                                                    isInput12SeedsDone = true
                                                    currentIndexSeed = 0
                                                }
                                            }
                                    }
                                }//end for each
                            }//end LazyVGrid
                            .padding(5)
                        }//end ScrollView
                        .frame(maxHeight: 700)
                        
                    }
                    else{
                        Text("SORRY, YOU GOT THE WRONG ORDER, PLEASE TRY AGAIN.")
                            .font(.custom("Arial ", size: 20))
                            .foregroundColor(.gray)
                            .padding(.bottom,10)
                    }
                    //nút back để user làm lại
                    //nut skip nếu user thôi không làm nữa
                    HStack(alignment: .center){
                        Spacer()
                        
                        Button(action: {
                            self.isShowReInput12SeedsView = false
                            
                        }) {
                            Text("TRY AGAIN")
                                .frame(width: 120)
                                .padding()
                                .foregroundColor(.white)
                        }
                        .background(Color.green)
                        .cornerRadius(30)
                        
                        Spacer()
                        
                        
                        Button(action: {
                            showQRCodePage = true
                        }) {
                            Text("SKIP")
                                .frame(width: 120)
                                .padding()
                                .foregroundColor(.white)
                        }
                        .background(Color.green)
                        .cornerRadius(30)
                        
                        Spacer()
                    }//end HStack
                    
                    
                    
                }
                
                //nếu PASS re check 12 words thì show next button
                else{
                    Text("WELL DONE,YOU WERE CORRECTED ALL WORDS").foregroundColor(Color.green)
                    
                    //nút NEXT
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            showQRCodePage = true
                            
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
                    }//end HStack
                }
                
            }
            
            //show page QRcode 12 từ cho user copy
            if(showQRCodePage == true){
                //user skip nhưng vẫn cho qua pass qui trình tạo ví, show mã QR cho ho
                let array_Data12Words = data12Words.map { i in
                    return i.components(separatedBy: ": ").last ?? " "
                }
                 QRCodeMakerView(isUserPass12SeedsWordView: $isUserPass12SeedsWordView,
                                 name: $walletName, seed12WordsString: array_Data12Words.joined(separator: " "), width: 300, height: 300)
            }
        }
    }
    
    
}//end struct
