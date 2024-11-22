//
//  ThemeManager.swift
//  nbc-calculator-uikit
//
//  Created by MaxBook on 11/21/24.
//

import UIKit


/// 코드의 보수와 관리의 편의성을 위해 각종 색상과 수치 등을 미리 정의.
struct ThemeManager {
    static let shared = ThemeManager()

    struct Colors {
        // 기본적용 색상값
        let black: UIColor = UIColor.black
        let white: UIColor = UIColor.white
        
        let grey1: UIColor = UIColor.systemGray
        let grey2: UIColor = UIColor.systemGray2
        let grey3: UIColor = UIColor.systemGray3
        let grey4: UIColor = UIColor.systemGray4
        let grey5: UIColor = UIColor.systemGray5
        let grey6: UIColor = UIColor.systemGray6
        
        let red: UIColor = UIColor.red
        let blue: UIColor = UIColor.blue
        let yellow: UIColor = UIColor.yellow
        let green: UIColor = UIColor.green
        let orange: UIColor = UIColor.orange
        
        // 커스텀 색상
        let main = UIColor(named: "MainColor") ?? UIColor.systemBlue
        let sub1 = UIColor(named: "SubColor1") ?? UIColor.systemGray
        let sub2 = UIColor(named: "SubColor2") ?? UIColor.white
        
        let calButton: UIColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
    
    }

    struct Fonts {
        let h1 = UIFont.systemFont(ofSize: 60, weight: .bold)
        let h2 = UIFont.systemFont(ofSize: 45, weight: .bold)
        let h3 = UIFont.systemFont(ofSize: 30, weight: .bold)
        let h4 = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        let p = UIFont.systemFont(ofSize: 16, weight: .regular)
        let strong = UIFont.systemFont(ofSize: 16, weight: .bold)
        let small = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    struct Numbers {
        let padding: CGFloat = 30
        let raidus: CGFloat = 10
    }

    let colors = Colors()
    let fonts = Fonts()
    let numbers = Numbers()
}
