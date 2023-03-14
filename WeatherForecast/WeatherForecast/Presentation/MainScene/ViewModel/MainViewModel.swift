//
//  MainViewModel.swift
//  WeatherForecast
//
//  Created by devxsby on 2023/03/15.
//

import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}

final class MainViewModel: ViewModelType {
    
    private let useCase: MainUseCase
    
    // MARK: - Inputs
    
    struct Input {
        
    }
    
    // MARK: - Outputs
    
    struct Output {
        
    }
    
    // MARK: - init
    
    init(useCase: MainUseCase) {
        self.useCase = useCase
    }
}

extension MainViewModel {
    func transform(from input: Input) -> Output {
        let output = Output()
        self.bindOutput(output: output)
        
        return output
    }
    
    private func bindOutput(output: Output) {
        
    }
}
