//
//  TodoTableViewCell.swift
//  RxSwift_Sample
//
//  Created by Shuhei Ota on 2022/03/15.
//

import UIKit
import RxSwift
import RxCocoa

struct Item {
    let name: String
    let color: UIColor
}

class TodoTableViewCell: UITableViewCell {
    
    private var titleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpInit() {
        // カスタムセルにタイトルラベルをセット
        titleLabel.textColor = .black
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5).isActive = true        
    }
    
    // cell（行）の設定
    func configure(item: Item) {
        titleLabel.text = item.name
        backgroundColor = item.color
    }
    
}
