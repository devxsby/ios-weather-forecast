//
//  WeatherForecast - WeatherForecastViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class WeatherForecastViewController: UIViewController {

    // MARK: - Properties
    
    var viewModel: WeatherForecastViewModel
    
    // MARK: - Initialization
    
    init(viewModel: WeatherForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 1

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
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
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            print(weatherEntity)
        }

        viewModel.loadForecastEntity = { [weak self] forecastEnitity in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            print(forecastEnitity)
        }
    }

    private func setCollecionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func registerCollectionViewCell() {
        collectionView.register(WeatherHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeatherHeaderView.identifier)

        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "ForecastCollectionViewCell")
    }
}

extension WeatherForecastViewController {
    private func configureCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true

    }
}

extension WeatherForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.forecastInfo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier, for: indexPath)
                as? ForecastCollectionViewCell else { return UICollectionViewCell() }
//        cell.setData(model: viewModel)

        let forecast = viewModel.forecastInfo[indexPath.row]

        cell.timeLabel.text = viewModel.formatterDate(date: forecast.dtTxt)
        cell.temperatureLabel.text = viewModel.formatter(temp: forecast.main.temp!)
        return cell
    }

}

extension WeatherForecastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeatherHeaderView.identifier, for: indexPath) as! WeatherHeaderView
            header.currentTemperatureLabel.text = viewModel.currentTemperature
            header.temperatureLabel.text = viewModel.temperature
            viewModel.getLocationString { location in
                DispatchQueue.main.async {
                    header.locationLabel.text = location
                }
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: 130)
    }
}
