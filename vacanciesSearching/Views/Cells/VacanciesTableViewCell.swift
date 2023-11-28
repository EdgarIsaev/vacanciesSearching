//
//  VacanciesTableViewCell.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 25.11.2023.
//

import UIKit

class VacanciesTableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.addShadowOnView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel = UILabel(font: .systemFont(ofSize: 20, weight: .bold),
                                    textColor: .black)
    
    private let salaryFromLabel = UILabel(font: .systemFont(ofSize: 15, weight: .heavy),
                                          textColor: .black,
                                          lines: 1)
    private let salaryToLabel = UILabel(font: .systemFont(ofSize: 15, weight: .heavy),
                                        textColor: .black,
                                        lines: 1)
    private let currencyLabel = UILabel(font: .systemFont(ofSize: 15, weight: .heavy),
                                        textColor: .black,
                                        lines: 1)
    
    private let employerNameLabel = UILabel(font: .systemFont(ofSize: 20, weight: .light),
                                            textColor: .gray)
    private let requirementLabel = UILabel(font: .systemFont(ofSize: 13, weight: .light),
                                           textColor: .black)
    private let responsibilityLabel = UILabel(font: .systemFont(ofSize: 13, weight: .light),
                                              textColor: .black)
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundCell.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.8392156863, blue: 0.3568627451, alpha: 1)
                backgroundCell.viewGrowingEffect()
            } else {
                backgroundCell.backgroundColor = .white
            }
        }
    }
    
    private var salaryStackView = UIStackView()
    private var verticalStackView = UIStackView()
    
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
        backgroundColor = .clear
        selectionStyle = .none
        
        salaryFromLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        salaryToLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private func addSubviews() {
        addSubview(backgroundCell)
        backgroundCell.addSubview(logoImageView)
        salaryStackView = UIStackView(arrangedSubViews: [salaryFromLabel,
                                                         salaryToLabel,
                                                         currencyLabel],
                                      axis: .horizontal,
                                      spacing: 5)
        verticalStackView = UIStackView(arrangedSubViews: [nameLabel,
                                                           salaryStackView,
                                                           employerNameLabel],
                                        axis: .vertical, spacing: 10)
        backgroundCell.addSubview(verticalStackView)
        backgroundCell.addSubview(requirementLabel)
        backgroundCell.addSubview(responsibilityLabel)
    }
    
    private func hidingView(view: UIView) {
        view.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
    
    public func setupViews(model: VacancyModel) {
        nameLabel.text = model.name?.trimHTMLTags()
        if model.salary?.from != nil {
            salaryFromLabel.text = "от \(model.salary?.from ?? 0)"
        } else { salaryFromLabel.isHidden = true }
        
        if model.salary?.to != nil {
            salaryToLabel.text = "до \(model.salary?.to ?? 0)"
        } else { salaryToLabel.isHidden = true }
      
        if salaryFromLabel.isHidden && salaryToLabel.isHidden {
            hidingView(view: currencyLabel)
        } else {
            guard let currency = model.salary?.currency.rawValue else { return }
            currencyLabel.text = currency
        }
        
        employerNameLabel.text = model.employer?.name
        
        if model.snippet?.requirement != nil {
            requirementLabel.text = model.snippet?.requirement?.trimHTMLTags()
            requirementLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        } else { hidingView(view: requirementLabel) }
        
        if model.snippet?.responsibility != nil {
            responsibilityLabel.text = model.snippet?.responsibility?.trimHTMLTags()
            responsibilityLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        } else { hidingView(view: responsibilityLabel) }
        
        if model.employer?.logoUrls == nil {
            logoImageView.isHidden = true
        } else {
            guard let urlString = model.employer?.logoUrls?.the240 else { return }
            NetworkImageRequest.shared.imageFetch(imageUrl: urlString) { [weak self] result in
                guard let self = self else { return }
                switch result {
                    
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.logoImageView.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: SetConstraints

extension VacanciesTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            logoImageView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 15),
            logoImageView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            verticalStackView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: -10),
            verticalStackView.bottomAnchor.constraint(equalTo: requirementLabel.topAnchor, constant: -10),
            
            requirementLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            requirementLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            requirementLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            
            responsibilityLabel.topAnchor.constraint(equalTo: requirementLabel.bottomAnchor, constant: 10),
            responsibilityLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            responsibilityLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
        ])
    }
}
