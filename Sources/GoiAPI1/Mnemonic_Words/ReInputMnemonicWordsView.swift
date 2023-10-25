
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct ReInputMnemonicWordsView: View {
    
    @Binding var isShowReInput12SeedsView:Bool
    
    @State var seedsTextString = ["words1","words2","words3","words4",
                                  "words5","words6","words7","words8",
                                  "words9","words10","words11","words12"]
    //===INIT===///
    public init(isShowReInput12SeedsView:Binding<Bool>) {
        self._isShowReInput12SeedsView = isShowReInput12SeedsView
      
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
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .padding(10)
            }
            .frame(maxHeight: 500)
            
             
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
