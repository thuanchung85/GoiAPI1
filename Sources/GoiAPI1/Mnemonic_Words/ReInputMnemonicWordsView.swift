
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct ReInputMnemonicWordsView: View {
    
    @Binding var isShowReInput12SeedsView:Bool
    @Binding var data12Words:[String]
    
    @State var seedsTextString = ["words1","words2","words3","words4",
                                  "words5","words6","words7","words8",
                                  "words9","words10","words11","words12"]
    
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
                .padding(.bottom,10)
            
            //12 từ trong khung
            ScrollView {
               Text(seedsTextString.joined(separator: " "))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .font(.body)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .padding(10)
                        .cornerRadius(5)
            }
            .frame(maxHeight: 300)
            
            Divider()
            
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
            }//end VStack
            
            
        }
    }
    
    
}//end struct
