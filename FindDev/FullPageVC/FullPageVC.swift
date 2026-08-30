//
//  FullPageVC.swift
//  FindDev
//
//  Created by mac on 29.08.2026.
//

import Foundation
import UIKit
import SwiftData
class FullPageVC: UIViewController {
    let login: String
    let modelContext: ModelContext
    
    var user: GitHubUser?
    var followingList: [GitHubFollowItem] = []
    var followersList: [GitHubFollowItem] = []
    var isSubscribed = false
    
    init(login: String, modelContext: ModelContext) {
        self.login = login
        self.modelContext = modelContext
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: UI
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var contentContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var backButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "chevron.left")
        config.baseBackgroundColor = .black.withAlphaComponent(0.3)
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var avatarImageView: UIImageView = {
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
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(subscribeTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var followingTitleLabel = makeSectionTitle(text: "Following")
    lazy var followersTitleLabel = makeSectionTitle(text: "Followers")
    
    private func makeSectionTitle(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    lazy var followingCollectionView = makeHorizontalCollection()
    lazy var followersCollectionView = makeHorizontalCollection()
    
    private func makeHorizontalCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 90, height: 130)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(FollowingGridCell.self, forCellWithReuseIdentifier: "FollowingGridCell")
        return collection
    }

    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(colors: [UIColor(hex: "480A54"), UIColor(hex: "AD57CE")])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    // MARK: setup
    
    
    
    // MARK: Data
    private func loadData() {
        isSubscribed = SubscriptionService.isFollowed(login: login, context: modelContext)
        subscribeButton.configureSubscribeStyle(isFollowed: isSubscribed)
        
        Task {
            do {
                async let profile = FindGitHubService.fetchUser(for: login)
                async let following = FindGitHubService.fetchFollowing(login: login)
                async let followers = FindGitHubService.fetchFollowers(login: login)
                
                let (loadedUser, loadedFollowing, loadedFollowers) = try await (profile, following, followers)
                
                self.user = loadedUser
                self.followingList = loadedFollowing
                self.followersList = loadedFollowers
                
                self.usernameLabel.text = "@\(loadedUser.login)"
                self.followingCollectionView.reloadData()
                self.followersCollectionView.reloadData()
                
                if let url = URL(string: loadedUser.avatarUrl),
                   let (data, _) = try? await URLSession.shared.data(from: url),
                   let image = UIImage(data: data) {
                    self.avatarImageView.image = image
                }
            } catch {
                print("Error with loading profile: \(error)")
            }
        }
    }
    
    // MARK: Action
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func subscribeTapped() {
        guard let user = user else { return }
        isSubscribed.toggle()
        subscribeButton.configureSubscribeStyle(isFollowed: isSubscribed)
        SubscriptionService.toggle(login: user.login, avatarUrl: user.avatarUrl, isFollowed: isSubscribed, context: modelContext)
    }
}
