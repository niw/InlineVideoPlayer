//
//  TextView.swift
//  InlineVideoPlayer
//
//  Created by Yoshimasa Niwa on 10/18/23.
//

import UIKit

final class TextView: UITextView {
    override var layoutManager: NSLayoutManager {
        if #available(iOS 16.0, *) {
            fatalError("We must not fallback to TextKit 1")
        } else {
            return super.layoutManager
        }
    }
}
