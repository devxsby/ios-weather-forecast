//
//  WeatherHeaderView.swift
//  WeatherForecast
//
//  Created by Bora Yang on 2023/04/04.
//

import UIKit

final class WeaterHeaderView: UICollectionReusableView {

    static let identifier = "WeaterHeaderView"

//    var weatherImage: UIImage!
//    var locationLabel: UILabel!
//    var subTemperatureLabel: UILabel!
//    var currentTmperatureLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
