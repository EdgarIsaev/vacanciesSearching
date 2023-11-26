//
//  VacanciesTableViewCell.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit

class VacanciesTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel(text: "Name Label",
                                    font: .systemFont(ofSize: 25, weight: .bold),
                                    textColor: .black)
    
    private let salaryFromLabel = UILabel(text: "от 2 000 000",
                                          font: .systemFont(ofSize: 15, weight: .heavy),
                                          textColor: .black,
                                          lines: 1)
    
    private let salaryToLabel = UILabel(text: "до 5 000 000",
                                        font: .systemFont(ofSize: 15, weight: .heavy),
                                        textColor: .black,
                                        lines: 1)
    
    private let currencyLabel = UILabel(text: "руб",
                                        font: .systemFont(ofSize: 15, weight: .heavy),
                                        textColor: .black,
                                        lines: 1)
    
    private let employerNameLabel = UILabel(text: "Employer's name",
                                            font: .systemFont(ofSize: 20, weight: .light),
                                            textColor: .gray)
    
    private let requirementLabel = UILabel(text: "Requirement",
                                            font: .systemFont(ofSize: 20, weight: .light),
                                            textColor: .black)
    
    private let responsibilityLabel = UILabel(text: "Responsibility",
                                            font: .systemFont(ofSize: 20, weight: .light),
                                            textColor: .black)
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var salaryStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 1, green: 0.3394592702, blue: 0.4258575439, alpha: 1)
        
        salaryFromLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        salaryToLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    public func addSubviews() {
        addSubview(nameLabel)
        addSubview(logoImageView)
        salaryStackView = UIStackView(arrangedSubViews: [salaryFromLabel,
                                                         salaryToLabel,
                                                         currencyLabel],
                                      axis: .horizontal,
                                      spacing: 5)
        addSubview(salaryStackView)
        addSubview(employerNameLabel)
        addSubview(requirementLabel)
        addSubview(responsibilityLabel)
    }
}

// MARK: SetConstraints

extension VacanciesTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: -10),
            
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            salaryStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            salaryStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            salaryStackView.trailingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: -10),
            
            employerNameLabel.topAnchor.constraint(equalTo: salaryStackView.bottomAnchor, constant: 20),
            employerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            employerNameLabel.trailingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: -10),
            
            requirementLabel.topAnchor.constraint(equalTo: employerNameLabel.bottomAnchor, constant: 20),
            requirementLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            requirementLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            responsibilityLabel.topAnchor.constraint(equalTo: requirementLabel.bottomAnchor, constant: 20),
            responsibilityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            responsibilityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            responsibilityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
