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
    private var moveButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        // タイトルラベル
        titleLabel.text = "ラベル"
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
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
        
        // -------- 選択ボタン --------
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
        changeButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 100).isActive = true
        
        changeButton.rx.tap.subscribe(
            onNext: {
                print("tap changeButton")
                self.titleLabel.text = "テスト1"
            }
        ).disposed(by: disposeBag)
        // -------- 選択ボタン --------
        
        // -------- 画面遷移ボタン（TODOアプリ画面へ遷移）--------
        moveButton.setTitle("画面遷移", for: .normal)
        moveButton.setTitleColor(.gray, for: .normal)
        moveButton.layer.borderWidth = 1
        moveButton.layer.cornerRadius = 10
        moveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        self.view.addSubview(moveButton)
        moveButton.translatesAutoresizingMaskIntoConstraints = false
        moveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        moveButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        moveButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        moveButton.topAnchor.constraint(equalTo: changeButton.bottomAnchor, constant: 50).isActive = true
        
        moveButton.rx.tap.subscribe(
            onNext: {
                print("tap moveButton")
                self.titleLabel.text = "画面遷移"
                let todoVC = TodoHomeViewController()
                let todoNavigationController = UINavigationController(rootViewController: todoVC)
                todoNavigationController.modalPresentationStyle = .fullScreen
                self.present(todoNavigationController, animated: true, completion: nil)
            }
        ).disposed(by: disposeBag)
        
        // -------- 画面遷移ボタン（TODOアプリ画面へ遷移）--------
    }
}
