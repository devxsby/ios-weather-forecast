//
//  WeatherHeaderView.swift
//  WeatherForecast
//
//  Created by Bora Yang on 2023/04/04.
//

import UIKit

final class WeatherHeaderView: UICollectionReusableView {

    static let identifier = "WeaterHeaderView"

    let temperatureImageView: UIImageView = {
        let tempImage = UIImageView()
        tempImage.image = UIImage(imageLiteralResourceName: "sun")
        tempImage.contentMode = .scaleToFill
        return tempImage
    }()

    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시 용산구"
        return label
    }()

    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최저 1.0 최고 11.0"
        return label
    }()

    let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "11.0"
        label.font = label.font.withSize(20)
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        [self.locationLabel,
         self.temperatureLabel,
         self.currentTemperatureLabel
        ].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func setUI() {
        self.backgroundColor = .yellow
    }

    private func setLayout() {
        addSubview(temperatureImageView)
        temperatureImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temperatureImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temperatureImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        temperatureImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: temperatureImageView.trailingAnchor, constant: 10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
