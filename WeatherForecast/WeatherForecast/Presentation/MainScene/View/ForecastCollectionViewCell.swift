//
//  ForecastCollectionViewCell.swift
//  WeatherForecast
//
//  Created by Bora Yang on 2023/04/04.
//

import UIKit

final class ForecastCollectionViewCell: UICollectionViewCell {

    static let identifier = "ForecastCollectionViewCell"

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "4/4(화) 17시"
        return label
    }()

    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "20.0"
        return label
    }()

    let temperatureImageView: UIImageView = {
        let tempImage = UIImageView()
        tempImage.image = UIImage(imageLiteralResourceName: "sun")
        tempImage.contentMode = .scaleToFill
        return tempImage
    }()

    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

        contentView.addSubview(temperatureImageView)
        temperatureImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        temperatureImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temperatureImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        temperatureImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        contentView.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: temperatureImageView.leadingAnchor, constant: -5).isActive = true

        contentView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
    }

    func setData(model: WeatherForecastViewModel) {
    }
}
