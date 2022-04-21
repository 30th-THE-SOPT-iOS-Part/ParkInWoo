//
//  String+Extension.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/20.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
