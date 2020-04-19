//
//  ListViewController.swift
//  palette
//
//  Created by Sam on 4/6/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import UIKit

class ListPhotoViewController: UIViewController {
    lazy var photos:[Photo] = PhotoManager.shared.photos

    @IBOutlet var tbPhoto:UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ListPhotoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier(), for: indexPath) as? PhotoCell
        cell!.loadData(photo: photos[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard!.instantiateViewController(withIdentifier: "ImageCVIdentifier") as? ImageViewController else {
            return
        }
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.photo = photos[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}
