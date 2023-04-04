//
//  ForecastCollectionViewCell.swift
//  WeatherForecast
//
//  Created by Bora Yang on 2023/04/04.
//

import UIKit

final class ForecastCollectionViewCell: UICollectionViewCell {

    static let identifier = "ForecastCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .systemPink
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
