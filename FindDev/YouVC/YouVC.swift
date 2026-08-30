//
//  YouVC.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
import UIKit
import SwiftData
class YouVC: UIViewController {
    let modelContext: ModelContext
    var followedUsers: [FollowedUser] = []
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    lazy var contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        iv.backgroundColor = .systemGray3
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@dolusha"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "My following"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 16
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(FollowingGridCell.self, forCellWithReuseIdentifier: "FollowingGridCell")
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMyAvatar()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(colors: [UIColor(hex: "480A54"), UIColor(hex: "AD57CE")])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadFollowedUsers()
    }
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentContainer)
        
        contentContainer.addSubview(titleLabel)
        contentContainer.addSubview(profileImageView)
        contentContainer.addSubview(usernameLabel)
        contentContainer.addSubview(followingTitleLabel)
        contentContainer.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20),
            
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            profileImageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20),
            profileImageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -20),
            profileImageView.heightAnchor.constraint(equalToConstant: 220),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            usernameLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            
            followingTitleLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 24),
            followingTitleLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: followingTitleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 800),
            collectionView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -20),
        ])
    }
    func loadFollowedUsers() {
        let descriptor = FetchDescriptor<FollowedUser>()
        followedUsers = (try? modelContext.fetch(descriptor)) ?? []
        collectionView.reloadData()
    }
    private func loadMyAvatar() {
        Task {
            do {
                let user = try await FindGitHubService.fetchUser(for: "dolusha")
                guard let url = URL(string: user.avatarUrl) else { return }
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    self.profileImageView.image = image
                }
            } catch {
                print(error)
            }
        }
    }
}
