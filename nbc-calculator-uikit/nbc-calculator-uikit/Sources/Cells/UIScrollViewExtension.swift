//
//  UIScrollViewExtension.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/23/24.
//

import UIKit


extension UIScrollView {
    /// label의 스크롤을 위한 스크롤뷰
    static func makeHorizontalScrollView() -> UIScrollView{
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }
    
}
