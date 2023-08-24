//
//  RecordsTableView.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 13.08.2023.
//

import Foundation
import SpriteKit

class RecordsTableView: UITableView {
    
    let userDefaultsManager: UserDefaultsProtocol = UserDefaultsManager()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDataSource() -> [RecordModel] {
        return userDefaultsManager.loadRecords(keys: userDefaultsManager.key)
    }
}

extension RecordsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CellConstants.heightForRowAt
    }
}

extension RecordsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setupDataSource().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.reuseIdentifier, for: indexPath) as? RecordCell else {
            return UITableViewCell()
        }
        
        let model = setupDataSource()[indexPath.row]
        cell.configureCell(with: model)
        cell.backgroundColor = .clear
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        CellConstants.numberOfSections
    }
}
