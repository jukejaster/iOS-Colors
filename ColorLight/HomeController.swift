//
//  HomeController.swift
//  ColorLight
//
//  Created by Justin on 3/27/20.
//  Copyright © 2020 justncode LLC. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    private var viewModel = HomeViewModel()
    
    @IBOutlet weak var `switch`: UISwitch!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        `switch`.isOn = viewModel.loadSwitchState()
        
        NetworkController.fetchMailMessages { messages in
            print("messages", messages)
        }
    }
    
    // MARK: - @IBActions
    @IBAction func toggleLights(_ sender: UISwitch) {
        view.backgroundColor = sender.isOn ? viewModel.selectedColor?.uiColor : .white
        // save the state of the switch
        viewModel.saveState(sender.isOn)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCell else {
            fatalError("Unable to dequeue reusable cell with identifier \"colorCell.\"")
        }
        
        cell.color = viewModel.colors[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.height
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard `switch`.isOn else { return }
        
        viewModel.colors[indexPath.row].isSelected = true
        view.backgroundColor = viewModel.colors[indexPath.row].uiColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.colors[indexPath.row].isSelected = false
    }
}
