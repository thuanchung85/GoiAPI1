//
//  File.swift
//  GoiAPI2
//
//  Created by SWEET HOME (^0^)!!! on 20/10/2023.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct QRCodeMakerView: View {
    @Binding  var name:String
   
     var seed12WordsString:String
    
     var width:CGFloat?
     var height:CGFloat?
    
    //kết quả trả ra bên ngoài package
    @Binding var isUserPass12SeedsWordView:Bool
    
    //===INIT===//
    public init(isUserPass12SeedsWordView:Binding<Bool>,name: Binding<String>, seed12WordsString:String, width:CGFloat,  height:CGFloat) {
        self._name = name
        self.seed12WordsString = seed12WordsString
        self._isUserPass12SeedsWordView = isUserPass12SeedsWordView
        self.width = width
        self.height = height
    }
    
    //===BODY===//
    public var body: some View{
       
         
            VStack() {
                Text("Your 12 serect words QR code of your: " + self.name + " wallet")
                    .font(.title)
                
                Image(uiImage: generateQRCode(from: self.seed12WordsString))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                //Text("12 serect words: \n" + self.seed12WordsString).font(.body)
                /*
                //nut copy 12 từ NGUY HIEM vi CLIPBROAD co the bi hack
                Button {
                    print("Copy Button was tapped save to clipbroad")
                    UIPasteboard.general.setValue(self.seed12WordsString,
                                                      forPasteboardType: UTType.plainText.identifier)
                   
                } label: {
                    Text("Copy!")
                        .font(.body)
                }*/
               
                Text("Just for convenience, not recommendation: you can take a screenshot of this and use it later, but be careful!")
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.all,10)
                
                //nút next pass quy trình tạo ví
                Button {
                    isUserPass12SeedsWordView = true
                } label: {
                    Text("NEXT")
                        .padding(10)
                        .font(.body)
                        .accentColor(Color(.systemBlue))
                        .cornerRadius(4.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4).stroke(Color(.systemBlue), lineWidth: 2)
                        )
                }
                .padding(.top,20)
            }//end VStack
           
        
    }
    
    
    func generateQRCode(from string:String)-> UIImage{
         let context = CIContext()
         let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage{
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}//end struct

