//
//  GitHubUserCell.swift
//  FindDev
//
//  Created by mac on 28.08.2026.
//

import Foundation
import UIKit
import SwiftUI
class GitHubUserCell: UITableViewCell {
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    private lazy var statsLabel: UILabel = {
        let statsLabel = UILabel()
        statsLabel.textColor = .darkGray
        statsLabel.font = .systemFont(ofSize: 14, weight: .medium)
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        return statsLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
    private func setupUI() {
        backgroundColor = .black
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(loginLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statsLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            
            loginLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            loginLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 4),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            statsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            statsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    func configure(with user: GitHubUser) {
        let loginLabel = user.login
        let nameLabel = user.name ?? "Unknown"
        let statsLabel = "\(user.followers) followers · \(user.following) following"
        
        Task {
            guard let url = URL(string: user.avatarUrl) else { return }
            if let (data, _) = try? await URLSession.shared.data(from: url),
               let image = UIImage(data: data) {
                self.imageView?.image = image
            }
        }
    }
}

