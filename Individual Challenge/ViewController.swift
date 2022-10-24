//
//  ViewController.swift
//  Individual Challenge
//
//  Created by Israel Carvalho on 19/10/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var peixesGlobal: [Peixe] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let peixe = peixesGlobal[indexPath.row].species
//
        return cell
    }
    
//    var peixesGlobal: [Peixe2] = [
//        Peixe2(scientificName: "peixinho", species: "peixe", habitat: "água", img: UIImage(named: "peixe.png")!),
//        )
//    ]
    
    var tableview = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiPeixes = APIpeixe()
        apiPeixes.allfish(completion: { [weak self] peixes in
            self?.peixesGlobal = peixes
//            peixesGlobal = peixes
        })
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            tableview.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            tableview.heightAnchor.constraint(
                equalTo: view.heightAnchor
            ),
            tableview.widthAnchor.constraint(
                equalTo: view.widthAnchor
            )
        ])
    }


}

