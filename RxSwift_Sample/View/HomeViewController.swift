//
//  HomeViewController.swift
//  RxSwift_Sample
//
//  Created by Shuhei Ota on 2022/03/09.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private var titleLabel = UILabel()
    private var textField = UITextField()
    private var changeButton = UIButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        // タイトルラベル
        titleLabel.text = "テスト"
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // -------- テキストフィールド --------
        self.view.addSubview(textField)
        textField.text = "テキストフィールド"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor ,constant: 50).isActive = true
        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // テキストフィールドに入力された文字列をtitleLabelに反映
        textField.rx.text.orEmpty
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        
        // -------- テキストフィールド --------
        
        
        // 選択ボタン
        changeButton.setTitle("選択", for: .normal)
        changeButton.setTitleColor(.gray, for: .normal)
        changeButton.layer.borderWidth = 1
        changeButton.layer.cornerRadius = 10
        changeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        self.view.addSubview(changeButton)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        changeButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        changeButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        changeButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50).isActive = true
        changeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        changeButton.rx.tap.subscribe(
            onNext: {
                print("tap changeButton")
                self.titleLabel.text = "テスト1"
            }
        ).disposed(by: disposeBag)
        
        print("HomeVC End")
    }
    
}
