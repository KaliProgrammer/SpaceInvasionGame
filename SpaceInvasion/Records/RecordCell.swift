//
//  RecordCell.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 13.08.2023.
//

import Foundation
import UIKit
import SnapKit

class RecordCell: UITableViewCell {
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: CellConstants.font, size: CellConstants.scoreFontSize)
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: CellConstants.font, size: CellConstants.userFontSize)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: CellConstants.font, size: CellConstants.dateFontSize)
        return label
    }()
    
    lazy var shipImage: UIImageView = {
        let shipImage = UIImageView()
        shipImage.layer.masksToBounds = true
        shipImage.clipsToBounds = true
        return shipImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }
    
    private func setupLabels() {
        contentView.addSubview(scoreLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(shipImage)
        
        shipImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(CellConstants.width)
            make.top.equalTo(contentView.snp.top).offset(CellConstants.top)
            make.height.equalTo(CellConstants.height)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalTo(shipImage.snp.trailing).offset(CellConstants.leading)
            make.width.equalTo(CellConstants.width)
            make.top.equalTo(contentView.snp.top).offset(CellConstants.top)
            make.height.equalTo(CellConstants.height)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(scoreLabel.snp.trailing).offset(CellConstants.leading)
            make.trailing.equalTo(dateLabel.snp.leading).offset(-CellConstants.leading)
            make.top.equalTo(contentView.snp.top).offset(CellConstants.top)
            make.height.equalTo(CellConstants.height)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(userNameLabel.snp.trailing).offset(CellConstants.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.top.equalTo(contentView.snp.top).offset(CellConstants.top)
        }
    }
    
    override func prepareForReuse() {
        scoreLabel.text = nil
        userNameLabel.text = nil
        dateLabel.text = nil
    }
    
    func configureCell(with model: RecordModel) {
        dateLabel.text = model.date
        userNameLabel.text = model.userName
        scoreLabel.text = "\(model.score ?? 0)"
        shipImage.image = UIImage(named: model.ship ?? "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
