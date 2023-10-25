
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct ReInputMnemonicWordsView: View {
    
    @Binding var isShowReInput12SeedsView:Bool
    @Binding var data12Words:[String]
    
    @State var seedsTextString = ["1:...","2:...","3:...","4:...",
                                  "5:...","6:...","7:...","8:...",
                                  "9:...","10:...","11:...","12:..."]
    @State var currentIndexSeed = 0
    @State var finalReCheckResult = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    //===INIT===///
    public init(isShowReInput12SeedsView:Binding<Bool>, data12Words:Binding<[String]>) {
        self._isShowReInput12SeedsView = isShowReInput12SeedsView
        self._data12Words = data12Words
    }
    
    public var body: some View{
        VStack(alignment: .center) {
            
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
                Button(action: {
                    
                }) {
                    VStack {
                        Text("Delete")
                    }
                    .padding(5)
                    .accentColor(Color(.red))
                   
                    
                }
            }//end HStack
           Divider()
            //nếu vẫn chưa ok re check 12 words thì chưa show next button
            if(finalReCheckResult == false){
                //12 button seeds
                ScrollView {
                    LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                        ForEach(data12Words.shuffled(), id: \.self) { item in
                            let s = item.components(separatedBy: ": ").last ?? " "
                            if(seedsTextString.contains(s) == false){
                                Text(s)
                                    .frame(width: 80)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(5)
                                    .scaledToFill()
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                                    .onTapGesture {
                                        print("seed word: ", s)
                                        seedsTextString[currentIndexSeed] = s
                                        currentIndexSeed += 1
                                        if(currentIndexSeed >= 12) {currentIndexSeed = 0}
                                        //nếu là từ cuối cùng thì check kết quả luôn
                                        if(currentIndexSeed == 11){
                                            if(seedsTextString == data12Words){
                                                self.finalReCheckResult = true
                                            }
                                        }
                                    }
                            }
                        }//end for each
                    }//end LazyVGrid
                    .padding(.horizontal)
                }//end ScrollView
                .frame(maxHeight: 700)
                
                //nút back để user làm lại
                HStack(alignment: .center){
                    Spacer()
                    Button(action: {
                        self.isShowReInput12SeedsView = false
                        
                    }) {
                        VStack {
                            Text("TRY AGAIN")
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
            
            //nếu PASS re check 12 words thì show next button
            else{
                Text("WELL DONE,YOU WERE CORRECTED ALL WORDS")
                
                //nút NEXT
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
                }//end HStack
            }
            
            
            
        }
    }
    
    
}//end struct
