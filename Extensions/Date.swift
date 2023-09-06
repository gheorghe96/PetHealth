//
//  Date.swift
//  pethealth
//
//  Created by Gheorghe Curca on 03.09.2023.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

