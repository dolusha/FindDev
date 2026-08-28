//
//  ViewController.swift
//  FindDev
//
//  Created by mac on 28.08.2026.
//

import UIKit

class ViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Find developer"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter username"
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.backgroundColor = .none
        searchBar.layer.cornerRadius = 20
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.clearButtonMode = .whileEditing
        }
        return searchBar
    }()
    private let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        hideKeyboardWhenTappedAround()
        setupUI()
    }
    private func setupGradientBackground() {
        gradientLayer.colors = [
            UIColor(hex: "158e").cgColor,
            UIColor(hex: "AD57CE").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 50),

        ])
    }

}
extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}
