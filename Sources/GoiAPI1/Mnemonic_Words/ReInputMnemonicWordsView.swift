
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
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150)
                        .font(.body)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .padding(10)
                        .cornerRadius(5)
                        .lineSpacing(10)
            //nút delete 1 từ
            HStack(alignment: .center){
                Spacer()
                Button(action: {
                    self.isShowReInput12SeedsView = false
                    
                }) {
                    VStack {
                        Text("Delete")
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
           
            
            //12 button seeds
            ScrollView {
                LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                    ForEach(data12Words, id: \.self) { item in
                        Text(item.components(separatedBy: ": ").last ?? " ")
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
                                print("seed word: ", item.components(separatedBy: ": ").last ?? " ")
                            }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 700)
             
            //nút back
            HStack(alignment: .center){
                Spacer()
                Button(action: {
                    self.isShowReInput12SeedsView = false
                    
                }) {
                    VStack {
                        Text("BACK")
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
    
    
}//end struct
