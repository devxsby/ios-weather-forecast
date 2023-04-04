//
//  WeatherForecast - WeatherForecastViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class WeatherForecastViewController: UIViewController {

    // MARK: - Properties
    
    var viewModel: WeatherForecastViewModel!
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 10

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .blue
        return cv
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        setCollecionViewDelegate()
        registerCollectionViewCell()
        configureCollectionView()
        binding()
    }
}

// MARK: - Methods

extension WeatherForecastViewController {
    
    private func setBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func binding() {

        viewModel.loadWeatherEntity = { [weak self] weatherEntity in
            // ui 업데이트
            print(weatherEntity)
        }

        viewModel.loadForecastEntity = { [weak self] forecastEnitity in
            // ui 업데이트
            print(forecastEnitity)
        }
    }

    private func setCollecionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func registerCollectionViewCell() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ForecastCollectionViewCell")
    }
}

extension WeatherForecastViewController {
    private func configureCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

    }
}

extension WeatherForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath)
        return cell
    }

}

extension WeatherForecastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}
