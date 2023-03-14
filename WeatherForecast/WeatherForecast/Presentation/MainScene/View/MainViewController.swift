//
//  WeatherForecast - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: MainViewModel!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
    }
}

// MARK: - Methods

extension MainViewController {
  
    private func bindViewModels() {
        let input = MainViewModel.Input()
        let output = self.viewModel.transform(from: input)
    }
}
