//
//  HomeViewModel.swift
//  ColorLight
//
//  Created by Justin on 3/27/20.
//  Copyright © 2020 justncode LLC. All rights reserved.
//

import Foundation

struct HomeViewModel {
    var colors = [
        Color(uiColor: .red),
        Color(uiColor: .green),
        Color(uiColor: .blue),
        Color(uiColor: .purple),
        Color(uiColor: .orange)
    ]
    
    var selectedColor: Color? {
        colors.first(where: { color in
            color.isSelected
        }) ?? Color(uiColor: .white)
    }
    
    func saveState(_ switchIsOn: Bool) {
        UserDefaults.standard.set(switchIsOn, forKey: "switchIsOn")
        UserDefaults.standard.synchronize()
    }
    
    func loadSwitchState() -> Bool {
        return UserDefaults.standard.bool(forKey: "switchIsOn")
    }
}
