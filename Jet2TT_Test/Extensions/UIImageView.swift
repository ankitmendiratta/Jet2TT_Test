//
//  ViewExtension.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//
import UIKit
import Foundation
import SDWebImage

extension UIImageView {
    
    
     func loadURL(urlString : String?, placeholderImage : UIImage?)  {
           
           self.image = placeholderImage
           
           guard let lobjUrlString = urlString, !urlString!.isEmpty else {
               print("String is nil or empty.")
               return // or break, continue, throw
           }
           
    
           let ltrimmedUrlString = lobjUrlString.trimmingCharacters(in: .whitespacesAndNewlines)
           self.sd_setImage(with:URL(string:ltrimmedUrlString) , placeholderImage: placeholderImage, options: [.refreshCached], completed: { (image, error, type, utlType)  in
           
               if image == nil{
                   self.downloadImage(url : lobjUrlString, completition: { (image2) in
                       //CHANGE
                       DispatchQueue.main.async {
                             self.image = image2 == nil ? placeholderImage : image
                             self.contentMode = .scaleAspectFill
                       }
                     
                   })
               }else{
                   //CHANGE
                   DispatchQueue.main.async {
                     self.image = image
                     self.contentMode = .scaleAspectFill
                   }
               }
               
           })
           
       }
    
    func downloadImage(url : String?, completition : @escaping (UIImage?) -> Void){
                
        SDWebImageDownloader.shared().downloadImage(with: URL(string:/url) , options: [.ignoreCachedResponse]  , progress: nil) { (image, data, error, isComplete) in
            
            if isComplete {
                completition(image)
            }else{
                completition(nil)
            }
        }
    }
    
}
