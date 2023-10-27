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
        NavigationView{
         
            VStack() {
                Text(self.name)
                    .font(.title)
                
                Image(uiImage: generateQRCode(from: self.seed12WordsString))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Text("Wallet address: " + self.seed12WordsString)
                    .font(.title)
                //nut copy 12 từ
                Button {
                    print("Copy Button was tapped save to clipbroad")
                  
                    UIPasteboard.general.setValue(self.seed12WordsString,
                                                      forPasteboardType: UTType.plainText.identifier)
                   
                } label: {
                    Text("Copy!")
                        .font(.body)
                       
                }
               
                //nút next pass quy trình tạo ví
                Button {
                    print("Copy Button was tapped save to clipbroad")
                  
                    isUserPass12SeedsWordView = true
                    
                   
                } label: {
                    Text("NEXT")
                        .font(.body)
                       
                }
            }
           
        }
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

