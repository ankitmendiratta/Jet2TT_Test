  //
  //  Utility.swift
  //  Jet2TT_Test
  //
  //  Created by Ankit on 06/10/2020.
  //  Copyright © 2020 Ankit. All rights reserved.
  //
  
  import UIKit
  
  class Utility: NSObject {
    
    static let shared = Utility()

    override init() {
        super.init()
    }
    
    //MARK: Loader
    func loader()  {
        //Show any third party  or custom indicator here
    }
    
    func removeLoader()  {
       //Hide any third party or custom indicator here
    }
    
    
    func JSONObjectWithData(data: NSData) -> Any? {
        do { return try JSONSerialization.jsonObject(with: data as Data, options: []) }
        catch { return .none }
    }
    
    
    //MARK: JSON Converiosn to String
    
    func converyToJSONString (array : [Any]?) -> String{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array ?? [], options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                return JSONString
            }
            
        } catch {}
        return ""
    }
    
  }
  
