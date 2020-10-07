
//
//  Constants.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

enum Formatters : String{
    case UTC
    case ddMMyyyy
    case ddMMMMyyyy
    case ddMMMyyyy
    case ddMMyyyy2
    case yyyyMMdd
    case mmmddyyyy
    case ddMM
    case ZZ
    case time
    case date
    case yyyymm
    case mmYYYY
    case yyyy
    case mm
    case timeFull
    case MMMMyyy
    case mmm
    case UTCSlash
    
    func get() -> String{

        switch self {
        case .ZZ:
            return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .UTC:
            return "yyyy-MM-dd HH:mm:ss.sss"
        case .ddMMyyyy:
            return "dd MMM, yyyy"
        case .ddMMMyyyy:
            return "dd MMM yyyy"
        case .ddMMyyyy2:
            return "dd-MM-yyyy"
        case .ddMMMMyyyy:
            return "dd MMMM yyyy, HH:mm"
        case .ddMM:
            return "dd MMM"
        case .yyyyMMdd:
            return "yyyy-MM-dd"
        case .mmmddyyyy:
            return "MMMM dd yyyy HH:mm:ss"
        case .time:
            return "hh:mm aa"
        case .timeFull:
            return "HH:mm"
        case .date:
            return "MM/dd/yyyy"
        case .yyyymm:
            return "yyyy-MM"
        case .mmYYYY:
            return "MMM, yyyy"
        case .mm:
            return "MM"
        case .MMMMyyy:
            return "MM - yyyy"
        case .yyyy:
            return "yyyy"
        case .mmm:
            return "MMM"
        case .UTCSlash :
            return "MM/dd/yyyy HH:mm:ss"
        }
    }
    
}
