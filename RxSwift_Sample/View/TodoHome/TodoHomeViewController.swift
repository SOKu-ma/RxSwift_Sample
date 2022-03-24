//
//  TodoHomeViewController.swift
//  RxSwift_Sample
//
//  Created by Shuhei Ota on 2022/03/13.
//

import UIKit
import RxSwift
import RxCocoa

class TodoHomeViewController: UIViewController {
    
    private var tableView = UITableView()
    private var navigationBar = UINavigationBar()
    private var closeBarButton = UIBarButtonItem()
    
    private let disposeBag = DisposeBag()
    
    private let items: Observable<[Item]> = .just([Item(name: "AAA", color: .red),
                                                   Item(name: "BBB", color: .blue),
                                                   Item(name: "CCC", color: .green),
                                                  ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        // ------- navigationBar -------
        self.view.addSubview(navigationBar)
        closeBarButton.image = UIImage(systemName: "xmark")
        self.navigationItem.leftBarButtonItem = closeBarButton
        
        closeBarButton.rx.tap.subscribe(
            onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        // ------- navigationBar -------
        
        // ------- TableView -------
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        // ------- TableView -------
        // カスタムセルをTableViewにセット
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "todoCell")
        tableView.rowHeight = 50
        
        let dataSource = TodoListDataSource()
        
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        // ------- TableView -------
        
    }
}

// dataSource
final class TodoListDataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {
    typealias Element = [Item]
    var items = [Item]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell",
                                                 for: indexPath) as! TodoTableViewCell
        let item = items[indexPath.row]
        cell.configure(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[Item]>) {
        Binder(self) { dataSource, element in
            guard let items = element.element else { return }
            dataSource.items = items
            tableView.reloadData()
        }
        .onNext(observedEvent)
    }
    
}
