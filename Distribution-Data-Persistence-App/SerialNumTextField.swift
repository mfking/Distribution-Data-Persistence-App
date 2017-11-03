//
//  SerialNumTextField.swift
//  Distribution-Data-Persistence-App
//
//  Created by Meghan King on 11/3/17.
//  Copyright © 2017 Meghan King. All rights reserved.
//

import UIKit

class SerialNumTextField: UITextField {
    
    var formattingPattern = "****-*****"
    
    var replacementChar: Character = "*"

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //registerForNotifications()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //registerForNotifications()
    }
    /*
    private func registerForNotifications() {
        NotificationCenter.defaultCenter.addObserver(self, selector: "textDidChange", name: "UITextFieldTextDidChangeNotification", object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func makeOnlyDigitsString(string: String) -> String {
        return join("", string.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet))
    }
    
    func textDidChange() {
        if count(text) > 0 && count(formattingPattern) > 0 {
            let tempString = makeOnlyDigitsString(string: text)
            
            var finalText = ""
            var stop = false
            
            var formatterIndex = formattingPattern.startIndex
            var tempIndex = tempString.startIndex
            
            while !stop {
                let formattingPatternRange = Range(start: formatterIndex, end: advance(formatterIndex, 1) )
                
                if formattingPattern.substringWithRange(formattingPatternRange) != String(replacementChar) {
                    finalText = finalText.stringByAppendingString(formattingPattern.substringWithRange(formattingPatternRange))
                } else if count(tempString) > 0 {
                    let pureStringRange = Range(start: tempIndex, end: advance(tempIndex, 1))
                    finalText = finalText.stringByAppendingString(tempString.substringWithRange(pureStringRange))
                    tempIndex++
                }
                
                formatterIndex++
                
                if formatterIndex >= formattingPattern.endIndex || tempIndex >= tempString.endIndex {
                    stop = true
                }
            }
            
            text = finalText
        }
    } */
}
