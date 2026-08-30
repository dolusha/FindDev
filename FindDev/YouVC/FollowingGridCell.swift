//
//  FollowingGridCell.swift
//  FindDev
//
//  Created by mac on 30.08.2026.
//

import Foundation
import UIKit

class FollowingGridCell: UICollectionViewCell {
    private lazy var boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 40
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        contentView.addSubview(boxView)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(loginLabel)
        
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: contentView.topAnchor),
            boxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            boxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            boxView.heightAnchor.constraint(equalTo: boxView.widthAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: boxView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: boxView.bottomAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: boxView.bottomAnchor, constant: 8),
            loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    func configure(login: String, avatarUrl: String) {
        loginLabel.text = "@\(login)"
        
        Task {
            guard let url = URL(string: avatarUrl) else { return }
            if let (data, _) = try? await URLSession.shared.data(from: url),
               let image = UIImage(data: data) {
                self.avatarImageView.image = image
            }
        }
    }
}
