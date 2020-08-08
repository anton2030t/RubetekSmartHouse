//
//  IntercomViewController.swift
//  RubetekSmartHouse
//
//  Created by Anton Larchenko on 08.08.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit

class IntercomViewController: UIViewController {

    var intercomList = [Intercom]()

    private let webManager = WebManager()

    @IBOutlet weak var intercomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        intercomTableView.register(UINib(nibName: IntercomCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: IntercomCell.identifier)
        
        response()
    }

    func response() {
        webManager.loadData { [weak self] (intercoms) in
            self?.intercomList += intercoms
            DispatchQueue.main.async {
                self?.intercomTableView.reloadData()
            }
        }
    }

}

extension IntercomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intercomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IntercomCell.identifier) as! IntercomCell
        let model = intercomList[indexPath.row]
        let url = URL(string: model.snapshot)!
        
        func setupCell(image: UIImage) {
            cell.dateLabel.text = model.notifiedAt
            cell.durationLabel.text = "3" // String(Int(model.finishedAt)! - Int(model.notifiedAt)!)
            cell.intercomLabel.text = String(model.id)
            cell.setScreenshotImage(image: image)
            if model.pickedupAt?.isEmpty != nil {
                cell.callIconImageView.image = UIImage(named: "call2")
            }
        }
        
        if let image = model.image {
            setupCell(image: image)
        } else {
            cell.task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let data = data, let imageData = UIImage(data: data) {
                    DispatchQueue.main.async {
                        setupCell(image: imageData)
                        model.image = imageData
                        tableView.reloadData()
                    }
                }
            }
            cell.task?.resume()
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = intercomList[indexPath.row]
        let vc = DetailViewController()
        vc.publicImage = model.image
        model.delegate = vc
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
